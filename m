From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 05 Jun 2013 12:09:11 +0100
Subject: Cache issues in vexpress cpu shutdown (regression in 3.10)
Message-ID: <1370430551.3387.11.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been investigating why reboot fails on Versatile Express with the
CA9x4 CoreTile and the problem seems to get triggered by commit bca7a5a0
(ARM: cpu hotplug: remove majority of cache flushing from platforms).

Putting back the flush_cache_all() removed by this patch in
mach-vexpress/hotplug.c gets reboot working again. Without that I see
the following during shutdown:

CPU 2 is in _cpu_down called from disable_nonboot_cpus, and is spinning
in the loop:

	while (!idle_cpu(cpu))
		cpu_relax();

cpu == 1 here and idle_cpu() is constantly returning false because
rq->curr != rq->idle and it looks like the runqueue has one process:
that which issued the 'reboot' command.

CPU 1 is spinning in platform_do_lowpower and waiting for pen release to
equal 1 (it's -1). Looks like it got there via the smp_ops.cpu_die(cpu)
call in cpu_die.

CPU 0 and 3 are at wfi in cpu_v7_do_idle

Sometimes I see a different symptoms where it appears that some CPUs
reboot whilst the system still hasn't shut down. (Possibly because it
is returning from cpu_die and jumping to secondary_start_kernel?)

The cache flushing for cpu_die was moved to generic code by the commit
previous to the one mentioned above, i.e. 51acdfd1 (ARM: smp: flush L1
cache in cpu_die()). This added flush_cache_louis to the generic code so
I thought I would see what replacing these with flush_cache_all would
do...

Replacing the first flush_cache_louis in cpu_die with flush_cache_all
allows reboot to happen, but I see

   * Will now restart
  CPU1: cpu didn't die
  CPU2: cpu didn't die
  CPU3: cpu didn't die
  Restarting system.

Speculation: means the complete(&cpu_died) after that cache flush didn't
get seen?

Replacing the second flush_cache_louis instead makes every work fine; as
we would expect as it is equivalent to putting original flush_cache_all
back in the vexpress code.

I'm a bit stumped by all this as I don't see why flush_cache_louis is
apparently insufficient to get changes on one core seen by the other.

-- 
Tixy
