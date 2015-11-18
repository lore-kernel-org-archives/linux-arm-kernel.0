From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 16:13:55 -0800
Subject: [PATCH v2] spmi: pmic-arb: Support more than 128 peripherals
Message-ID: <1447805635-2996-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for more than 128 peripherals by taking a lazy
caching approach to the mapping tables. Instead of reading and
caching the tables at boot given some fixed size, read them and
cache them on an as needed basis. We still assume a max size of
512 peripherals, trading off some space for simplicity.

Based on a patch by Gilad Avidov <gavidov@codeaurora.org> and
Sagar Dharia <sdharia@codeaurora.org>.

Cc: Gilad Avidov <gavidov@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * Return error from offset search if can't find a mapping

 drivers/spmi/spmi-pmic-arb.c | 153 +++++++++++++++++++++++++++++++------------
 1 file changed, 111 insertions(+), 42 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index be822f7a9ce6..aca282d45421 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -10,6 +10,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -47,9 +48,9 @@
 #define SPMI_MAPPING_BIT_IS_1_FLAG(X)	(((X) >> 8) & 0x1)
 #define SPMI_MAPPING_BIT_IS_1_RESULT(X)	(((X) >> 0) & 0xFF)
 
-#define SPMI_MAPPING_TABLE_LEN		255
 #define SPMI_MAPPING_TABLE_TREE_DEPTH	16	/* Maximum of 16-bits */
-#define PPID_TO_CHAN_TABLE_SZ		BIT(12)	/* PPID is 12bit chan is 1byte*/
+#define PMIC_ARB_MAX_PPID		BIT(12) /* PPID is 12bit */
+#define PMIC_ARB_CHAN_VALID		BIT(15)
 
 /* Ownership Table */
 #define SPMI_OWNERSHIP_TABLE_REG(N)	(0x0700 + (4 * (N)))
@@ -85,9 +86,7 @@ enum pmic_arb_cmd_op_code {
 };
 
 /* Maximum number of support PMIC peripherals */
-#define PMIC_ARB_MAX_PERIPHS		256
-#define PMIC_ARB_MAX_CHNL		128
-#define PMIC_ARB_PERIPH_ID_VALID	(1 << 15)
+#define PMIC_ARB_MAX_PERIPHS		512
 #define PMIC_ARB_TIMEOUT_US		100
 #define PMIC_ARB_MAX_TRANS_BYTES	(8)
 
@@ -125,18 +124,22 @@ struct spmi_pmic_arb_dev {
 	void __iomem		*wr_base;
 	void __iomem		*intr;
 	void __iomem		*cnfg;
+	void __iomem		*core;
+	resource_size_t		core_size;
 	raw_spinlock_t		lock;
 	u8			channel;
 	int			irq;
 	u8			ee;
-	u8			min_apid;
-	u8			max_apid;
-	u32			mapping_table[SPMI_MAPPING_TABLE_LEN];
+	u16			min_apid;
+	u16			max_apid;
+	u32			*mapping_table;
+	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
 	struct irq_domain	*domain;
 	struct spmi_controller	*spmic;
-	u16			apid_to_ppid[256];
+	u16			*apid_to_ppid;
 	const struct pmic_arb_ver_ops *ver_ops;
-	u8			*ppid_to_chan;
+	u16			*ppid_to_chan;
+	u16			last_channel;
 };
 
 /**
@@ -158,7 +161,8 @@ struct spmi_pmic_arb_dev {
  */
 struct pmic_arb_ver_ops {
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
-	u32 (*offset)(struct spmi_pmic_arb_dev *dev, u8 sid, u16 addr);
+	int (*offset)(struct spmi_pmic_arb_dev *dev, u8 sid, u16 addr,
+		      u32 *offset);
 	u32 (*fmt_cmd)(u8 opc, u8 sid, u16 addr, u8 bc);
 	int (*non_data_cmd)(struct spmi_controller *ctrl, u8 opc, u8 sid);
 	/* Interrupts controller functionality (offset of PIC registers) */
@@ -212,7 +216,14 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 	struct spmi_pmic_arb_dev *dev = spmi_controller_get_drvdata(ctrl);
 	u32 status = 0;
 	u32 timeout = PMIC_ARB_TIMEOUT_US;
-	u32 offset = dev->ver_ops->offset(dev, sid, addr) + PMIC_ARB_STATUS;
+	u32 offset;
+	int rc;
+
+	rc = dev->ver_ops->offset(dev, sid, addr, &offset);
+	if (rc)
+		return rc;
+
+	offset += PMIC_ARB_STATUS;
 
 	while (timeout--) {
 		status = readl_relaxed(base + offset);
@@ -257,7 +268,11 @@ pmic_arb_non_data_cmd_v1(struct spmi_controller *ctrl, u8 opc, u8 sid)
 	unsigned long flags;
 	u32 cmd;
 	int rc;
-	u32 offset = pmic_arb->ver_ops->offset(pmic_arb, sid, 0);
+	u32 offset;
+
+	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, 0, &offset);
+	if (rc)
+		return rc;
 
 	cmd = ((opc | 0x40) << 27) | ((sid & 0xf) << 20);
 
@@ -297,7 +312,11 @@ static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	u8 bc = len - 1;
 	u32 cmd;
 	int rc;
-	u32 offset = pmic_arb->ver_ops->offset(pmic_arb, sid, addr);
+	u32 offset;
+
+	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr, &offset);
+	if (rc)
+		return rc;
 
 	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
 		dev_err(&ctrl->dev,
@@ -344,7 +363,11 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	u8 bc = len - 1;
 	u32 cmd;
 	int rc;
-	u32 offset = pmic_arb->ver_ops->offset(pmic_arb, sid, addr);
+	u32 offset;
+
+	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr, &offset);
+	if (rc)
+		return rc;
 
 	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
 		dev_err(&ctrl->dev,
@@ -614,6 +637,10 @@ static int search_mapping_table(struct spmi_pmic_arb_dev *pa,
 	u32 data;
 
 	for (i = 0; i < SPMI_MAPPING_TABLE_TREE_DEPTH; ++i) {
+		if (!test_and_set_bit(index, pa->mapping_table_valid))
+			mapping_table[index] = readl_relaxed(pa->cnfg +
+						SPMI_MAPPING_TABLE_REG(index));
+
 		data = mapping_table[index];
 
 		if (ppid & (1 << SPMI_MAPPING_BIT_INDEX(data))) {
@@ -701,18 +728,61 @@ static int qpnpint_irq_domain_map(struct irq_domain *d,
 }
 
 /* v1 offset per ee */
-static u32 pmic_arb_offset_v1(struct spmi_pmic_arb_dev *pa, u8 sid, u16 addr)
+static int
+pmic_arb_offset_v1(struct spmi_pmic_arb_dev *pa, u8 sid, u16 addr, u32 *offset)
 {
-	return 0x800 + 0x80 * pa->channel;
+	*offset = 0x800 + 0x80 * pa->channel;
+	return 0;
 }
 
+static u16 pmic_arb_find_chan(struct spmi_pmic_arb_dev *pa, u16 ppid)
+{
+	u32 regval, offset;
+	u16 chan;
+	u16 id;
+
+	/*
+	 * PMIC_ARB_REG_CHNL is a table in HW mapping channel to ppid.
+	 * ppid_to_chan is an in-memory invert of that table.
+	 */
+	for (chan = pa->last_channel; ; chan++) {
+		offset = PMIC_ARB_REG_CHNL(chan);
+		if (offset >= pa->core_size)
+			break;
+
+		regval = readl_relaxed(pa->core + offset);
+		if (!regval)
+			continue;
+
+		id = (regval >> 8) & PMIC_ARB_PPID_MASK;
+		pa->ppid_to_chan[id] = chan | PMIC_ARB_CHAN_VALID;
+		if (id == ppid) {
+			chan |= PMIC_ARB_CHAN_VALID;
+			break;
+		}
+	}
+	pa->last_channel = chan & ~PMIC_ARB_CHAN_VALID;
+
+	return chan;
+}
+
+
 /* v2 offset per ppid (chan) and per ee */
-static u32 pmic_arb_offset_v2(struct spmi_pmic_arb_dev *pa, u8 sid, u16 addr)
+static int
+pmic_arb_offset_v2(struct spmi_pmic_arb_dev *pa, u8 sid, u16 addr, u32 *offset)
 {
 	u16 ppid = (sid << 8) | (addr >> 8);
-	u8  chan = pa->ppid_to_chan[ppid];
+	u16 chan;
 
-	return 0x1000 * pa->ee + 0x8000 * chan;
+	chan = pa->ppid_to_chan[ppid];
+	if (!(chan & PMIC_ARB_CHAN_VALID))
+		chan = pmic_arb_find_chan(pa, ppid);
+	if (!(chan & PMIC_ARB_CHAN_VALID))
+		return -ENODEV;
+	chan &= ~PMIC_ARB_CHAN_VALID;
+
+	*offset = 0x1000 * pa->ee + 0x8000 * chan;
+	return 0;
 }
 
 static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u16 addr, u8 bc)
@@ -797,7 +867,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *core;
 	u32 channel, ee, hw_ver;
-	int err, i;
+	int err;
 	bool is_v1;
 
 	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*pa));
@@ -808,6 +878,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	pa->spmic = ctrl;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
+	pa->core_size = resource_size(res);
 	core = devm_ioremap_resource(&ctrl->dev, res);
 	if (IS_ERR(core)) {
 		err = PTR_ERR(core);
@@ -825,10 +896,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		pa->wr_base = core;
 		pa->rd_base = core;
 	} else {
-		u8  chan;
-		u16 ppid;
-		u32 regval;
-
+		pa->core = core;
 		pa->ver_ops = &pmic_arb_v2;
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -847,24 +915,14 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 			goto err_put_ctrl;
 		}
 
-		pa->ppid_to_chan = devm_kzalloc(&ctrl->dev,
-					PPID_TO_CHAN_TABLE_SZ, GFP_KERNEL);
+		pa->ppid_to_chan = devm_kcalloc(&ctrl->dev,
+						PMIC_ARB_MAX_PPID,
+						sizeof(*pa->ppid_to_chan),
+						GFP_KERNEL);
 		if (!pa->ppid_to_chan) {
 			err = -ENOMEM;
 			goto err_put_ctrl;
 		}
-		/*
-		 * PMIC_ARB_REG_CHNL is a table in HW mapping channel to ppid.
-		 * ppid_to_chan is an in-memory invert of that table.
-		 */
-		for (chan = 0; chan < PMIC_ARB_MAX_CHNL; ++chan) {
-			regval = readl_relaxed(core + PMIC_ARB_REG_CHNL(chan));
-			if (!regval)
-				continue;
-
-			ppid = (regval >> 8) & 0xFFF;
-			pa->ppid_to_chan[ppid] = chan;
-		}
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
@@ -915,9 +973,20 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 	pa->ee = ee;
 
-	for (i = 0; i < ARRAY_SIZE(pa->mapping_table); ++i)
-		pa->mapping_table[i] = readl_relaxed(
-				pa->cnfg + SPMI_MAPPING_TABLE_REG(i));
+	pa->apid_to_ppid = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PERIPHS,
+					    sizeof(*pa->apid_to_ppid),
+					    GFP_KERNEL);
+	if (!pa->apid_to_ppid) {
+		err = -ENOMEM;
+		goto err_put_ctrl;
+	}
+
+	pa->mapping_table = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PERIPHS - 1,
+					sizeof(*pa->mapping_table), GFP_KERNEL);
+	if (!pa->mapping_table) {
+		err = -ENOMEM;
+		goto err_put_ctrl;
+	}
 
 	/* Initialize max_apid/min_apid to the opposite bounds, during
 	 * the irq domain translation, we are sure to update these */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
