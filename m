From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 10:07:16 -0600
Subject: [PATCH] ARM: Kconfig: Do not force selection of ARCH_VEXPRESS
 by ARCH_MULTI_V7
In-Reply-To: <1353425698-14415-1-git-send-email-festevam@gmail.com>
References: <1353425698-14415-1-git-send-email-festevam@gmail.com>
Message-ID: <50ABAAB4.9070301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 09:34 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When building a kernel using imx_v6_v7_defconfig, it is not possible to unselect
> ARCH_VEXPRESS due to the fact that it is automatically selected by ARCH_MULTI_V7.
> 
> This is not good when someone wants to create a minimal kernel build, so let 
> multi_v7_defconfig select ARCH_VEXPRESS instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/Kconfig                    |    1 -
>  arch/arm/configs/multi_v7_defconfig |    1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 14f8160..d40e9d3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1000,7 +1000,6 @@ config ARCH_MULTI_V7
>  	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
>  	default y
>  	select ARCH_MULTI_V6_V7
> -	select ARCH_VEXPRESS
>  	select CPU_V7
>  
>  config ARCH_MULTI_V6_V7
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 159f75f..531c538 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_ARMADA_370=y
>  CONFIG_MACH_ARMADA_XP=y
>  CONFIG_ARCH_HIGHBANK=y
>  CONFIG_ARCH_SOCFPGA=y
> +CONFIG_ARCH_VEXPRESS=y
>  # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
>  CONFIG_ARM_ERRATA_754322=y
>  CONFIG_SMP=y

You also need at least the following or randconfig builds will break when
no platform is selected.

Rob

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..629e886 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -265,6 +265,7 @@ choice
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
 	select COMMON_CLK
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 36ff15b..10c984d 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -311,4 +311,6 @@ SECTIONS
  * binutils is too old (for other reasons as well)
  */
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+#endif
