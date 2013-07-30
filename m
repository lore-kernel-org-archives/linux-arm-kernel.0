From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 14:24:12 +0900
Subject: [PATCH 2/4] ARM: shmobile: Introduce ARCH_SHMOBILE_MULTI
In-Reply-To: <cover.1375161473.git.horms+renesas@verge.net.au>
References: <cover.1375161473.git.horms+renesas@verge.net.au>
Message-ID: <efacfce5f8a523457e9419a25d52fe39db00b26a.1375161473.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add ARCH_SHMOBILE_MULTI to mach-shmobile that can be used
to enable ARCH_MULTIPLATFORM on selected SoCs and boards.

The headers stay under arch/arm/mach-shmobile/include/mach/
for now, they can and will be migrated independently over time.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Makefile               |  1 +
 arch/arm/mach-shmobile/Kconfig  | 21 +++++++++++++++++++++
 arch/arm/mach-shmobile/Makefile |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c0ac0f5..d1f717c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -190,6 +190,7 @@ machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
 machine-$(CONFIG_ARCH_SHARK)		+= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
+machine-$(CONFIG_ARCH_SHMOBILE_MULTI) 	+= shmobile
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 7c5034a..4c54298 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,3 +1,24 @@
+config ARCH_SHMOBILE_MULTI
+	bool "SH-Mobile Series" if ARCH_MULTI_V7
+	depends on MMU
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if LOCAL_TIMERS
+	select HAVE_SMP
+	select ARM_GIC
+	select MIGHT_HAVE_CACHE_L2X0
+	select NO_IOPORT
+	select PINCTRL
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+
+if ARCH_SHMOBILE_MULTI
+
+comment "SH-Mobile System Type"
+
+endif
+
 if ARCH_SHMOBILE
 
 comment "SH-Mobile System Type"
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 5884bea..b150c45 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
+
 # Common objects
 obj-y				:= timer.o console.o
 
-- 
1.8.3.2
