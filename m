From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 12 Apr 2016 17:12:58 -0500
Subject: [PATCH 3/6] EDAC, altera: Add Arria10 ECC memory init functions
In-Reply-To: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1460499181-23080-4-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for additional memory module ECCs, add the
memory initialization functions.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/edac/altera_edac.c |  152 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/altera_edac.h |    3 +
 2 files changed, 155 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 226e650..0955ab0 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -19,6 +19,7 @@
 
 #include <asm/cacheflush.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/edac.h>
 #include <linux/genalloc.h>
 #include <linux/interrupt.h>
@@ -851,6 +852,8 @@ module_platform_driver(altr_edac_device_driver);
 /********************* Arria10 Function Declarations *********************/
 static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
 					 bool sberr);
+static int altr_init_a10_ecc_block(const char *compat, u32 irq_mask,
+				   u32 ecc_ctrl_en_mask, bool dual_port);
 
 /*********************** OCRAM EDAC Device Functions *********************/
 
@@ -1039,6 +1042,155 @@ const struct edac_device_prv_data a10_l2ecc_data = {
  * Based on xgene_edac.c peripheral code.
  */
 
+static inline void ecc_set_bits(u32 bit_mask, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr);
+
+	value |= bit_mask;
+	writel(value, ioaddr);
+}
+
+static inline void ecc_clear_bits(u32 bit_mask, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr);
+
+	value &= ~bit_mask;
+	writel(value, ioaddr);
+}
+
+static inline int ecc_test_bits(u32 bit_mask, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr);
+
+	return (value & bit_mask) ? 1 : 0;
+}
+
+/*
+ * This function uses the memory initialization block in the Arria10 ECC
+ * controller to initialize/clear the entire memory data and ECC data.
+ */
+static int altr_init_memory_port(void __iomem *ioaddr, int port)
+{
+	int limit = ALTR_A10_ECC_INIT_WATCHDOG_10US;
+	u32 init_mask = ALTR_A10_ECC_INITA;
+	u32 stat_mask = ALTR_A10_ECC_INITCOMPLETEA;
+	u32 clear_mask = ALTR_A10_ECC_ERRPENA_MASK;
+	int ret = 0;
+
+	if (port) {
+		init_mask = ALTR_A10_ECC_INITB;
+		stat_mask = ALTR_A10_ECC_INITCOMPLETEB;
+		clear_mask = ALTR_A10_ECC_ERRPENB_MASK;
+	}
+
+	ecc_set_bits(init_mask, (ioaddr + ALTR_A10_ECC_CTRL_OFST));
+	while (limit--) {
+		if (ecc_test_bits(stat_mask,
+				  (ioaddr + ALTR_A10_ECC_INITSTAT_OFST)))
+			break;
+		udelay(1);
+	}
+	if (limit < 0)
+		ret = -EBUSY;
+
+	/* Clear any pending ECC interrupts */
+	writel(clear_mask, (ioaddr + ALTR_A10_ECC_INTSTAT_OFST));
+
+	return ret;
+}
+
+/*
+ * Aside from the L2 ECC, the Arria10 ECC memories have a common register
+ * layout so the following functions can be shared between all peripherals.
+ */
+static int altr_init_a10_ecc_block(const char *compat, u32 irq_mask,
+				   u32 ecc_ctrl_en_mask, bool dual_port)
+{
+	int ret = 0;
+	void __iomem *ecc_block_base;
+	struct regmap *ecc_mgr_map;
+	char *ecc_name;
+	struct device_node *np, *parent, *np_eccmgr;
+
+	np = of_find_compatible_node(NULL, NULL, compat);
+	if (!np) {
+		pr_err("SOCFPGA: Unable to find %s in dtb\n", compat);
+		ret = -ENODEV;
+		goto out;
+	}
+	ecc_name = (char *)np->name;
+
+	/* Ensure device is enabled before calling init, otherwise exit */
+	parent = of_parse_phandle(np, "parent", 0);
+	if (!parent || !of_device_is_available(parent)) {
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	/* Get the ECC Manager - parent of the device EDACs */
+	np_eccmgr = of_get_parent(np);
+	ecc_mgr_map = syscon_regmap_lookup_by_phandle(np_eccmgr,
+						      "altr,sysmgr-syscon");
+	of_node_put(np_eccmgr);
+	if (IS_ERR(ecc_mgr_map)) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to get syscon altr,sysmgr-syscon\n");
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	/* Map the ECC Block */
+	ecc_block_base = of_iomap(np, 0);
+	if (!ecc_block_base) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to map %s ECC block\n", ecc_name);
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	/* Disable ECC */
+	regmap_write(ecc_mgr_map, A10_SYSMGR_ECC_INTMASK_SET_OFST, irq_mask);
+	ecc_clear_bits(ALTR_A10_ECC_SERRINTEN,
+		       (ecc_block_base + ALTR_A10_ECC_ERRINTEN_OFST));
+	ecc_clear_bits(ecc_ctrl_en_mask,
+		       (ecc_block_base + ALTR_A10_ECC_CTRL_OFST));
+	/* Ensure all writes complete */
+	wmb();
+	/* Use HW initialization block to initialize memory for ECC */
+	ret = altr_init_memory_port(ecc_block_base, 0);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "ECC: cannot init %s PORTA memory\n", ecc_name);
+		goto out2;
+	}
+
+	if (dual_port) {
+		ret = altr_init_memory_port(ecc_block_base, 1);
+		if (ret) {
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "ECC: cannot init %s PORTB memory\n",
+				    ecc_name);
+			goto out2;
+		}
+	}
+
+	/* Enable ECC */
+	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
+					ALTR_A10_ECC_CTRL_OFST));
+	ecc_set_bits(ALTR_A10_ECC_SERRINTEN,
+		     (ecc_block_base + ALTR_A10_ECC_ERRINTEN_OFST));
+	regmap_write(ecc_mgr_map, A10_SYSMGR_ECC_INTMASK_CLR_OFST, irq_mask);
+	/* Ensure all writes complete */
+	wmb();
+out2:
+	iounmap(ecc_block_base);
+out1:
+	of_node_put(parent);
+out:
+	of_node_put(np);
+	return ret;
+}
+
 static ssize_t altr_edac_a10_device_trig(struct file *file,
 					 const char __user *user_buf,
 					 size_t count, loff_t *ppos)
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 42090f3..7e66015 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -280,6 +280,9 @@ struct altr_sdram_mc_data {
 /* Arria 10 OCRAM ECC Management Group Defines */
 #define ALTR_A10_OCRAM_ECC_EN_CTL       (BIT(1) | BIT(0))
 
+/* A10 ECC Controller memory initialization timeout */
+#define ALTR_A10_ECC_INIT_WATCHDOG_10US      10000
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
-- 
1.7.9.5
