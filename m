From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Jun 2013 08:45:51 +0100
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130613074551.GA7769@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Jun 12, 2013 at 09:01:21PM +0100, Stephen Warren wrote:
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
> Adjust Kconfig to reflect that machine_shutdown() (and hence kexec)
> relies upon disable_nonboot_cpus(). However, this alone doesn't guarantee
> that hotplug will work, or even that hotplug is implemented for a
> particular piece of HW that a multi-platform zImage runs on. Hence, add
> error-checking to machine_kexec() to determine whether it did work.

[...]

> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 282de48..6e8931c 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -184,30 +184,61 @@ int __init reboot_setup(char *str)
>  
>  __setup("reboot=", reboot_setup);
>  
> +/*
> + * Called by kexec, immediately prior to machine_kexec().
> + *
> + * This must completely disable all secondary CPUs; simply causing those CPUs
> + * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
> + * kexec'd kernel to use any and all RAM as it sees fit, without having to
> + * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
> + * functionality embodied in disable_nonboot_cpus() to achieve this.
> + */
>  void machine_shutdown(void)
>  {
> -#ifdef CONFIG_SMP
> -	smp_send_stop();
> -#endif
> +	disable_nonboot_cpus();
>  }

Any reason not to move this into machine_kexec and leave machine_shutdown
as a nop?

Anyway, I'm on holiday without internet until Tuesday, so for these two
patches:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
