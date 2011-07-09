From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 15:32:52 +0100
Subject: [PATCH 04/17] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <20110709104408.GK4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-5-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709104408.GK4812@n2100.arm.linux.org.uk>
Message-ID: <20110709143252.GL4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 09, 2011 at 11:44:08AM +0100, Russell King - ARM Linux wrote:
> We need to sort this out so we have a _sane_ approach to this, rather
> than inventing more and more creative ways to save VFP state and
> restore it later.

And here, let's prove that the current code is just soo bloody complex
that it needs redoing.  In the following code, 'last_VFP_context' is
renamed to 'vfp_current_hw_state' for clarity.

void vfp_sync_hwstate(struct thread_info *thread)
{
        unsigned int cpu = get_cpu();

        /*
         * If the thread we're interested in is the current owner of the
         * hardware VFP state, then we need to save its state.
         */
        if (vfp_current_hw_state[cpu] == &thread->vfpstate) {
                u32 fpexc = fmrx(FPEXC);

                /*
                 * Save the last VFP state on this CPU.
                 */
                fmxr(FPEXC, fpexc | FPEXC_EN);
                vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);
                fmxr(FPEXC, fpexc);
        }

Here, 'thread' is the thread we're interested in ensuring that we have
up to date context in thread->vfpstate.  On entry to this function, we
can be running on any CPU in the system, and 'thread' could have been
running on any other CPU in the system.

What this code is saying is: if the currrent CPU's hardware VFP state was
owned by this thread, then update the current VFP state.  So far it looks
sane.

Now, lets consider what with thread migration.  First, lets define three
threads.

Thread 1, we'll call 'interesting_thread' which is a thread which is
running on CPU0, using VFP (so vfp_current_hw_state[0] =
&interesting_thread->vfpstate) and gets migrated off to CPU1, where
it continues execution of VFP instructions.

Thread 2, we'll call 'new_cpu0_thread' which is the thread which takes
over on CPU0.  This has also been using VFP, and last used VFP on CPU0,
but doesn't use it again.

The following code will be executed twice:

                cpu = thread->cpu;

                /*
                 * On SMP, if VFP is enabled, save the old state in
                 * case the thread migrates to a different CPU. The
                 * restoring is done lazily.
                 */
                if ((fpexc & FPEXC_EN) && vfp_current_hw_state[cpu]) {
                        vfp_save_state(vfp_current_hw_state[cpu], fpexc);
                        vfp_current_hw_state[cpu]->hard.cpu = cpu;
                }
                /*
                 * Thread migration, just force the reloading of the
                 * state on the new CPU in case the VFP registers
                 * contain stale data.
                 */
                if (thread->vfpstate.hard.cpu != cpu)
                        vfp_current_hw_state[cpu] = NULL;

The first execution will be on CPU0 to switch away from 'interesting_thread'.
interesting_thread->cpu will be 0.

So, vfp_current_hw_state[0] points at interesting_thread->vfpstate.
The hardware state will be saved, along with the CPU number (0) that
it was executing on.

'thread' will be 'new_cpu0_thread' with new_cpu0_thread->cpu = 0.
Also, because it was executing on CPU0, new_cpu0_thread->vfpstate.hard.cpu = 0,
and so the thread migration check is not triggered.

This means that vfp_current_hw_state[0] remains pointing at interesting_thread.

The second execution will be on CPU1 to switch _to_ 'interesting_thread'.
So, 'thread' will be 'interesting_thread' and interesting_thread->cpu now
will be 1.  The previous thread executing on CPU1 is not relevant to this
so we shall ignore that.

We get to the thread migration check.  Here, we discover that
interesting_thread->vfpstate.hard.cpu = 0, yet interesting_thread->cpu is
now 1, indicating thread migration.  We set vfp_current_hw_state[1] to
NULL.

So, at this point vfp_current_hw_state[] contains the following:

[0] = interesting_thread
[1] = NULL

Our interesting thread now executes a VFP instruction, takes a fault
which loads the state into the VFP hardware.  Now, through the assembly
we now have:

[0] = interesting_thread
[1] = interesting_thread

CPU1 stops due to ptrace (and so saves its VFP state) using the thread
switch code above), and CPU0 calls vfp_sync_hwstate().

        if (vfp_current_hw_state[cpu] == &thread->vfpstate) {
                vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);

BANG, we corrupt interesting_thread's VFP state by overwriting the
more up-to-date state saved by CPU1 with the old VFP state from CPU0.

I think this is not the only problem with this code, and it's in
desperate need of being cleaned up.  Until such time, adding more
state saving code is just going to be extremely hairy.

Finally, as far as saving state for _idle_ goes (in other words, while
the CPU's idle loop in cpu_idle() is running), take a moment to consider
the following: the idle thread being a kernel thread does not use VFP.
It has no useful VFP state.  So:

1. On SMP, because we've switched away from any userland thread, we have
   already saved its state when we switched away.

   If VFP hardware state is lost across an idle, the only thing that needs
   doing is that fact noted by setting vfp_current_hw_state[cpu] for the
   CPUs which lost VFP state to NULL.  No state saving is required.

2. On UP, the VFP hardware may contain the current threads state, which,
   if state is lost, would need to be saved _IF_ vfp_current_hw_state[cpu]
   is non-NULL.  Again, if state is lost, then vfp_current_hw_state[cpu]
   needs to be NULL'd.

These conditions won't change as a result of cleaning up the hairyness
of the existing code.
