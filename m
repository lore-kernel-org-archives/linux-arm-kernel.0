From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Mar 2013 17:38:07 +0100
Subject: [PATCH v3 07/12] arm: zynq: Add support for system reset
In-Reply-To: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
References: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <0003126b48c31c778c341afa14ab13d41ddc7fea.1364488495.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do system reset via slcr registers.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v3: Use zynq_ prefix for all zynq specific functions

v2: Fix comment
    use writel instead of __raw_writel
    Do not use PSS - use PS instead
---
 arch/arm/mach-zynq/common.c |    6 ++++++
 arch/arm/mach-zynq/common.h |    1 +
 arch/arm/mach-zynq/slcr.c   |   27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index cd3968c..f0a8533 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -92,6 +92,11 @@ static void __init xilinx_map_io(void)
 	zynq_scu_map_io();
 }
 
+static void zynq_system_reset(char mode, const char *cmd)
+{
+	zynq_slcr_system_reset();
+}
+
 static const char *xilinx_dt_match[] = {
 	"xlnx,zynq-zc702",
 	"xlnx,zynq-7000",
@@ -104,4 +109,5 @@ MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.init_machine	= xilinx_init_machine,
 	.init_time	= xilinx_zynq_timer_init,
 	.dt_compat	= xilinx_dt_match,
+	.restart	= zynq_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index dd594e6..d7ec3ca 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -18,6 +18,7 @@
 #define __MACH_ZYNQ_COMMON_H__
 
 extern int zynq_slcr_init(void);
+extern void zynq_slcr_system_reset(void);
 
 extern void __iomem *zynq_slcr_base;
 extern void __iomem *zynq_scu_base;
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index f9f3349..d58c996 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -32,9 +32,36 @@
 #define SLCR_UNLOCK_MAGIC		0xDF0D
 #define SLCR_UNLOCK			0x8   /* SCLR unlock register */
 
+#define SLCR_PS_RST_CTRL_OFFSET		0x200 /* PS Software Reset Control */
+#define SLCR_REBOOT_STATUS		0x258 /* PS Reboot Status */
+
 void __iomem *zynq_slcr_base;
 
 /**
+ * zynq_slcr_system_reset - Reset the entire system.
+ */
+void zynq_slcr_system_reset(void)
+{
+	u32 reboot;
+
+	/*
+	 * Unlock the SLCR then reset the system.
+	 * Note that this seems to require raw i/o
+	 * functions or there's a lockup?
+	 */
+	writel(SLCR_UNLOCK_MAGIC, zynq_slcr_base + SLCR_UNLOCK);
+
+	/*
+	 * Clear 0x0F000000 bits of reboot status register to workaround
+	 * the FSBL not loading the bitstream after soft-reboot
+	 * This is a temporary solution until we know more.
+	 */
+	reboot = readl(zynq_slcr_base + SLCR_REBOOT_STATUS);
+	writel(reboot & 0xF0FFFFFF, zynq_slcr_base + SLCR_REBOOT_STATUS);
+	writel(1, zynq_slcr_base + SLCR_PS_RST_CTRL_OFFSET);
+}
+
+/**
  * zynq_slcr_init
  * Returns 0 on success, negative errno otherwise.
  *
-- 
1.7.9.7
