From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 14:52:52 +0100
Subject: Possible race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM?
In-Reply-To: <20160530224028.GT19428@n2100.arm.linux.org.uk>
References: <574C7CDB.7050103@ericsson.com>
 <20160530213529.GS19428@n2100.arm.linux.org.uk>
 <20160530224028.GT19428@n2100.arm.linux.org.uk>
Message-ID: <20160531135251.GK24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 11:40:28PM +0100, Russell King - ARM Linux wrote:
> On Mon, May 30, 2016 at 10:35:29PM +0100, Russell King - ARM Linux wrote:
> > With that, on a single CPU, it seems to work correctly every time, but
> > if I bring up a secondary CPU I start seeing the same problems you've
> > reported - which seems to need the following patch to solve.  Please can
> > you check whether this resolves your problem?
> 
> More background behind this patch... I think that commit 8130b9d7b9d8
> ("ARM: 7308/1: vfp: flush thread hwstate before copying ptrace registers")
> was wrong.
> 
> Let's look at what's happening.  The above commit had the following effect:
> 
> 	vfp_sync_hwstate();
> 	new_vfp = thread->vfpstate.hard;
> 	modify new_vfp (but not new_vfp.cpu)
> +	vfp_flush_hwstate(thread);
> 	thread->vfpstate.hard = new_vfp;
> -	vfp_flush_hwstate(thread);
> 
> Now, the commit above claims that a context switch mid-copy of new_vfp
> into thread->vfpstate.hard may result in corrupted state.
> 
> I'm not quite sure how we could get to that point: the only thread which
> is allowed to touch the traced child's state is the ptracing parent, and
> the ptracing parent can't do anything until after vfp_set() has returned.
> Even if the traced child gets a fatal signal, the point at which the
> signal is delivered to the child is when returning to userspace, which
> means the child must be runnable.  That in turn means that we are not
> in the middle of changing the register state.
> 
> So, I'm not sure where Will got the idea that the partially copied state
> would be visible: it shouldn't ever be visible.  If it is visible, then
> we've got problems even with Will's patch applied, because a partial
> copy whenever it happens would be visible.
> 
> In any case, the above change is wrong: vfp_flush_hwstate() sets
> thread->vfpstate.hard.cpu to an invalid CPU number.  Switching the order
> as Will has done _undoes_ the effect of vfp_flush_hwstate(), which leads
> to the bug you are seeing.
> 
> So, I think the correct approach is to revert it.

Yes, it looks like I was over-zealous in fixing all users of
vfp_flush_hwstate after I fixed the signal handling code. Given that the
child isn't runnable until the parent has finished poking at the register
state, the original code looks fine.

The only thing I'm uncertain of is whether or not PTRACE_SEIZE/PTRACE_LISTEN
allow switching to the child (but even then, how is the parent doing
to issue such a request?).

Will
