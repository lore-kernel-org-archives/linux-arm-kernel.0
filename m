From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Jun 2010 11:45:29 +0100
Subject: [PATCH 1/2] ARM: RealView: Do not use outer_sync() on ARM11MPCore
	boards with L220
In-Reply-To: <20100630104105.16712.66741.stgit@e102109-lin.cambridge.arm.com>
References: <20100630104105.16712.66741.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100630104528.16712.39066.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RealView boards with certain revisions of the L220 cache controller (ARM11*
processors only) may have issues (hardware deadlock) with the recent changes to
the mb() barrier implementation (DSB followed by an L2 cache sync). The patch
redefines the RealView ARM11MPCore mandatory barriers without the outer_sync()
call.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-realview/Kconfig                 |    2 ++
 arch/arm/mach-realview/include/mach/barriers.h |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-realview/include/mach/barriers.h

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index ee5e392..b4575ae 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -18,6 +18,7 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6
+	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
 
@@ -35,6 +36,7 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Include support for the ARM(R) RealView MPCore Platform Baseboard.
 	  PB11MPCore is a platform with an on-board ARM11MPCore and has
diff --git a/arch/arm/mach-realview/include/mach/barriers.h b/arch/arm/mach-realview/include/mach/barriers.h
new file mode 100644
index 0000000..0c5d749
--- /dev/null
+++ b/arch/arm/mach-realview/include/mach/barriers.h
@@ -0,0 +1,8 @@
+/*
+ * Barriers redefined for RealView ARM11MPCore platforms with L220 cache
+ * controller to work around hardware errata causing the outer_sync()
+ * operation to deadlock the system.
+ */
+#define mb()		dsb()
+#define rmb()		dmb()
+#define wmb()		mb()
