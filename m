From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jun 2014 10:43:19 +0100
Subject: The problem of fixing the obvious problem...
Message-ID: <20140619094319.GN32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... is that it uncovers other problems.

commit 979ff8854e66036cc760cb9a6740e2702611c52c
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jun 6 09:38:35 2014 +0200

    ARM: omap2: fix am43xx dependency on l2x0 cache

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0ba482638ebf..2085b3d42ed6 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -28,7 +28,6 @@ config ARCH_OMAP4
        select ARM_CPU_SUSPEND if PM
        select ARM_ERRATA_720789
        select ARM_GIC
-       select CACHE_L2X0
        select HAVE_ARM_SCU if SMP
        select HAVE_ARM_TWD if SMP
        select OMAP_INTERCONNECT

May look as if it's the right thing to do, but there's symbols lower down
(PL310_ERRATA_*) which are selected which depend on this symbol being
enabled.

What this means is that it's now possible for OMAP to be configured with
CACHE_L2X0 disabled _and_ for the PL310_ERRATA_* options to be forced on,
which results in:

warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_588369 which has unmet direct dependencies (CACHE_L2X0)
warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_727915 which has unmet direct dependencies (CACHE_L2X0)

So, let's clean up this sillyness by doing the job properly - ensuring
that /all/ PL310_ERRATA_* symbols are selected conditionally on
CACHE_L2X0 (whether or not CACHE_L2X0 is selected), so when people remove
that select statement, it doesn't cause these kinds of side effects.

The patch below will be in linux-next tomorrow.

From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: l2c: fix dependencies on PL310 errata symbols

A number of configurations spit out warnings similar to:

warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_588369 which has unmet direct dependencies (CACHE_L2X0)
warning: (SOC_IMX6 && SOC_VF610 && ARCH_OMAP4) selects PL310_ERRATA_727915 which has unmet direct dependencies (CACHE_L2X0)

Clean up the dependencies here:
* PL310 symbols should only be selected when CACHE_L2X0 is enabled.
* Since the cache-l2x0 code detects PL310 presence at runtime, and we will
  eventually get rid of CACHE_PL310, surround these errata options with an
  if CACHE_L2X0 conditional rather than repeating the dependency against
  each.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-imx/Kconfig      | 12 ++++++------
 arch/arm/mach-omap2/Kconfig    |  4 ++--
 arch/arm/mach-sti/Kconfig      |  4 ++--
 arch/arm/mach-ux500/Kconfig    |  2 +-
 arch/arm/mach-vexpress/Kconfig |  2 +-
 arch/arm/mm/Kconfig            |  9 ++++-----
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8d42eab76d53..606b52680f6a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -738,9 +738,9 @@ config SOC_IMX6
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select MFD_SYSCON
-	select PL310_ERRATA_588369 if CACHE_PL310
-	select PL310_ERRATA_727915 if CACHE_PL310
-	select PL310_ERRATA_769419 if CACHE_PL310
+	select PL310_ERRATA_588369 if CACHE_L2X0
+	select PL310_ERRATA_727915 if CACHE_L2X0
+	select PL310_ERRATA_769419 if CACHE_L2X0
 
 config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
@@ -775,9 +775,9 @@ config SOC_VF610
 	select ARM_GIC
 	select PINCTRL_VF610
 	select VF_PIT_TIMER
-	select PL310_ERRATA_588369 if CACHE_PL310
-	select PL310_ERRATA_727915 if CACHE_PL310
-	select PL310_ERRATA_769419 if CACHE_PL310
+	select PL310_ERRATA_588369 if CACHE_L2X0
+	select PL310_ERRATA_727915 if CACHE_L2X0
+	select PL310_ERRATA_769419 if CACHE_L2X0
 
 	help
 	  This enable support for Freescale Vybrid VF610 processor.
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0ba482638ebf..2ff3f23e31b0 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -32,8 +32,8 @@ config ARCH_OMAP4
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select OMAP_INTERCONNECT
-	select PL310_ERRATA_588369
-	select PL310_ERRATA_727915
+	select PL310_ERRATA_588369 if CACHE_L2X0
+	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PM_OPP if PM
 	select PM_RUNTIME if CPU_IDLE
 	select ARM_ERRATA_754322
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index abf9ee9bbc3f..1831e9611761 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -11,8 +11,8 @@ menuconfig ARCH_STI
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
-	select PL310_ERRATA_753970 if CACHE_PL310
-	select PL310_ERRATA_769419 if CACHE_PL310
+	select PL310_ERRATA_753970 if CACHE_L2X0
+	select PL310_ERRATA_769419 if CACHE_L2X0
 	help
 	  Include support for STiH41x SOCs like STiH415/416 using the device tree
 	  for discovery
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index b41a42da1505..86f537277383 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -16,7 +16,7 @@ config ARCH_U8500
 	select PINCTRL
 	select PINCTRL_ABX500
 	select PINCTRL_NOMADIK
-	select PL310_ERRATA_753970 if CACHE_PL310
+	select PL310_ERRATA_753970 if CACHE_L2X0
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 90249cfc37b3..a423de4724ab 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -44,7 +44,7 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	bool "Enable A5 and A9 only errata work-arounds"
 	default y
 	select ARM_ERRATA_720789
-	select PL310_ERRATA_753970 if CACHE_PL310
+	select PL310_ERRATA_753970 if CACHE_L2X0
 	help
 	  Provides common dependencies for Versatile Express platforms
 	  based on Cortex-A5 and Cortex-A9 processors. In order to
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index eda0dd0ab97b..c348eaee7ee2 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -889,9 +889,10 @@ config CACHE_L2X0
 	help
 	  This option enables the L2x0 PrimeCell.
 
+if CACHE_L2X0
+
 config CACHE_PL310
 	bool
-	depends on CACHE_L2X0
 	default y if CPU_V7 && !(CPU_V6 || CPU_V6K)
 	help
 	  This option enables optimisations for the PL310 cache
@@ -899,7 +900,6 @@ config CACHE_PL310
 
 config PL310_ERRATA_588369
 	bool "PL310 errata: Clean & Invalidate maintenance operations do not invalidate clean lines"
-	depends on CACHE_L2X0
 	help
 	   The PL310 L2 cache controller implements three types of Clean &
 	   Invalidate maintenance operations: by Physical Address
@@ -912,7 +912,6 @@ config PL310_ERRATA_588369
 
 config PL310_ERRATA_727915
 	bool "PL310 errata: Background Clean & Invalidate by Way operation can cause data corruption"
-	depends on CACHE_L2X0
 	help
 	  PL310 implements the Clean & Invalidate by Way L2 cache maintenance
 	  operation (offset 0x7FC). This operation runs in background so that
@@ -923,7 +922,6 @@ config PL310_ERRATA_727915
 
 config PL310_ERRATA_753970
 	bool "PL310 errata: cache sync operation may be faulty"
-	depends on CACHE_PL310
 	help
 	  This option enables the workaround for the 753970 PL310 (r3p0) erratum.
 
@@ -938,7 +936,6 @@ config PL310_ERRATA_753970
 
 config PL310_ERRATA_769419
 	bool "PL310 errata: no automatic Store Buffer drain"
-	depends on CACHE_L2X0
 	help
 	  On revisions of the PL310 prior to r3p2, the Store Buffer does
 	  not automatically drain. This can cause normal, non-cacheable
@@ -948,6 +945,8 @@ config PL310_ERRATA_769419
 	  on systems with an outer cache, the store buffer is drained
 	  explicitly.
 
+endif
+
 config CACHE_TAUROS2
 	bool "Enable the Tauros2 L2 cache controller"
 	depends on (ARCH_DOVE || ARCH_MMP || CPU_PJ4)
-- 
1.8.3.1


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
