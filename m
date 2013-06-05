From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jun 2013 12:39:12 +0100
Subject: Cache issues in vexpress cpu shutdown (regression in 3.10)
In-Reply-To: <1370430551.3387.11.camel@linaro1.home>
References: <1370430551.3387.11.camel@linaro1.home>
Message-ID: <20130605113912.GE18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 12:09:11PM +0100, Jon Medhurst (Tixy) wrote:
> I've been investigating why reboot fails on Versatile Express with the
> CA9x4 CoreTile and the problem seems to get triggered by commit bca7a5a0
> (ARM: cpu hotplug: remove majority of cache flushing from platforms).
> 
> Putting back the flush_cache_all() removed by this patch in
> mach-vexpress/hotplug.c gets reboot working again. Without that I see
> the following during shutdown:
> 
> CPU 2 is in _cpu_down called from disable_nonboot_cpus, and is spinning
> in the loop:
> 
> 	while (!idle_cpu(cpu))
> 		cpu_relax();
> 
> cpu == 1 here and idle_cpu() is constantly returning false because
> rq->curr != rq->idle and it looks like the runqueue has one process:
> that which issued the 'reboot' command.
> 
> CPU 1 is spinning in platform_do_lowpower and waiting for pen release to
> equal 1 (it's -1). Looks like it got there via the smp_ops.cpu_die(cpu)
> call in cpu_die.

This sounds like CPU2 hasn't seen the updates to CPU1 inspite of pushing
the contents of CPU1's cache out to point of unification in the inner
sharable domain (the point where all CPUs should see the same view.)

Are you able to look at what's visible in the caches for both CPUs for
things like rq->curr for CPU 1?

I wonder if - even though we've pushed it out of CPU 1's local cache,
whether there's still something to do with the coherency stuff which
remains incomplete.

Either way, this has significant implications for everyone who uses
flush_cache_louis() in paths where the CPU loses state - it means that
something is wrong with the way data is pushed out of the CPU.

> I'm a bit stumped by all this as I don't see why flush_cache_louis is
> apparently insufficient to get changes on one core seen by the other.

Could it be that flush_cache_louis() doesn't actually do what it claims
to?
