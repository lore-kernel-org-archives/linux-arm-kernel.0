From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Nov 2010 10:06:03 +0000
Subject: [RFC PATCH 02/13] picoxcell: add support for AXI bus snoopers
In-Reply-To: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1290506774-17895-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The picoXcell devices have a number of peripherals that may perform
master accesses to the AXI bus, but if incorrectly programmed can
generate a bus error. The AXI2CFG block has bus snoopers that monitor
the bus for errors from other masters and raises an interrupt if
detected. These errors are typically irrecoverable so panic if we see
them.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/picoxcell_core.c |   89 ++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index 4469a78..07eaa9b 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -71,6 +71,7 @@ static ssize_t part_show(struct sys_device *sysdev,
 			 struct sysdev_attribute *attr, char *buf)
 {
 	const char *part = picoxcell_get_partname();
+
 	return snprintf(buf, PAGE_SIZE, "%s\n", part);
 }
 static SYSDEV_ATTR(part, 0444, part_show, NULL);
@@ -178,6 +179,91 @@ void __init picoxcell_map_io(void)
 		soc->init_io();
 }
 
+/*
+ * AXI Bus Read / Write Error Handling
+ *
+ * Some of the peripherals on the AXI bus can generate aborts. For example, a
+ * DMAC trying to DMA from the EBI. This isn't supported and will generate an
+ * error response. This can't be recovered from so we report the error and
+ * panic.
+ *
+ * Given a bit number in the AXI2Cfg snoop AXI error IRQ post mask register,
+ * give the textual name of the operation that generated the error.
+ */
+static const char *axi_bus_error_name(int bit)
+{
+	static const char *snoop_err_names[32] = {
+		[0]	= "dmac1_channel0 (read)",
+		[1]	= "dmac1_channel1 (read)",
+		[2]	= "dmac1_channel2 (read)",
+		[3]	= "dmac1_channel3 (read)",
+		[4]	= "dmac2_channel0 (read)",
+		[5]	= "dmac2_channel1 (read)",
+		[6]	= "dmac2_channel2 (read)",
+		[7]	= "dmac2_channel3 (read)",
+		[8]	= "emac (read)",
+		[9]	= "cipher (read)",
+		[10]	= "srtp (read)",
+		[11]	= "ipsec (read)",
+		[12]	= "dmac1_channel0 (write)",
+		[13]	= "dmac1_channel1 (write)",
+		[14]	= "dmac1_channel2 (write)",
+		[15]	= "dmac1_channel3 (write)",
+		[16]	= "dmac2_channel0 (write)",
+		[17]	= "dmac2_channel1 (write)",
+		[18]	= "dmac2_channel2 (write)",
+		[19]	= "dmac2_channel3 (write)",
+		[20]	= "emac (write)",
+		[21]	= "cipher (write)",
+		[22]	= "srtp (write)",
+		[23]	= "ipsec (write)",
+	};
+
+	return snoop_err_names[bit] ?: "<INVALID SNOOP ERROR>";
+}
+
+/* AXI Bus write errors */
+static irqreturn_t picoxcell_axi_bus_error_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * If we ever get one of these interrupts then we are in big trouble,
+	 * they should never happen. The error condition is non recoverable.
+	 */
+	unsigned long axi_error =
+		axi2cfg_readl(AXI2CFG_AXI_ERR_STATE_REG_OFFSET);
+	int bit;
+
+	for_each_set_bit(bit, &axi_error, 32) {
+		pr_emerg("AXI bus error [%s] detected\n",
+			 axi_bus_error_name(bit));
+	}
+	panic("unable to handle AXI bus error");
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction picoxcell_axi_error_irq = {
+	.name	    = "picoxcell axi bus error",
+	.flags	    = IRQF_DISABLED,
+	.handler    = picoxcell_axi_bus_error_interrupt,
+};
+
+/* Initialise AXI Bus error handling */
+static void __init picoxcell_axi_bus_error_init(void)
+{
+	/* Setup the irq handler for AXI read and write errors. */
+	setup_irq(IRQ_AXI_RD_ERR, &picoxcell_axi_error_irq);
+	setup_irq(IRQ_AXI_WR_ERR, &picoxcell_axi_error_irq);
+
+	/* Make sure no AXI errors are masked */
+	axi2cfg_writel(AXI2CFG_AXI_ERR_MASK_NONE,
+		       AXI2CFG_AXI_ERR_MASK_REG_OFFSET);
+
+	/* Enable interrupts for all AXI Read & Write errors */
+	axi2cfg_writel(AXI2CFG_AXI_ERR_ENABLE_ALL,
+		       AXI2CFG_AXI_ERR_ENABLE_REG_OFFSET);
+}
+
 void __init picoxcell_core_init(void)
 {
 	struct picoxcell_soc *soc = picoxcell_get_soc();
@@ -196,4 +282,7 @@ void __init picoxcell_core_init(void)
 
 	/* Add the arch debugfs entry. */
 	picoxcell_debugfs_init();
+
+	/* Add handlers for the AXI bus snooping. */
+	picoxcell_axi_bus_error_init();
 }
-- 
1.7.2.3
