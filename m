From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 24 Aug 2010 21:57:38 -0700
Subject: [PATCH 09/24] msm: MSM8X60 RUMI3 board support
In-Reply-To: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1282712273-344-10-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

Board configuration for MSM8X60 emulation on RUMI3.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig         |    7 ++++
 arch/arm/mach-msm/Makefile        |    2 +-
 arch/arm/mach-msm/board-msm8x60.c |   59 +++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-msm8x60.c

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 3b9bece..60ad211 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -80,6 +80,13 @@ config MACH_QSD8X50A_ST1_5
 	help
 	  Support for the Qualcomm ST1.5.
 
+config MACH_MSM8X60_RUMI3
+	depends on ARCH_MSM8X60
+	default n
+	bool "MSM8x60 RUMI3"
+	help
+	  Support for the Qualcomm MSM8x60 RUMI3 emulator.
+
 endmenu
 
 config MSM_DEBUG_UART
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 78fb536..64a95ae 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -16,8 +16,8 @@ obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o d
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
 obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
 obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
-
 obj-y += gpiomux.o
 obj-$(CONFIG_ARCH_MSM7X30) += gpiomux-7x30.o gpiomux-7x00.o
 obj-$(CONFIG_ARCH_QSD8X50) += gpiomux-8x50.o gpiomux-7x00.o
 obj-$(CONFIG_ARCH_MSM8X60) += gpiomux-8x60.o
+obj-$(CONFIG_MACH_MSM8X60_RUMI3) += board-msm8x60.o
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
new file mode 100644
index 0000000..3ab4bd9
--- /dev/null
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -0,0 +1,59 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
+
+#include <mach/board.h>
+#include <mach/msm_iomap.h>
+#include <mach/io.h>
+
+extern struct sys_timer msm_timer;
+void __iomem *gic_cpu_base_addr;
+
+unsigned long clk_get_max_axi_khz(void)
+{
+	return 0;
+}
+
+static void __init msm8x60_map_io(void)
+{
+	msm_map_msm8x60_io();
+}
+
+static void __init msm8x60_init_irq(void)
+{
+	gic_dist_init(0, MSM_QGIC_DIST_BASE, 1);
+	gic_cpu_base_addr = (void *)MSM_QGIC_CPU_BASE;
+	gic_cpu_init(0, MSM_QGIC_CPU_BASE);
+}
+
+static void __init msm8x60_init(void)
+{
+}
+
+MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
+	.map_io = msm8x60_map_io,
+	.init_irq = msm8x60_init_irq,
+	.init_machine = msm8x60_init,
+	.timer = &msm_timer,
+MACHINE_END
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
