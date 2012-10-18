From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Oct 2012 13:07:09 +0800
Subject: [PATCH v2] ARM: mach-imx: Let ARCH_MXC select HAVE_IMX_SRC
In-Reply-To: <1350484056-13437-1-git-send-email-festevam@gmail.com>
References: <1350484056-13437-1-git-send-email-festevam@gmail.com>
Message-ID: <20121018050705.GC4378@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 11:27:36AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit c5a0d497(ARM: imx: enable multi-platform build), 
> ARCH_MXC is selected by the following logic:
> 
> config ARCH_MXC
> 	def_bool y if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> 
> As vexpress_defconfig selects ARCH_MULTI_V6_V7, this leads to the following
> build error when building for vexpress_defconfig: 
> 
> arch/arm/mach-imx/hotplug.c:49: undefined reference to `imx_enable_cpu'
> arch/arm/mach-imx/platsmp.c:57: undefined reference to `imx_set_cpu_jump'
> arch/arm/mach-imx/platsmp.c:58: undefined reference to `imx_enable_cpu'
> 
> These missing functions are provided by arch/arm/mach-imx/src.c, which is 
> selected via HAVE_IMX_SRC.
> 
> Currently only SOC_IMX6Q selects HAVE_IMX_SRC, so let ARCH_MXC select it and fix
> the build error.
> 
I think the right fix is to make ARCH_MXC user selectable, just like
what vexpress does.  I would fix the problem like below.

Shawn

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e1f78f5..b732208 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_MXC
-       def_bool y if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
+       bool "Freescale i.MX family" if ARCH_MULTI_V7
        select AUTO_ZRELADDR if !ZBOOT_ROM
        select ARM_PATCH_PHYS_VIRT
        select GENERIC_CLOCKEVENTS
@@ -13,7 +13,7 @@ config ARCH_MXC
        help
          Support for Freescale MXC/iMX-based family of processors

-menu "Freescale i.MX support"
+menu "i.MX platform support"
        depends on ARCH_MXC

 config MXC_IRQ_PRIOR
