From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 7 Nov 2011 11:15:26 -0600
Subject: [PATCH 41/41] ARM: restart: remove the now empty arch_reset()
In-Reply-To: <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ul-0001ZP-07@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DF7849C@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, November 06, 2011 10:54 AM, Russell King wrote:
>
> Remove the now empty arch_reset() from all the mach/system.h includes,
> and remove its callsite.  Remove arm_machine_restart() as this function
> no longer does anything useful.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/system.h                  |    1 -
>  arch/arm/kernel/process.c                      |   10 ++--------

[...]

>  arch/arm/mach-ep93xx/include/mach/system.h     |    4 ----

[...]

> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index fe7de75..03775b1 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -100,7 +100,6 @@ extern void __show_regs(struct pt_regs *);
>  extern int __pure cpu_architecture(void);
>  extern void cpu_init(void);
>  
> -void arm_machine_restart(char mode, const char *cmd);
>  void soft_restart(unsigned long);
>  extern void (*arm_pm_restart)(char str, const char *cmd);
>  
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 52b4306..72e119f 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -117,14 +117,8 @@ void soft_restart(unsigned long addr)
>  	cpu_reset(addr);
>  }
>  
> -void arm_machine_restart(char mode, const char *cmd)
> +static void null_restart(char mode, const char *cmd)
>  {
> -	/* Disable interrupts first */
> -	local_irq_disable();
> -	local_fiq_disable();
> -
> -	/* Call the architecture specific reboot code. */
> -	arch_reset(mode, cmd);
>  }
>  
>  /*
> @@ -133,7 +127,7 @@ void arm_machine_restart(char mode, const char *cmd)
>  void (*pm_power_off)(void);
>  EXPORT_SYMBOL(pm_power_off);
>  
> -void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
> +void (*arm_pm_restart)(char str, const char *cmd) = null_restart;
>  EXPORT_SYMBOL_GPL(arm_pm_restart);
>  
>  static void do_nothing(void *unused)

[...]

> diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> index b27a654..b5bec7c 100644
> --- a/arch/arm/mach-ep93xx/include/mach/system.h
> +++ b/arch/arm/mach-ep93xx/include/mach/system.h
> @@ -5,7 +5,3 @@ static inline void arch_idle(void)
>  {
>  	cpu_do_idle();
>  }
> -
> -static inline void arch_reset(char mode, const char *cmd)
> -{
> -}

For ep93xx...

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks!
