From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 19 Apr 2016 14:18:36 +0200
Subject: [PATCH 7/8] gpio: stmpe: Add STMPE1600 support
In-Reply-To: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1461068317-28016-8-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

The particularities of this variant are:
- GPIO_XXX_LSB and GPIO_XXX_MSB memory locations are inverted compared
  to other variants.
- There is no Edge detection, Rising Edge and Falling Edge registers.
- IRQ flags are cleared when read, no need to write in Status register.

Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/gpio/gpio-stmpe.c | 74 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index f8c9d22..45e5b92 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -40,10 +40,15 @@ static int stmpe_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	u8 reg = stmpe->regs[STMPE_IDX_GPMR_LSB] - (offset / 8);
+	u8 reg;
 	u8 mask = 1 << (offset % 8);
 	int ret;
 
+	if (stmpe->partnum == STMPE1600)
+		reg = stmpe->regs[STMPE_IDX_GPMR_LSB] + (offset / 8);
+	else
+		reg = stmpe->regs[STMPE_IDX_GPMR_LSB] - (offset / 8);
+
 	ret = stmpe_reg_read(stmpe, reg);
 	if (ret < 0)
 		return ret;
@@ -56,9 +61,14 @@ static void stmpe_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
 	int which = val ? STMPE_IDX_GPSR_LSB : STMPE_IDX_GPCR_LSB;
-	u8 reg = stmpe->regs[which] - (offset / 8);
+	u8 reg;
 	u8 mask = 1 << (offset % 8);
 
+	if (stmpe->partnum == STMPE1600)
+		reg = stmpe->regs[which] + (offset / 8);
+	else
+		reg = stmpe->regs[which] - (offset / 8);
+
 	/*
 	 * Some variants have single register for gpio set/clear functionality.
 	 * For them we need to write 0 to clear and 1 to set.
@@ -74,9 +84,14 @@ static int stmpe_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	u8 reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+	u8 reg;
 	u8 mask = 1 << (offset % 8);
 
+	if (stmpe->partnum == STMPE1600)
+		reg = stmpe->regs[STMPE_IDX_GPDR_LSB] + (offset / 8);
+	else
+		reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+
 	stmpe_gpio_set(chip, offset, val);
 
 	return stmpe_set_bits(stmpe, reg, mask, mask);
@@ -87,9 +102,14 @@ static int stmpe_gpio_direction_input(struct gpio_chip *chip,
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	u8 reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+	u8 reg;
 	u8 mask = 1 << (offset % 8);
 
+	if (stmpe->partnum == STMPE1600)
+		reg = stmpe->regs[STMPE_IDX_GPDR_LSB] + (offset / 8);
+	else
+		reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+
 	return stmpe_set_bits(stmpe, reg, mask, 0);
 }
 
@@ -126,8 +146,9 @@ static int stmpe_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (type & IRQ_TYPE_LEVEL_LOW || type & IRQ_TYPE_LEVEL_HIGH)
 		return -EINVAL;
 
-	/* STMPE801 doesn't have RE and FE registers */
-	if (stmpe_gpio->stmpe->partnum == STMPE801)
+	/* STMPE801 and STMPE 1600 don't have RE and FE registers */
+	if (stmpe_gpio->stmpe->partnum == STMPE801 ||
+	    stmpe_gpio->stmpe->partnum == STMPE1600)
 		return 0;
 
 	if (type & IRQ_TYPE_EDGE_RISING)
@@ -165,9 +186,10 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 	int i, j;
 
 	for (i = 0; i < CACHE_NR_REGS; i++) {
-		/* STMPE801 doesn't have RE and FE registers */
-		if ((stmpe->partnum == STMPE801) &&
-				(i != REG_IE))
+		/* STMPE801 and STMPE1600 don't have RE and FE registers */
+		if ((stmpe->partnum == STMPE801 ||
+		     stmpe->partnum == STMPE1600) &&
+		     (i != REG_IE))
 			continue;
 
 		for (j = 0; j < num_banks; j++) {
@@ -178,7 +200,14 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 				continue;
 
 			stmpe_gpio->oldregs[i][j] = new;
-			stmpe_reg_write(stmpe, stmpe->regs[regmap[i]] - j, new);
+			if (stmpe->partnum == STMPE1600)
+				stmpe_reg_write(stmpe,
+						stmpe->regs[regmap[i]] + j,
+						new);
+			else
+				stmpe_reg_write(stmpe,
+						stmpe->regs[regmap[i]] - j,
+						new);
 		}
 	}
 
@@ -216,11 +245,16 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 	const char *label = gpiochip_is_requested(gc, offset);
 	int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
 	bool val = !!stmpe_gpio_get(gc, offset);
-	u8 dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+	u8 dir_reg;
 	u8 mask = 1 << (offset % 8);
 	int ret;
 	u8 dir;
 
+	if (stmpe->partnum == STMPE1600)
+		dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB] + (offset / 8);
+	else
+		dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+
 	ret = stmpe_reg_read(stmpe, dir_reg);
 	if (ret < 0)
 		return;
@@ -272,6 +306,11 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 				    (offset / 8);
 			break;
 
+		case STMPE1600:
+			irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB] +
+				    (offset / 8);
+			break;
+
 		default:
 			return;
 		}
@@ -321,12 +360,18 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 	int ret;
 	int i;
 
+	if (stmpe->partnum == STMPE1600)
+		statmsbreg = stmpe->regs[STMPE_IDX_ISGPIOR_LSB];
+	else
+		statmsbreg = stmpe->regs[STMPE_IDX_ISGPIOR_MSB];
+
 	ret = stmpe_block_read(stmpe, statmsbreg, num_banks, status);
 	if (ret < 0)
 		return IRQ_NONE;
 
 	for (i = 0; i < num_banks; i++) {
-		int bank = num_banks - i - 1;
+		int bank = (stmpe_gpio->stmpe->partnum == STMPE1600) ? i :
+			   num_banks - i - 1;
 		unsigned int enabled = stmpe_gpio->regs[REG_IE][bank];
 		unsigned int stat = status[i];
 
@@ -346,10 +391,11 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 
 		/*
 		 * interrupt status register write has no effect on
-		 * 801 and 1801, bits are cleared when read.
+		 * 801/1801/1600, bits are cleared when read.
 		 * Edge detect register is not present on 801 and 1801
 		 */
-		if (stmpe->partnum != STMPE801 || stmpe->partnum != STMPE1801) {
+		if (stmpe->partnum != STMPE801 || stmpe->partnum != STMPE1600 ||
+		    stmpe->partnum != STMPE1801) {
 			stmpe_reg_write(stmpe, statmsbreg + i, status[i]);
 			stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_GPEDR_MSB]
 					+ i, status[i]);
-- 
1.9.1
