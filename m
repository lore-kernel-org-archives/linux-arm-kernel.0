From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Dec 2012 10:01:27 -0700
Subject: [PATCH 2/2] ARM: tegra: moving the clock gating procedure to
 tegra_cpu_kill
In-Reply-To: <1355970519-28200-2-git-send-email-josephl@nvidia.com>
References: <1355970519-28200-1-git-send-email-josephl@nvidia.com>
 <1355970519-28200-2-git-send-email-josephl@nvidia.com>
Message-ID: <50D34467.9000006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2012 07:28 PM, Joseph Lo wrote:
> The tegra_cpu_die was be executed by the CPU itslf. So the clock gating
> procedure won't be executed after the CPU hardware shutdown code. Moving
> the clock gating procedure to tegra_cpu_kill that will be run by another
> CPU after the CPU died.

Hmmm. I wonder if this is enough to make kexec-on-Tegra-with-SMP-enabled
work without explicitly hot-unplugging all the CPUs first... An
implementation of cpu_kill() was a major part of what was missing. I
thought an implementation of cpu_kill() would require a bunch of code
from cpu_die() too. Does this patch assume cpu_die() has executed first,
and only then cpu_kill() will work, or can cpu_kill() be used on its own?

> diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c

> @@ -34,10 +45,6 @@ void __ref tegra_cpu_die(unsigned int cpu)
>  	/* Shut down the current CPU. */
>  	tegra_hotplug_shutdown();
>  
> -	/* Clock gate the CPU */
> -	tegra_wait_cpu_in_reset(cpu);
> -	tegra_disable_cpu_clock(cpu);

I believe that's the last use of the calculation performed right at the
start of this function:

        cpu = cpu_logical_map(cpu);

Can you remove that?

Also, Peter, can you review these 2 patches as well?
