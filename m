From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Mar 2014 12:58:52 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20140303125852.f0f4ebf5af79627aaa3baf5d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/mach-imx/Kconfig between commits ddb902cc3459 ("ARM: centralize
common multi-platform kconfig options") and 37dff0825611 ("ARM: imx6:
introduce CONFIG_SOC_IMX6 for i.MX6 common stuff") from the arm-soc tree
and commit f702c0213144 ("ARM: mach-imx: Select CONFIG_SRAM at ARCH_MXC
level") from the imx-mxs tree.

I fixed it up (I think - see below) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/Kconfig
index 41ffd433f709,e45062d41fcb..000000000000
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@@ -1,12 -1,22 +1,15 @@@
  config ARCH_MXC
  	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
+ 	select ARCH_HAS_CPUFREQ
+ 	select ARCH_HAS_OPP
  	select ARCH_REQUIRE_GPIOLIB
  	select ARM_CPU_SUSPEND if PM
 -	select ARM_PATCH_PHYS_VIRT
  	select CLKSRC_MMIO
- 	select GENERIC_ALLOCATOR
 -	select COMMON_CLK
 -	select GENERIC_CLOCKEVENTS
  	select GENERIC_IRQ_CHIP
 -	select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
 -	select MULTI_IRQ_HANDLER
  	select PINCTRL
+ 	select PM_OPP if PM
  	select SOC_BUS
 -	select SPARSE_IRQ
+ 	select SRAM
 -	select USE_OF
  	help
  	  Support for Freescale MXC/iMX-based family of processors
  
@@@ -114,10 -124,11 +117,10 @@@ config SOC_IMX3
  config SOC_IMX35
  	bool
  	select ARCH_MXC_IOMUX_V3
 -	select CPU_V6K
  	select HAVE_EPIT
  	select MXC_AVIC
+ 	select PINCTRL_IMX35
  	select SMP_ON_UP if SMP
- 	select PINCTRL
  
  config SOC_IMX5
  	bool
@@@ -775,16 -786,12 +777,11 @@@ config	SOC_IMX5
  	help
  	  This enables support for Freescale i.MX53 processor.
  
- config SOC_IMX6Q
- 	bool "i.MX6 Quad/DualLite support"
- 	select ARCH_HAS_CPUFREQ
- 	select ARCH_HAS_OPP
+ config SOC_IMX6
+ 	bool
  	select ARM_ERRATA_754322
- 	select ARM_ERRATA_764369 if SMP
  	select ARM_ERRATA_775420
  	select ARM_GIC
- 	select HAVE_ARM_SCU if SMP
- 	select HAVE_ARM_TWD if SMP
 -	select CPU_V7
  	select HAVE_IMX_ANATOP
  	select HAVE_IMX_GPC
  	select HAVE_IMX_MMDC
@@@ -793,10 -800,17 +790,16 @@@
  	select PL310_ERRATA_588369 if CACHE_PL310
  	select PL310_ERRATA_727915 if CACHE_PL310
  	select PL310_ERRATA_769419 if CACHE_PL310
- 	select PM_OPP if PM
+ 
+ config SOC_IMX6Q
+ 	bool "i.MX6 Quad/DualLite support"
+ 	select ARM_ERRATA_764369 if SMP
+ 	select HAVE_ARM_SCU if SMP
+ 	select HAVE_ARM_TWD if SMP
 -	select HAVE_SMP
+ 	select MIGHT_HAVE_PCI
+ 	select PCI_DOMAINS if PCI
+ 	select PINCTRL_IMX6Q
+ 	select SOC_IMX6
  
  	help
  	  This enables support for Freescale i.MX6 Quad processor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/91771b76/attachment.sig>
