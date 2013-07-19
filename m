From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 19 Jul 2013 11:56:28 +0200
Subject: [PATCH] arm64: use common reboot infrastructure
In-Reply-To: <1373541180-7452-1-git-send-email-marc.zyngier@arm.com>
References: <1373541180-7452-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130719095628.GG16015@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:13 Thu 11 Jul     , Marc Zyngier wrote:
> Commit 7b6d864b48d9 (reboot: arm: change reboot_mode to use enum
> reboot_mode) changed the way reboot is handled on arm, which has a
> direct impact on arm64 as we share the reset driver on the VE platform.
> 
> The obvious fix is to move arm64 to use the same infrastructure.
> 
> Cc: Robin Holt <holt@sgi.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/system_misc.h | 3 ++-
>  arch/arm64/kernel/process.c          | 2 +-
>  kernel/reboot.c                      | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
> index a6e1750..7a18fab 100644
> --- a/arch/arm64/include/asm/system_misc.h
> +++ b/arch/arm64/include/asm/system_misc.h
> @@ -23,6 +23,7 @@
>  #include <linux/compiler.h>
>  #include <linux/linkage.h>
>  #include <linux/irqflags.h>
> +#include <linux/reboot.h>
>  
>  struct pt_regs;
>  
> @@ -41,7 +42,7 @@ extern void show_pte(struct mm_struct *mm, unsigned long addr);
>  extern void __show_regs(struct pt_regs *);
>  
>  void soft_restart(unsigned long);
> -extern void (*arm_pm_restart)(char str, const char *cmd);
> +extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>  
>  #define UDBG_UNDEFINED	(1 << 0)
>  #define UDBG_SYSCALL	(1 << 1)
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 46f02c3..1788bf6 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -132,7 +132,7 @@ void machine_restart(char *cmd)
>  
>  	/* Now call the architecture specific reboot code. */
>  	if (arm_pm_restart)
> -		arm_pm_restart('h', cmd);
> +		arm_pm_restart(reboot_mode, cmd);
>  
>  	/*
>  	 * Whoops - the architecture was unable to reboot.
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 269ed93..9aaeb58 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -25,7 +25,7 @@ int C_A_D = 1;
>  struct pid *cad_pid;
>  EXPORT_SYMBOL(cad_pid);
>  
> -#if defined(CONFIG_ARM) || defined(CONFIG_UNICORE32)
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_UNICORE32)
how aboud have a specific Kconfig for this instead of a list of defined(xx)

Best Regards,
J.
>  #define DEFAULT_REBOOT_MODE		= REBOOT_HARD
>  #else
>  #define DEFAULT_REBOOT_MODE
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
