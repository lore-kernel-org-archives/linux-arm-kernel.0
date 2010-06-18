From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Fri, 18 Jun 2010 15:58:36 +0530
Subject: [PATCH 2/2] mop500: add AB8500 interrupt support
In-Reply-To: <1276856916-19124-1-git-send-email-rabin.vincent@stericsson.com>
References: <1276856916-19124-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1276856916-19124-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the platform data to enable AB8500 interrupt support.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c                 |    6 +++++
 .../mach-ux500/include/mach/irqs-board-mop500.h    |   23 ++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/irqs.h            |    4 +++
 3 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs-board-mop500.h

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 0331e4b..0e8fd13 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -17,6 +17,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
 #include <linux/spi/spi.h>
+#include <linux/mfd/ab8500.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -70,10 +71,15 @@ struct pl022_config_chip ab4500_chip_info = {
 	.cs_control = ab4500_spi_cs_control,
 };
 
+static struct ab8500_platform_data ab8500_platdata = {
+	.irq_base	= MOP500_AB8500_IRQ_BASE,
+};
+
 static struct spi_board_info u8500_spi_devices[] = {
 	{
 		.modalias = "ab8500",
 		.controller_data = &ab4500_chip_info,
+		.platform_data = &ab8500_platdata,
 		.max_speed_hz = 12000000,
 		.bus_num = 0,
 		.chip_select = 0,
diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
new file mode 100644
index 0000000..cca4f70
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_IRQS_BOARD_MOP500_H
+#define __MACH_IRQS_BOARD_MOP500_H
+
+#define AB8500_NR_IRQS			104
+
+#define MOP500_AB8500_IRQ_BASE		IRQ_BOARD_START
+#define MOP500_AB8500_IRQ_END		(MOP500_AB8500_IRQ_BASE \
+					 + AB8500_NR_IRQS)
+#define MOP500_IRQ_END			MOP500_AB8500_IRQ_END
+
+#if MOP500_IRQ_END > IRQ_BOARD_END
+#undef IRQ_BOARD_END
+#define IRQ_BOARD_END	MOP500_IRQ_END
+#endif
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index a6fb1fc..10385bd 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -79,6 +79,10 @@
 /* This will be overridden by board-specific irq headers */
 #define IRQ_BOARD_END			IRQ_BOARD_START
 
+#ifdef CONFIG_MACH_U8500_MOP
+#include <mach/irqs-board-mop500.h>
+#endif
+
 #define NR_IRQS				IRQ_BOARD_END
 
 #endif /* ASM_ARCH_IRQS_H */
-- 
1.7.0
