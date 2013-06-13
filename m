From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 13 Jun 2013 09:58:54 +0800
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAMj5BkiV29fWkk6k_Q=5ThSS-4hitvNZv0MFi86f5O=1Ma3Dhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 4:01 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Add comments to machine_shutdown()/halt()/power_off()/restart() that
> describe their purpose and/or requirements re: CPUs being active/not.
>
> In machine_shutdown(), replace the call to smp_send_stop() with a call to
> disable_nonboot_cpus(). This completely disables all but one CPU, thus
> satisfying the requirement that only a single CPU be active for kexec.
> Adjust Kconfig dependencies for this change.
>
> In machine_halt()/power_off()/restart(), call smp_send_stop() directly,
> rather than via machine_shutdown(); these functions don't need to
> completely de-activate all CPUs using hotplug, but rather just quiesce
> them.
>
> Remove smp_kill_cpus(), and its call from smp_send_stop().
> smp_kill_cpus() was indirectly calling smp_ops.cpu_kill() without calling
> smp_ops.cpu_die() on the target CPUs first. At least some implementations
> of smp_ops had issues with this; it caused cpu_kill() to hang on Tegra,
> for example. Since smp_send_stop() is only used for shutdown, halt, and
> power-off, there is no need to attempt any kind of CPU hotplug here.
>

Hi, Setphen

We also met the issue: fail to reboot system from panic.
Solve it by the following change.

cpu_die is function kill cpu itself
cpu_kill is functoin to check whethe the cpu is dead or not

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index e171a0e..624e97c 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -554,6 +554,9 @@ static void ipi_cpu_stop(unsigned int cpu)
        local_fiq_disable();
        local_irq_disable();

+#ifdef CONFIG_HOTPLUG_CPU
+       cpu_die();
+#endif
        while (1)
                cpu_relax();
 }

What do you think?

Thanks
