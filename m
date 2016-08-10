From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 09:39:12 +0200
Subject: [RESEND v2 07/10] gpio: stmpe: rework registers access
In-Reply-To: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470814755-19447-8-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This update allows to use registers map as following :
regs[reg_index + offset] instead of
regs[reg_index] + offset

This makes code clearer and will facilitate the addition of STMPE1600
on which LSB and MSB registers are respectively located at addr and addr + 1.
Despite for all others STMPE variant, LSB and MSB registers are respectively
located in reverse order at addr + 1 and addr.

For variant which have 3 registers's bank, we use LSB,CSB and MSB indexes
which contains respectively LSB (or LOW), CSB (or MID) and MSB (or HIGH)
register addresses (STMPE1801/STMPE24xx).
For variant which have 2 registers's bank, we use LSB and CSB indexes only.
In this case the CSB index contains the MSB regs address (STMPE 1601).

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-stmpe.c | 48 ++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 2789bdc..6d6d76a 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -21,6 +21,8 @@
  */
 enum { REG_RE, REG_FE, REG_IE };
 
+enum { LSB, CSB, MSB };
+
 #define CACHE_NR_REGS	3
 /* No variant has more than 24 GPIOs */
 #define CACHE_NR_BANKS	(24 / 8)
@@ -40,7 +42,7 @@ static int stmpe_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	u8 reg = stmpe->regs[STMPE_IDX_GPMR_LSB] - (offset / 8);
+	u8 reg = stmpe->regs[STMPE_IDX_GPMR_LSB + (offset / 8)];
 	u8 mask = 1 << (offset % 8);
 	int ret;
 
@@ -56,7 +58,7 @@ static void stmpe_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
 	int which = val ? STMPE_IDX_GPSR_LSB : STMPE_IDX_GPCR_LSB;
-	u8 reg = stmpe->regs[which] - (offset / 8);
+	u8 reg = stmpe->regs[which + (offset / 8)];
 	u8 mask = 1 << (offset % 8);
 
 	/*
@@ -74,7 +76,7 @@ static int stmpe_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	u8 reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+	u8 reg = stmpe->regs[STMPE_IDX_GPDR_LSB + (offset / 8)];
 	u8 mask = 1 << (offset % 8);
 
 	stmpe_gpio_set(chip, offset, val);
@@ -87,7 +89,7 @@ static int stmpe_gpio_direction_input(struct gpio_chip *chip,
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(chip);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	u8 reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+	u8 reg = stmpe->regs[STMPE_IDX_GPDR_LSB + (offset / 8)];
 	u8 mask = 1 << (offset % 8);
 
 	return stmpe_set_bits(stmpe, reg, mask, 0);
@@ -157,10 +159,16 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(gc);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
 	int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
-	static const u8 regmap[] = {
-		[REG_RE]	= STMPE_IDX_GPRER_LSB,
-		[REG_FE]	= STMPE_IDX_GPFER_LSB,
-		[REG_IE]	= STMPE_IDX_IEGPIOR_LSB,
+	static const u8 regmap[CACHE_NR_REGS][CACHE_NR_BANKS] = {
+		[REG_RE][LSB] = STMPE_IDX_GPRER_LSB,
+		[REG_RE][CSB] = STMPE_IDX_GPRER_CSB,
+		[REG_RE][MSB] = STMPE_IDX_GPRER_MSB,
+		[REG_FE][LSB] = STMPE_IDX_GPFER_LSB,
+		[REG_FE][CSB] = STMPE_IDX_GPFER_CSB,
+		[REG_FE][MSB] = STMPE_IDX_GPFER_MSB,
+		[REG_IE][LSB] = STMPE_IDX_IEGPIOR_LSB,
+		[REG_IE][CSB] = STMPE_IDX_IEGPIOR_CSB,
+		[REG_IE][MSB] = STMPE_IDX_IEGPIOR_MSB,
 	};
 	int i, j;
 
@@ -178,7 +186,7 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 				continue;
 
 			stmpe_gpio->oldregs[i][j] = new;
-			stmpe_reg_write(stmpe, stmpe->regs[regmap[i]] - j, new);
+			stmpe_reg_write(stmpe, stmpe->regs[regmap[i][j]], new);
 		}
 	}
 
@@ -214,9 +222,9 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(gc);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
 	const char *label = gpiochip_is_requested(gc, offset);
-	int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
 	bool val = !!stmpe_gpio_get(gc, offset);
-	u8 dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);
+	u8 bank = offset / 8;
+	u8 dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB + bank];
 	u8 mask = 1 << (offset % 8);
 	int ret;
 	u8 dir;
@@ -257,18 +265,16 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 		case STMPE1601:
 		case STMPE2401:
 		case STMPE2403:
-			edge_det_reg = stmpe->regs[STMPE_IDX_GPEDR_MSB] +
-				       num_banks - 1 - (offset / 8);
+			edge_det_reg = stmpe->regs[STMPE_IDX_GPEDR_LSB + bank];
 			ret = stmpe_reg_read(stmpe, edge_det_reg);
 			if (ret < 0)
 				return;
 			edge_det = !!(ret & mask);
 
 		case STMPE1801:
-			rise_reg = stmpe->regs[STMPE_IDX_GPRER_LSB] -
-				   (offset / 8);
-			fall_reg = stmpe->regs[STMPE_IDX_GPFER_LSB] -
-				   (offset / 8);
+			rise_reg = stmpe->regs[STMPE_IDX_GPRER_LSB + bank];
+			fall_reg = stmpe->regs[STMPE_IDX_GPFER_LSB + bank];
+
 			ret = stmpe_reg_read(stmpe, rise_reg);
 			if (ret < 0)
 				return;
@@ -279,8 +285,7 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 			fall = !!(ret & mask);
 
 		case STMPE801:
-			irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB] -
-				    (offset / 8);
+			irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB + bank];
 			break;
 
 		default:
@@ -362,8 +367,9 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 		 */
 		if (stmpe->partnum != STMPE801 || stmpe->partnum != STMPE1801) {
 			stmpe_reg_write(stmpe, statmsbreg + i, status[i]);
-			stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_GPEDR_MSB]
-					+ i, status[i]);
+			stmpe_reg_write(stmpe,
+					stmpe->regs[STMPE_IDX_GPEDR_LSB + i],
+					status[i]);
 		}
 	}
 
-- 
1.9.1
