From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 20:57:35 +0100
Subject: [PATCH] ARM: smp: call platform's cpu_die in ipi_cpu_stop
In-Reply-To: <51704D31.10808@bracey.fi>
References: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
 <1365251824-4852-2-git-send-email-kevin@bracey.fi>
 <20130418171801.GC14496@n2100.arm.linux.org.uk>
 <20130418182534.GD14496@n2100.arm.linux.org.uk> <51704D31.10808@bracey.fi>
Message-ID: <20130418195735.GF14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 10:44:49PM +0300, Kevin Bracey wrote:
> On 18/04/2013 21:25, Russell King - ARM Linux wrote:
>> Now, with this patch applied, we guarantee that we push out any data  
>> that matters from the dying CPU before platform_cpu_kill() is called.  
>> That should mean that shmobile can remove that whole cpu_dead thing.
>
> Patch looks supremely sensible. Clearly there is more centralisation  
> needed for the generic cache issue, and that addresses the currently  
> upstream shmobile stuff.
>
> But I had also been intending to have "post-kill" co-ordination for  
> power control and error reporting. Something along the lines of:
>
> 1) cpu_die tells the power hardware to shut down the core on next  
> STANDBYWFI assertion, then does the final chip-specific clear-up, then 
> WFI.
>
> 2) cpu_kill waits for the power hardware to report shutdown of that  
> core, and reports success, or failure after timeout.
>
> That seemed logical, but it just doesn't fly when cpu_kill routinely  
> occurs without cpu_die. We again end up timing out (once per CPU) in  
> that case, which can add a significant time to panic/shutdown.
>
> Am I on the right lines here, or misunderstanding? It seems like a  
> pretty natural thing to attempt. And it would have worked fine before  
> the die-less kill was added to smp_send_stop.

Well, the idea as far as hotplug CPU is concerned is that we guarantee
in core code that platform_cpu_kill() will not be called until it is
safe for the dying CPU to be powered off - so the synchronisation is
done by the core code.  That's always been what the completion stuff
is about in arch/arm/kernel/smp.c.

It was missing the cache bits because (a) the ARM development platforms
don't actually take the CPUs offline, and (b) we never really had an
API at the time hotplug CPU was designed to flush just the local CPUs
L1 cache.

Now, practically, most platforms which cut power/clocks to the CPU do
it in one of two ways.  Either they do it in their cpu_die() callback,
via WFI, or they do it from a running CPU via the cpu_kill() callback.

Either way, platforms are not expected to have any further
synchronisation.  Once that complete() call has returned, the dying
CPU is expected to become dead very shortly after that point - whether
that be as a result of cpu_kill() or cpu_die().

> If anyone ever has both die and kill implemented and doing something in  
> a platform, they will have to have some sort of co-ordination, as  
> there's a race for kill running before die is finished. (Although it  
> could be that what they do is so simple/fast that die is "guaranteed" to  
> win the race). This patch takes the slow cache clean out, so solves it  
> for that, but the essential race problem remains for anything  
> platform-specific in cpu_die. So I still think every kill needs a die.  
> Unless you expect each platform to use only one of the hooks.

The whole point is to stop platforms having to implement synchronisation
in these callbacks, with all the bugs that will cause.  The patch I
posted took about an hour of thought and walking through, and discussion
with Will to make sure that all issues had been covered.  Taking a CPU
offline safely is far from trivial, and the less code that a platform
has to do the better.

Now, as for the stop IPI, what we do there is debatable, because that
gets used for several purposes, which includes a bringing the machine
to a halt after a kernel panic.  In those situations, doing the
synchronisation is not appropriate, because we may be panicing because
something has gone wrong in the scheduler.  So, solving that part
safely is going to be far from trivial.

The whole idea there at the _moment_ is that it's safer to make the CPU
core spin, and _maybe_ have it powered down by the kill stuff than it
is to try and call out to platform code.  But that's not what kexec
needs - that needs the CPU cores thrown back into a state as if the
system was first booting.  Some platforms can do that, others have
absolutely no way to do that.  This is _very_ hit and miss on what's
possible.
