From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Jun 2010 10:31:35 +0100
Subject: [PATCH] ARM: RealView: Do not use outer_sync() on certain with
	L210/L220
Message-ID: <20100629093135.10365.99959.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RealView boards with certain revisions of the L210/L220 cache controller
may have issues (hardware deadlock) with the recent changes to the mb()
barrier implementation (DSB followed by an L2 cache sync). The patch
disables ARM_DMA_MEM_BUFFERABLE for the RealView boards with L210/L220
and redefines the mandatory barriers without the outer_sync() call.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>
---
 arch/arm/mach-realview/Kconfig                 |    3 +++
 arch/arm/mach-realview/include/mach/barriers.h |    9 +++++++++
 arch/arm/mm/Kconfig                            |    2 ++
 3 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-realview/include/mach/barriers.h

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index ee5e392..f72b6c4 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -18,6 +18,7 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6
+	select ARCH_HAS_BARRIERS
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
 
@@ -35,6 +36,7 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select ARCH_HAS_BARRIERS
 	help
 	  Include support for the ARM(R) RealView MPCore Platform Baseboard.
 	  PB11MPCore is a platform with an on-board ARM11MPCore and has
@@ -44,6 +46,7 @@ config MACH_REALVIEW_PB1176
 	bool "Support RealView/PB1176 platform"
 	select CPU_V6
 	select ARM_GIC
+	select ARCH_HAS_BARRIERS
 	help
 	  Include support for the ARM(R) RealView ARM1176 Platform Baseboard.
 
diff --git a/arch/arm/mach-realview/include/mach/barriers.h b/arch/arm/mach-realview/include/mach/barriers.h
new file mode 100644
index 0000000..1014027
--- /dev/null
+++ b/arch/arm/mach-realview/include/mach/barriers.h
@@ -0,0 +1,9 @@
+/*
+ * Barriers redefined for RealView platforms with L210/L220 cache controller
+ * to work around hardware errata causing an outer_sync() operation to
+ * deadlock the system. Note that CONFIG_DMA_MEM_BUFFERABLE is not set for
+ * these platforms.
+ */
+#define mb()		dsb()
+#define rmb()		dmb()
+#define wmb()		mb()
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3053731..9f10a9b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -828,6 +828,8 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
+	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
+		     MACH_REALVIEW_PB11MP)
 	default y if CPU_V6 || CPU_V7
 	help
 	  Historically, the kernel has used strongly ordered mappings to
