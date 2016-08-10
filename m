From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 09:39:06 +0200
Subject: [RESEND v2 01/10] mfd: stmpe: Add STMPE_IDX_SYS_CTRL/2 enum
In-Reply-To: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470814755-19447-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

As STMPE1801/1601/24xx has a SYS_CTRL register and
STMPE1601/2403 has even a SYS_CTRL2 register, add
STMPE_IDX_SYS_CTRL/2 and update driver code accordingly

This update prepares the ground for not yet supported STMPE1600
which share similar REG_SYS_CTRL register.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/stmpe.c       | 21 ++++++++++++++-------
 drivers/mfd/stmpe.h       |  2 ++
 include/linux/mfd/stmpe.h |  2 ++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index fb8f9e8..c553b73 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -448,6 +448,8 @@ static const struct mfd_cell stmpe_ts_cell = {
 
 static const u8 stmpe811_regs[] = {
 	[STMPE_IDX_CHIP_ID]	= STMPE811_REG_CHIP_ID,
+	[STMPE_IDX_SYS_CTRL]	= STMPE811_REG_SYS_CTRL,
+	[STMPE_IDX_SYS_CTRL2]	= STMPE811_REG_SYS_CTRL2,
 	[STMPE_IDX_ICR_LSB]	= STMPE811_REG_INT_CTRL,
 	[STMPE_IDX_IER_LSB]	= STMPE811_REG_INT_EN,
 	[STMPE_IDX_ISR_MSB]	= STMPE811_REG_INT_STA,
@@ -490,7 +492,7 @@ static int stmpe811_enable(struct stmpe *stmpe, unsigned int blocks,
 	if (blocks & STMPE_BLOCK_TOUCHSCREEN)
 		mask |= STMPE811_SYS_CTRL2_TSC_OFF;
 
-	return __stmpe_set_bits(stmpe, STMPE811_REG_SYS_CTRL2, mask,
+	return __stmpe_set_bits(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL2], mask,
 				enable ? 0 : mask);
 }
 
@@ -535,6 +537,8 @@ static struct stmpe_variant_info stmpe610 = {
 
 static const u8 stmpe1601_regs[] = {
 	[STMPE_IDX_CHIP_ID]	= STMPE1601_REG_CHIP_ID,
+	[STMPE_IDX_SYS_CTRL]	= STMPE1601_REG_SYS_CTRL,
+	[STMPE_IDX_SYS_CTRL2]	= STMPE1601_REG_SYS_CTRL2,
 	[STMPE_IDX_ICR_LSB]	= STMPE1601_REG_ICR_LSB,
 	[STMPE_IDX_IER_LSB]	= STMPE1601_REG_IER_LSB,
 	[STMPE_IDX_ISR_MSB]	= STMPE1601_REG_ISR_MSB,
@@ -619,13 +623,13 @@ static int stmpe1601_autosleep(struct stmpe *stmpe,
 		return timeout;
 	}
 
-	ret = __stmpe_set_bits(stmpe, STMPE1601_REG_SYS_CTRL2,
+	ret = __stmpe_set_bits(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL2],
 			STMPE1601_AUTOSLEEP_TIMEOUT_MASK,
 			timeout);
 	if (ret < 0)
 		return ret;
 
-	return __stmpe_set_bits(stmpe, STMPE1601_REG_SYS_CTRL2,
+	return __stmpe_set_bits(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL2],
 			STPME1601_AUTOSLEEP_ENABLE,
 			STPME1601_AUTOSLEEP_ENABLE);
 }
@@ -650,7 +654,7 @@ static int stmpe1601_enable(struct stmpe *stmpe, unsigned int blocks,
 	else
 		mask &= ~STMPE1601_SYS_CTRL_ENABLE_SPWM;
 
-	return __stmpe_set_bits(stmpe, STMPE1601_REG_SYS_CTRL, mask,
+	return __stmpe_set_bits(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL], mask,
 				enable ? mask : 0);
 }
 
@@ -689,6 +693,7 @@ static struct stmpe_variant_info stmpe1601 = {
  */
 static const u8 stmpe1801_regs[] = {
 	[STMPE_IDX_CHIP_ID]	= STMPE1801_REG_CHIP_ID,
+	[STMPE_IDX_SYS_CTRL]	= STMPE1801_REG_SYS_CTRL,
 	[STMPE_IDX_ICR_LSB]	= STMPE1801_REG_INT_CTRL_LOW,
 	[STMPE_IDX_IER_LSB]	= STMPE1801_REG_INT_EN_MASK_LOW,
 	[STMPE_IDX_ISR_LSB]	= STMPE1801_REG_INT_STA_LOW,
@@ -735,14 +740,14 @@ static int stmpe1801_reset(struct stmpe *stmpe)
 	unsigned long timeout;
 	int ret = 0;
 
-	ret = __stmpe_set_bits(stmpe, STMPE1801_REG_SYS_CTRL,
+	ret = __stmpe_set_bits(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL],
 		STMPE1801_MSK_SYS_CTRL_RESET, STMPE1801_MSK_SYS_CTRL_RESET);
 	if (ret < 0)
 		return ret;
 
 	timeout = jiffies + msecs_to_jiffies(100);
 	while (time_before(jiffies, timeout)) {
-		ret = __stmpe_reg_read(stmpe, STMPE1801_REG_SYS_CTRL);
+		ret = __stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL]);
 		if (ret < 0)
 			return ret;
 		if (!(ret & STMPE1801_MSK_SYS_CTRL_RESET))
@@ -773,6 +778,8 @@ static struct stmpe_variant_info stmpe1801 = {
 
 static const u8 stmpe24xx_regs[] = {
 	[STMPE_IDX_CHIP_ID]	= STMPE24XX_REG_CHIP_ID,
+	[STMPE_IDX_SYS_CTRL]	= STMPE24XX_REG_SYS_CTRL,
+	[STMPE_IDX_SYS_CTRL2]	= STMPE24XX_REG_SYS_CTRL2,
 	[STMPE_IDX_ICR_LSB]	= STMPE24XX_REG_ICR_LSB,
 	[STMPE_IDX_IER_LSB]	= STMPE24XX_REG_IER_LSB,
 	[STMPE_IDX_ISR_MSB]	= STMPE24XX_REG_ISR_MSB,
@@ -819,7 +826,7 @@ static int stmpe24xx_enable(struct stmpe *stmpe, unsigned int blocks,
 	if (blocks & STMPE_BLOCK_KEYPAD)
 		mask |= STMPE24XX_SYS_CTRL_ENABLE_KPC;
 
-	return __stmpe_set_bits(stmpe, STMPE24XX_REG_SYS_CTRL, mask,
+	return __stmpe_set_bits(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL], mask,
 				enable ? mask : 0);
 }
 
diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
index 84adb46..406f9f2 100644
--- a/drivers/mfd/stmpe.h
+++ b/drivers/mfd/stmpe.h
@@ -138,6 +138,7 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE811_NR_INTERNAL_IRQS	8
 
 #define STMPE811_REG_CHIP_ID		0x00
+#define STMPE811_REG_SYS_CTRL		0x03
 #define STMPE811_REG_SYS_CTRL2		0x04
 #define STMPE811_REG_SPI_CFG		0x08
 #define STMPE811_REG_INT_CTRL		0x09
@@ -264,6 +265,7 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE24XX_NR_INTERNAL_IRQS	9
 
 #define STMPE24XX_REG_SYS_CTRL		0x02
+#define STMPE24XX_REG_SYS_CTRL2		0x03
 #define STMPE24XX_REG_ICR_LSB		0x11
 #define STMPE24XX_REG_IER_LSB		0x13
 #define STMPE24XX_REG_ISR_MSB		0x14
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index cb83883..6c6690f 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -39,6 +39,8 @@ enum stmpe_partnum {
  */
 enum {
 	STMPE_IDX_CHIP_ID,
+	STMPE_IDX_SYS_CTRL,
+	STMPE_IDX_SYS_CTRL2,
 	STMPE_IDX_ICR_LSB,
 	STMPE_IDX_IER_LSB,
 	STMPE_IDX_ISR_LSB,
-- 
1.9.1
