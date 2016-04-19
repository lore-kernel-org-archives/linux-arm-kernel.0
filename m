From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 19 Apr 2016 14:18:35 +0200
Subject: [PATCH 6/8] mfd: Add STMPE1600 support
In-Reply-To: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1461068317-28016-7-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

STMPE1600 is a 16-bit port expander.
Datasheet is available here :
http://www2.st.com/content/st_com/en/products/interfaces-and-transceivers/
i-o-expanders-and-level-translators/i-o-expanders/stmpe1600.html

As STMPE1600's SYS_CTRL register has the same layout as
STMPE801 variant, unify STMPExxx_REG_SYS_CTRL_RESET/INT_EN/INT_HI
bit masks to more generic STMPE_SYS_CTRL_RESET/INT_EN/INT_HI

Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/mfd/stmpe-i2c.c   |  2 ++
 drivers/mfd/stmpe.c       | 61 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mfd/stmpe.h       | 21 ++++++++++++----
 include/linux/mfd/stmpe.h |  1 +
 4 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index c3f4aab..863c39a 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -57,6 +57,7 @@ static const struct of_device_id stmpe_of_match[] = {
 	{ .compatible = "st,stmpe610", .data = (void *)STMPE610, },
 	{ .compatible = "st,stmpe801", .data = (void *)STMPE801, },
 	{ .compatible = "st,stmpe811", .data = (void *)STMPE811, },
+	{ .compatible = "st,stmpe1600", .data = (void *)STMPE1600, },
 	{ .compatible = "st,stmpe1601", .data = (void *)STMPE1601, },
 	{ .compatible = "st,stmpe1801", .data = (void *)STMPE1801, },
 	{ .compatible = "st,stmpe2401", .data = (void *)STMPE2401, },
@@ -101,6 +102,7 @@ static const struct i2c_device_id stmpe_i2c_id[] = {
 	{ "stmpe610", STMPE610 },
 	{ "stmpe801", STMPE801 },
 	{ "stmpe811", STMPE811 },
+	{ "stmpe1600", STMPE1600 },
 	{ "stmpe1601", STMPE1601 },
 	{ "stmpe1801", STMPE1801 },
 	{ "stmpe2401", STMPE2401 },
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index af682d0..53f61b9 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -532,6 +532,51 @@ static struct stmpe_variant_info stmpe610 = {
 };
 
 /*
+ * STMPE1600
+ */
+
+static const u8 stmpe1600_regs[] = {
+	[STMPE_IDX_CHIP_ID]	= STMPE1600_REG_CHIP_ID,
+	[STMPE_IDX_SYS_CTRL]	= STMPE1600_REG_SYS_CTRL,
+	[STMPE_IDX_ICR_LSB]	= STMPE1600_REG_SYS_CTRL,
+	[STMPE_IDX_GPMR_LSB]	= STMPE1600_REG_GPMR,
+	[STMPE_IDX_GPSR_LSB]	= STMPE1600_REG_GPSR,
+	[STMPE_IDX_GPDR_LSB]	= STMPE1600_REG_GPDR,
+	[STMPE_IDX_IEGPIOR_LSB]	= STMPE1600_REG_IEGPIOR,
+	[STMPE_IDX_ISGPIOR_LSB]	= STMPE1600_REG_ISGPIOR,
+};
+
+static struct stmpe_variant_block stmpe1600_blocks[] = {
+	{
+		.cell	= &stmpe_gpio_cell,
+		.irq	= 0,
+		.block	= STMPE_BLOCK_GPIO,
+	},
+};
+
+static int stmpe1600_enable(struct stmpe *stmpe, unsigned int blocks,
+			   bool enable)
+{
+	if (blocks & STMPE_BLOCK_GPIO)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+static struct stmpe_variant_info stmpe1600 = {
+	.name		= "stmpe1600",
+	.id_val		= STMPE1600_ID,
+	.id_mask	= 0xffff,
+	.num_gpios	= 16,
+	.af_bits	= 0,
+	.regs		= stmpe1600_regs,
+	.blocks		= stmpe1600_blocks,
+	.num_blocks	= ARRAY_SIZE(stmpe1600_blocks),
+	.num_irqs	= STMPE1600_NR_INTERNAL_IRQS,
+	.enable		= stmpe1600_enable,
+};
+
+/*
  * STMPE1601
  */
 
@@ -888,6 +933,7 @@ static struct stmpe_variant_info *stmpe_variant_info[STMPE_NBR_PARTS] = {
 	[STMPE610]	= &stmpe610,
 	[STMPE801]	= &stmpe801,
 	[STMPE811]	= &stmpe811,
+	[STMPE1600]	= &stmpe1600,
 	[STMPE1601]	= &stmpe1601,
 	[STMPE1801]	= &stmpe1801,
 	[STMPE2401]	= &stmpe2401,
@@ -914,7 +960,8 @@ static irqreturn_t stmpe_irq(int irq, void *data)
 	int ret;
 	int i;
 
-	if (variant->id_val == STMPE801_ID) {
+	if (variant->id_val == STMPE801_ID ||
+	    variant->id_val == STMPE1600_ID) {
 		int base = irq_create_mapping(stmpe->domain, 0);
 
 		handle_nested_irq(base);
@@ -1088,13 +1135,13 @@ static int stmpe_chip_init(struct stmpe *stmpe)
 		return ret;
 
 	if (stmpe->irq >= 0) {
-		if (id == STMPE801_ID)
-			icr = STMPE801_REG_SYS_CTRL_INT_EN;
+		if (id == STMPE801_ID || id == STMPE1600_ID)
+			icr = STMPE_SYS_CTRL_INT_EN;
 		else
 			icr = STMPE_ICR_LSB_GIM;
 
-		/* STMPE801 doesn't support Edge interrupts */
-		if (id != STMPE801_ID) {
+		/* STMPE801 and STMPE1600 don't support Edge interrupts */
+		if (id != STMPE801_ID && id != STMPE1600_ID) {
 			if (irq_trigger == IRQF_TRIGGER_FALLING ||
 					irq_trigger == IRQF_TRIGGER_RISING)
 				icr |= STMPE_ICR_LSB_EDGE;
@@ -1102,8 +1149,8 @@ static int stmpe_chip_init(struct stmpe *stmpe)
 
 		if (irq_trigger == IRQF_TRIGGER_RISING ||
 				irq_trigger == IRQF_TRIGGER_HIGH) {
-			if (id == STMPE801_ID)
-				icr |= STMPE801_REG_SYS_CTRL_INT_HI;
+			if (id == STMPE801_ID || id == STMPE1600_ID)
+				icr |= STMPE_SYS_CTRL_INT_HI;
 			else
 				icr |= STMPE_ICR_LSB_HIGH;
 		}
diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
index 4ae343d..c829caa 100644
--- a/drivers/mfd/stmpe.h
+++ b/drivers/mfd/stmpe.h
@@ -105,6 +105,8 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE_ICR_LSB_GIM	(1 << 0)
 
 #define STMPE_SYS_CTRL_RESET	(1 << 7)
+#define STMPE_SYS_CTRL_INT_EN	(1 << 2)
+#define STMPE_SYS_CTRL_INT_HI	(1 << 0)
 
 /*
  * STMPE801
@@ -121,10 +123,6 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE801_REG_GPIO_SET_PIN	0x11
 #define STMPE801_REG_GPIO_DIR		0x12
 
-#define STMPE801_REG_SYS_CTRL_RESET	(1 << 7)
-#define STMPE801_REG_SYS_CTRL_INT_EN	(1 << 2)
-#define STMPE801_REG_SYS_CTRL_INT_HI	(1 << 0)
-
 /*
  * STMPE811
  */
@@ -166,6 +164,21 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE811_SYS_CTRL2_TS_OFF	(1 << 3)
 
 /*
+ * STMPE1600
+ */
+#define STMPE1600_ID			0x0016
+#define STMPE1600_NR_INTERNAL_IRQS	16
+
+#define STMPE1600_REG_CHIP_ID		0x00
+#define STMPE1600_REG_SYS_CTRL		0x03
+#define STMPE1600_REG_IEGPIOR		0x08
+#define STMPE1600_REG_ISGPIOR		0x0A
+#define STMPE1600_REG_GPMR		0x10
+#define STMPE1600_REG_GPSR		0x12
+#define STMPE1600_REG_GPDR		0x14
+#define STMPE1600_REG_GPPIR		0x16
+
+/*
  * STMPE1601
  */
 
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index 6c6690f..2d94ac7 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -26,6 +26,7 @@ enum stmpe_partnum {
 	STMPE610,
 	STMPE801,
 	STMPE811,
+	STMPE1600,
 	STMPE1601,
 	STMPE1801,
 	STMPE2401,
-- 
1.9.1
