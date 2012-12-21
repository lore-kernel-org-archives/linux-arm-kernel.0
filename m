From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 21 Dec 2012 17:58:17 +0800
Subject: [PATCH 2/2] ARM: tegra: moving the clock gating procedure to
 tegra_cpu_kill
In-Reply-To: <50D34467.9000006@wwwdotorg.org>
References: <1355970519-28200-1-git-send-email-josephl@nvidia.com>
 <1355970519-28200-2-git-send-email-josephl@nvidia.com>
 <50D34467.9000006@wwwdotorg.org>
Message-ID: <1356083897.26029.187.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-21 at 01:01 +0800, Stephen Warren wrote:
> On 12/19/2012 07:28 PM, Joseph Lo wrote:
> > The tegra_cpu_die was be executed by the CPU itslf. So the clock gating
> > procedure won't be executed after the CPU hardware shutdown code. Moving
> > the clock gating procedure to tegra_cpu_kill that will be run by another
> > CPU after the CPU died.
> 
> Hmmm. I wonder if this is enough to make kexec-on-Tegra-with-SMP-enabled
> work without explicitly hot-unplugging all the CPUs first... An
> implementation of cpu_kill() was a major part of what was missing. I
> thought an implementation of cpu_kill() would require a bunch of code
> from cpu_die() too. Does this patch assume cpu_die() has executed first,
> and only then cpu_kill() will work, or can cpu_kill() be used on its own?
> 
Yes, the tegra_cpu_die must be run first then tegra_cpu_kill. Because
the tegra_cpu_die shutdown the CPU by itself, then we can clock gate the
CPU in tegra_cpu_kill. If the tegra_cpu_kill be run itself, the system
will be hung in wait_for_reset(CPU).

About the kexec issue, it's complicate. Your solution should be the
right solution. And we should implement the hardware shutdown code in
cpu_die not cpu_kill. I suspect this issue can be reproduced on all ARM
platform. Because the smp_send_stop can't really shutdown the secondary
CPU core if just call machine_shutdown without disable_nonboot_cpu. And
in platform_shutdown and platform_reboot case, the secondary CPU already
been offlined and killed before this function be called. Does any other
ARM SMP platform can run kexec without any issue?

(I will check if we can do some HW shutdown in tegra_cpu_kill. For ex,
just clock gate the CPU without wait_for_reset.)

Thanks,
Joseph
