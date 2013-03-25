From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 Mar 2013 14:53:12 +0100
Subject: [PATCH 06/10] arm: zynq: Add support for system reset
In-Reply-To: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1364219596-4954-6-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do system reset via slcr registers.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/common.c |    6 ++++++
 arch/arm/mach-zynq/common.h |    1 +
 arch/arm/mach-zynq/slcr.c   |   26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 2734bd6..292f775 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -91,6 +91,11 @@ static void __init xilinx_map_io(void)
 	scu_init();
 }
 
+static void xilinx_system_reset(char mode, const char *cmd)
+{
+	slcr_system_reset();
+}
+
 static const char *xilinx_dt_match[] = {
 	"xlnx,zynq-zc702",
 	"xlnx,zynq-7000",
@@ -103,4 +108,5 @@ MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.init_machine	= xilinx_init_machine,
 	.init_time	= xilinx_zynq_timer_init,
 	.dt_compat	= xilinx_dt_match,
+	.restart	= xilinx_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index e30898a..e5628f7 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -18,6 +18,7 @@
 #define __MACH_ZYNQ_COMMON_H__
 
 extern int slcr_init(void);
+extern void slcr_system_reset(void);
 
 extern void __iomem *zynq_slcr_base;
 extern void __iomem *scu_base;
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 1883b70..36b79d8 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -32,9 +32,35 @@
 #define SLCR_UNLOCK_MAGIC		0xDF0D
 #define SLCR_UNLOCK			0x8   /* SCLR unlock register */
 
+#define SLCR_PSS_RST_CTRL_OFFSET	0x200 /* PS Software Reset Control */
+#define SLCR_REBOOT_STATUS		0x258 /* PS Reboot Status */
+
 void __iomem *zynq_slcr_base;
 
 /**
+ * xslcr_system_reset - Reset the entire system.
+ *
+ */
+void slcr_system_reset(void)
+{
+	u32 reboot;
+
+	/* Unlock the SLCR then reset the system.
+	 * Note that this seems to require raw i/o
+	 * functions or there's a lockup?
+	 */
+	__raw_writel(SLCR_UNLOCK_MAGIC, zynq_slcr_base + SLCR_UNLOCK);
+
+	/* Clear 0x0F000000 bits of reboot status register to workaround
+	 * the FSBL not loading the bitstream after soft-reboot
+	 * This is a temporary solution until we know more.
+	 */
+	reboot = readl(zynq_slcr_base + SLCR_REBOOT_STATUS);
+	writel(reboot & 0xF0FFFFFF, zynq_slcr_base + SLCR_REBOOT_STATUS);
+	writel(1, zynq_slcr_base + SLCR_PSS_RST_CTRL_OFFSET);
+}
+
+/**
  * xslcr_init()
  * Returns 0 on success, negative errno otherwise.
  *
-- 
1.7.9.7
