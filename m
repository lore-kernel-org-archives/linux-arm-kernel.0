From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 May 2014 10:35:33 -0600
Subject: arm64: Fix machine_shutdown() definition
In-Reply-To: <1399391708-13442-1-git-send-email-arunks.linux@gmail.com>
References: <1399391708-13442-1-git-send-email-arunks.linux@gmail.com>
Message-ID: <53690F55.6030504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 09:55 AM, arunks.linux at gmail.com wrote:
> From: Arun KS <arun.linux@gmail.com>
> 
> machine_shutdown() is a hook for kexec. Add a comment saying so, since
> it isn't obvious from the function name.
> 
> Halt, power-off, and restart have different requirements re: stopping
> secondary CPUs than kexec has. The former simply require the secondary
> CPUs to be quiesced somehow, whereas kexec requires them to be
> completely non-operational, so that no matter where the kexec target
> images are written in RAM, they won't influence operation of the
> secondary CPUS,which could happen if the CPUs were still executing some
> kind of pin loop. To this end, modify machine_halt, power_off, and
> restart to call smp_send_stop() directly, rather than calling
> machine_shutdown().
> 
> In machine_shutdown(), replace the call to smp_send_stop() with a call
> to disable_nonboot_cpus(). This completely disables all but one CPU,
> thus satisfying the kexec requirements a couple paragraphs above.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Arun KS <getarunks@gmail.com>
> Signed-off-by: Arun KS <arunks.linux@gmail.com>

It's a bit odd to include my s-o-b here when I didn't actually write
this particular patch. No doubt it's included because I wrote an
identical patch for arch/arm/.

Rather than including my s-o-b here, perhaps simply including the
following paragraph in the commit decription would be better:

This patch ports most of commit 19ab428f4b79 "ARM: 7759/1: decouple CPU
offlining from reboot/shutdown" by Stephen Warren from arch/arm to
arch/arm64.

Or, I sometimes use the following tag instead of s-o-b:

Based-on-work-by: Stephen Warren <swarren@nvidia.com>

Including two s-o-b for yourself probably isn't necesary.

Do you need to include an equivalent of the following from my original
patch to arch/arm/?

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 239fa96c12bb..2651b1da1c56 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2016,7 +2016,7 @@ config XIP_PHYS_ADDR
>  
>  config KEXEC
>         bool "Kexec system call (EXPERIMENTAL)"
> -       depends on (!SMP || HOTPLUG_CPU)
> +       depends on (!SMP || PM_SLEEP_SMP)
>         help
>           kexec is a system call that implements the ability to shutdown your
>           current kernel, and to start another kernel.  It is like a reboot
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 8ef8c9337809..4fb074c446bf 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -134,6 +134,10 @@ void machine_kexec(struct kimage *image)
>         unsigned long reboot_code_buffer_phys;
>         void *reboot_code_buffer;
>  
> +       if (num_online_cpus() > 1) {
> +               pr_err("kexec: error: multiple CPUs still online\n");
> +               return;
> +       }
>  
>         page_list = image->head & PAGE_MASK;
>  
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 550d63cef68e..5919eb451bb9 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -651,17 +651,6 @@ void smp_send_reschedule(int cpu)
>         smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>  }
>  
> -#ifdef CONFIG_HOTPLUG_CPU
> -static void smp_kill_cpus(cpumask_t *mask)
> -{
> -       unsigned int cpu;
> -       for_each_cpu(cpu, mask)
> -               platform_cpu_kill(cpu);
> -}
> -#else
> -static void smp_kill_cpus(cpumask_t *mask) { }
> -#endif
> -
>  void smp_send_stop(void)
>  {
>         unsigned long timeout;
> @@ -679,8 +668,6 @@ void smp_send_stop(void)
>  
>         if (num_online_cpus() > 1)
>                 pr_warning("SMP: failed to stop secondary CPUs\n");
> -
> -       smp_kill_cpus(&mask);
>  }
>  
>  /*
