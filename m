From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 19 Jul 2011 10:24:45 +0800
Subject: [PATCH 2/7] ARM: mmp: append MMP_USE_OF config
In-Reply-To: <1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1311042290-20253-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since NR_IRQS is defined in irqs.h, parsing irq specifier will be started
from NR_IRQS while both CONFIG_USE_OF and CONFIG_SPARSE_IRQ is enabled.
It breaks the assumption that base irq is started from 0.

Add CONFIG_MMP_USE_OF config to distinguish. If CONFIG_MMP_USE_OF is set,
NR_IRQS is defined as 0. Otherwise, it follows the original definition.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Kconfig             |    7 +++++++
 arch/arm/mach-mmp/include/mach/irqs.h |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 67793a6..1efe994 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -96,4 +96,11 @@ config CPU_MMP2
 	select CPU_PJ4
 	help
 	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
+
+config MMP_USE_OF
+	bool "MMP Use OF"
+	select USE_OF
+	help
+	  Select OF code to ARCH-MMP.
+
 endif
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index a09d328..538bb69 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -224,6 +224,10 @@
 
 #define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
 
+#ifdef CONFIG_MMP_USE_OF
+#define NR_IRQS				0
+#else
 #define NR_IRQS				(IRQ_BOARD_START)
+#endif
 
 #endif /* __ASM_MACH_IRQS_H */
-- 
1.5.6.5
