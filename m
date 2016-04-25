From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 25 Apr 2016 12:52:46 -0500
Subject: [PATCHv2 5/7] EDAC, altera: Add Arria10 ECC memory init functions
In-Reply-To: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
References: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1461606768-14404-6-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

In preparation for additional memory module ECCs, add the
memory initialization functions.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Specify INTMODE selection -> IRQ on each ECC error.
    Insert functions above memory-specific functions so that function
    declarations are not required.
    Use ERRINTENS & ERRINTENR registers instead of read/modify/write.
---
 drivers/edac/altera_edac.c |  157 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/altera_edac.h |    8 +++
 2 files changed, 165 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index dc09627..49a5239 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -19,6 +19,7 @@
 
 #include <asm/cacheflush.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/edac.h>
 #include <linux/genalloc.h>
 #include <linux/interrupt.h>
@@ -869,6 +870,162 @@ static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
 
 #endif	/* CONFIG_EDAC_ALTERA_OCRAM || CONFIG_EDAC_ALTERA_ETHERNET */
 
+/******************* Arria10 Memory Buffer Functions *********************/
+
+#if defined(CONFIG_EDAC_ALTERA_ETHERNET)
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
+	writel(ALTR_A10_ECC_SERRINTEN,
+	       (ecc_block_base + ALTR_A10_ECC_ERRINTENR_OFST));
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
+	/* Interrupt mode set to every SBERR */
+	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
+		     ALTR_A10_ECC_INTMODE);
+	/* Enable ECC */
+	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
+					ALTR_A10_ECC_CTRL_OFST));
+	writel(ALTR_A10_ECC_SERRINTEN,
+	       (ecc_block_base + ALTR_A10_ECC_ERRINTENS_OFST));
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
+#endif	/* CONFIG_EDAC_ALTERA_ETHERNET */
+
 /*********************** OCRAM EDAC Device Functions *********************/
 
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 83e621e..a4f1539 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -230,8 +230,13 @@ struct altr_sdram_mc_data {
 #define ALTR_A10_ECC_INITCOMPLETEB      BIT(8)
 
 #define ALTR_A10_ECC_ERRINTEN_OFST      0x10
+#define ALTR_A10_ECC_ERRINTENS_OFST     0x14
+#define ALTR_A10_ECC_ERRINTENR_OFST     0x18
 #define ALTR_A10_ECC_SERRINTEN          BIT(0)
 
+#define ALTR_A10_ECC_INTMODE_OFST       0x1C
+#define ALTR_A10_ECC_INTMODE            BIT(0)
+
 #define ALTR_A10_ECC_INTSTAT_OFST       0x20
 #define ALTR_A10_ECC_SERRPENA           BIT(0)
 #define ALTR_A10_ECC_DERRPENA           BIT(8)
@@ -280,6 +285,9 @@ struct altr_sdram_mc_data {
 /* Arria 10 OCRAM ECC Management Group Defines */
 #define ALTR_A10_OCRAM_ECC_EN_CTL       (BIT(1) | BIT(0))
 
+/* A10 ECC Controller memory initialization timeout */
+#define ALTR_A10_ECC_INIT_WATCHDOG_10US      10000
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
-- 
1.7.9.5
