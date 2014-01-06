From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Jan 2014 15:36:42 +0100
Subject: [PATCH 6/7] ARM: zynq: Add and use zynq_slcr_read/write() helper
 functions
In-Reply-To: <cover.1389018985.git.michal.simek@xilinx.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
Message-ID: <1dc9cc7353d5999f46fd4bae9bdc9fbc56f0c274.1389018985.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use zynq_slcr_read/write helper functions for reg access
instead of readl/writel.
Also use regmap when it is ready.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/slcr.c | 56 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index a679dff..f0f6a69 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -35,6 +35,42 @@ static void __iomem *zynq_slcr_base;
 static struct regmap *zynq_slcr_regmap;

 /**
+ * zynq_slcr_write - Write to a register in SLCR block
+ *
+ * @val:	Value to write to the register
+ * @offset:	Register offset in SLCR block
+ *
+ * return:	a negative value on error, 0 on success
+ */
+static int zynq_slcr_write(u32 val, u32 offset)
+{
+	if (!zynq_slcr_regmap) {
+		writel(val, zynq_slcr_base + offset);
+		return 0;
+	}
+
+	return regmap_write(zynq_slcr_regmap, offset, val);
+}
+
+/**
+ * zynq_slcr_read - Read a register in SLCR block
+ *
+ * @val:	Pointer to value to be read from SLCR
+ * @offset:	Register offset in SLCR block
+ *
+ * return:	a negative value on error, 0 on success
+ */
+static int zynq_slcr_read(u32 *val, u32 offset)
+{
+	if (zynq_slcr_regmap)
+		return regmap_read(zynq_slcr_regmap, offset, val);
+
+	*val = readl(zynq_slcr_base + offset);
+
+	return 0;
+}
+
+/**
  * zynq_slcr_system_reset - Reset the entire system.
  */
 void zynq_slcr_system_reset(void)
@@ -53,9 +89,9 @@ void zynq_slcr_system_reset(void)
 	 * the FSBL not loading the bitstream after soft-reboot
 	 * This is a temporary solution until we know more.
 	 */
-	reboot = readl(zynq_slcr_base + SLCR_REBOOT_STATUS_OFFSET);
-	writel(reboot & 0xF0FFFFFF, zynq_slcr_base + SLCR_REBOOT_STATUS_OFFSET);
-	writel(1, zynq_slcr_base + SLCR_PS_RST_CTRL_OFFSET);
+	zynq_slcr_read(&reboot, SLCR_REBOOT_STATUS_OFFSET);
+	zynq_slcr_write(reboot & 0xF0FFFFFF, SLCR_REBOOT_STATUS_OFFSET);
+	zynq_slcr_write(1, SLCR_PS_RST_CTRL_OFFSET);
 }

 /**
@@ -64,11 +100,13 @@ void zynq_slcr_system_reset(void)
  */
 void zynq_slcr_cpu_start(int cpu)
 {
-	u32 reg = readl(zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
+	u32 reg;
+
+	zynq_slcr_read(&reg, SLCR_A9_CPU_RST_CTRL_OFFSET);
 	reg &= ~(SLCR_A9_CPU_RST << cpu);
-	writel(reg, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
+	zynq_slcr_write(reg, SLCR_A9_CPU_RST_CTRL_OFFSET);
 	reg &= ~(SLCR_A9_CPU_CLKSTOP << cpu);
-	writel(reg, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
+	zynq_slcr_write(reg, SLCR_A9_CPU_RST_CTRL_OFFSET);
 }

 /**
@@ -77,9 +115,11 @@ void zynq_slcr_cpu_start(int cpu)
  */
 void zynq_slcr_cpu_stop(int cpu)
 {
-	u32 reg = readl(zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
+	u32 reg;
+
+	zynq_slcr_read(&reg, SLCR_A9_CPU_RST_CTRL_OFFSET);
 	reg |= (SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu;
-	writel(reg, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
+	zynq_slcr_write(reg, SLCR_A9_CPU_RST_CTRL_OFFSET);
 }

 /**
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/45056c3f/attachment.sig>
