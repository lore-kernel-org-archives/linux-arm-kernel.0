From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Jun 2013 12:50:46 +0100
Subject: Cache issues in vexpress cpu shutdown (regression in 3.10)
In-Reply-To: <20130605113912.GE18614@n2100.arm.linux.org.uk>
References: <1370430551.3387.11.camel@linaro1.home>
 <20130605113912.GE18614@n2100.arm.linux.org.uk>
Message-ID: <20130605115046.GA11402@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 12:39:12PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 05, 2013 at 12:09:11PM +0100, Jon Medhurst (Tixy) wrote:
> > I've been investigating why reboot fails on Versatile Express with the
> > CA9x4 CoreTile and the problem seems to get triggered by commit bca7a5a0
> > (ARM: cpu hotplug: remove majority of cache flushing from platforms).
> > 
> > Putting back the flush_cache_all() removed by this patch in
> > mach-vexpress/hotplug.c gets reboot working again. Without that I see
> > the following during shutdown:
> > 
> > CPU 2 is in _cpu_down called from disable_nonboot_cpus, and is spinning
> > in the loop:
> > 
> > 	while (!idle_cpu(cpu))
> > 		cpu_relax();
> > 
> > cpu == 1 here and idle_cpu() is constantly returning false because
> > rq->curr != rq->idle and it looks like the runqueue has one process:
> > that which issued the 'reboot' command.
> > 
> > CPU 1 is spinning in platform_do_lowpower and waiting for pen release to
> > equal 1 (it's -1). Looks like it got there via the smp_ops.cpu_die(cpu)
> > call in cpu_die.
> 
> This sounds like CPU2 hasn't seen the updates to CPU1 inspite of pushing
> the contents of CPU1's cache out to point of unification in the inner
> sharable domain (the point where all CPUs should see the same view.)
> 
> Are you able to look at what's visible in the caches for both CPUs for
> things like rq->curr for CPU 1?
> 
> I wonder if - even though we've pushed it out of CPU 1's local cache,
> whether there's still something to do with the coherency stuff which
> remains incomplete.
> 
> Either way, this has significant implications for everyone who uses
> flush_cache_louis() in paths where the CPU loses state - it means that
> something is wrong with the way data is pushed out of the CPU.
> 
> > I'm a bit stumped by all this as I don't see why flush_cache_louis is
> > apparently insufficient to get changes on one core seen by the other.
> 
> Could it be that flush_cache_louis() doesn't actually do what it claims
> to?

Smells like erratum #643719, which was fixed in r1p0 of A9. The LoUIS value
in the CLIDR reports 0 instead of 1.

Tixy -- if you can confirm the above (i.e. your register has the wrong
value) then we can come up with a workaround. I'm not sure whether any
platforms other than vexpress have such an early A9 revision though...

Will
