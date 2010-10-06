From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:45 -0700
Subject: [PATCH 06/20 v2] msm: MSM8X60 RUMI3 board support
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-7-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

Board configuration for MSM8X60 emulation on RUMI3.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig              |    6 +++
 arch/arm/mach-msm/Makefile             |    1 -
 arch/arm/mach-msm/board-msm8x60.c      |   58 ++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/board.h |    2 +
 4 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-msm8x60.c

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 90f9b17..be05acc 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -78,6 +78,12 @@ config MACH_QSD8X50A_ST1_5
 	help
 	  Support for the Qualcomm ST1.5.
 
+config MACH_MSM8X60_RUMI3
+	depends on ARCH_MSM8X60
+	bool "MSM8x60 RUMI3"
+	help
+	  Support for the Qualcomm MSM8x60 RUMI3 emulator.
+
 endmenu
 
 config MSM_DEBUG_UART
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 6105d4f..4995d77 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -16,4 +16,3 @@ obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o d
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
 obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
 obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
-
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
new file mode 100644
index 0000000..d30ead1
--- /dev/null
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -0,0 +1,58 @@
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
+#include <linux/io.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
+
+#include <mach/board.h>
+#include <mach/msm_iomap.h>
+
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
diff --git a/arch/arm/mach-msm/include/mach/board.h b/arch/arm/mach-msm/include/mach/board.h
index 5a79bcf..6abf4a6 100644
--- a/arch/arm/mach-msm/include/mach/board.h
+++ b/arch/arm/mach-msm/include/mach/board.h
@@ -33,6 +33,8 @@ struct msm_acpu_clock_platform_data
 
 struct clk;
 
+extern struct sys_timer msm_timer;
+
 /* common init routines for use by arch/arm/mach-msm/board-*.c */
 
 void __init msm_add_devices(void);
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
