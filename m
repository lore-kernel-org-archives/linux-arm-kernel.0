From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Nov 2014 15:12:21 +0100
Subject: [PATCH 14/17] ARM: mvebu: synchronize secondary CPU clocks on
 resume
In-Reply-To: <1414151970-6626-15-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-15-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5460C7C5.7060007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
On 24/10/2014 13:59, Thomas Petazzoni wrote:
> The Armada XP has multiple cores clocked by independent clocks. The
> SMP startup code contains a function called set_secondary_cpus_clock()
> called in armada_xp_smp_prepare_cpus() to ensure the clocks of the
> secondary CPUs match the clock of the boot CPU.
> 
> With the introduction of suspend/resume, this operation is no longer
> needed when booting the system, but also when existing the suspend to
> RAM state. Therefore this commit reworks a bit the logic: instead of
> configuring the clock of all secondary CPUs in
> armada_xp_smp_prepare_cpus(), we do it on a per-secondary CPU basis in
> armada_xp_boot_secondary(), as this function gets called when existing
> suspend to RAM for each secondary CPU.
> 
> Since the function now only takes care of one CPU, we rename it from
> set_secondary_cpus_clock() to set_secondary_cpu_clock(), and it looses
> its __init marker, as it is now used beyond the system initialization.
> 
> Note that we can't use smp_processor_id() directly, because when
> exiting from suspend to RAM, the code is apparently executed with
> preemption enabled, so smp_processor_id() is not happy (prints a
> warning). We therefore switch to using get_cpu()/put_cpu(), even
> though we pretty much have the guarantee that the code starting the
> secondary CPUs is going to run on the boot CPU and will not be
> migrated.
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/platsmp.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
