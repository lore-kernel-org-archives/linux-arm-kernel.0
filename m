From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 1 Sep 2014 09:13:52 +0800
Subject: [PATCH] ARM: imx: remove imx_scu_standby_enable()
In-Reply-To: <1409533338-4111-1-git-send-email-shawn.guo@freescale.com>
References: <1409533338-4111-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140901011351.GD3135@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 09:02:18AM +0800, Shawn Guo wrote:
> With commit c716483c3db1 ("ARM: 8122/1: smp_scu: enable SCU standby
> support"), the STANDBY bit of SCU is handled by core function
> scu_enable().  So imx_scu_standby_enable() can be removed now.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/common.h        | 2 --
>  arch/arm/mach-imx/cpuidle-imx6q.c | 4 ----
>  arch/arm/mach-imx/platsmp.c       | 8 --------
>  3 files changed, 14 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 22ba8973bcb9..1dabf435c592 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -98,11 +98,9 @@ void imx_set_cpu_arg(int cpu, u32 arg);
>  void v7_secondary_startup(void);
>  void imx_scu_map_io(void);
>  void imx_smp_prepare(void);
> -void imx_scu_standby_enable(void);
>  #else
>  static inline void imx_scu_map_io(void) {}
>  static inline void imx_smp_prepare(void) {}
> -static inline void imx_scu_standby_enable(void) {}
>  #endif
>  void imx_src_init(void);
>  void imx_gpc_init(void);
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index 10844d3bb926..aa935787b743 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -66,10 +66,6 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
>  
>  int __init imx6q_cpuidle_init(void)
>  {
> -	/* Need to enable SCU standby for entering WAIT modes */
> -	if (!cpu_is_imx6sx())
> -		imx_scu_standby_enable();
> -
>  	/* Set INT_MEM_CLK_LPM bit to get a reliable WAIT mode support */
>  	imx6q_set_int_mem_clk_lpm(true);
>  
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index 5b57c17c06bd..31edbcd70c27 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -45,14 +45,6 @@ void __init imx_scu_map_io(void)
>  	scu_base = IMX_IO_ADDRESS(base);
>  }
>  
> -void imx_scu_standby_enable(void)
> -{
> -	u32 val = readl_relaxed(scu_base);
> -
> -	val |= SCU_STANDBY_ENABLE;

The following trunk is missed, since SCU_STANDBY_ENABLE is unused after
the change.

Shawn

diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 5b57c17c06bd..771bd25c1025 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -20,8 +20,6 @@
 #include "common.h"
 #include "hardware.h"

-#define SCU_STANDBY_ENABLE     (1 << 5)
-
 u32 g_diag_reg;
 static void __iomem *scu_base;
