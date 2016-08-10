From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 09:39:07 +0200
Subject: [RESEND v2 02/10] mfd: stmpe: Add reset support for all STMPE variant
In-Reply-To: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470814755-19447-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Reset was only implemented for STMPE1801 variant despite
all variant have a SOFT_RESET bit.

For STMPE2401/2403/801/1601/1801 SOFT_RESET bit is bit 7
of SYS_CTRL register.
For STMPE610/811 (which have the same variant id) SOFT_RESET
bit is bit 1 of SYS_CTRL register.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/stmpe.c | 23 +++++++++++++++--------
 drivers/mfd/stmpe.h |  7 +++++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index c553b73..af682d0 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -735,13 +735,22 @@ static int stmpe1801_enable(struct stmpe *stmpe, unsigned int blocks,
 				enable ? mask : 0);
 }
 
-static int stmpe1801_reset(struct stmpe *stmpe)
+static int stmpe_reset(struct stmpe *stmpe)
 {
+	u16 id_val = stmpe->variant->id_val;
 	unsigned long timeout;
 	int ret = 0;
+	u8 reset_bit;
+
+	if (id_val == STMPE811_ID)
+		/* STMPE801 and STMPE610 use bit 1 of SYS_CTRL register */
+		reset_bit = STMPE811_SYS_CTRL_RESET;
+	else
+		/* all other STMPE variant use bit 7 of SYS_CTRL register */
+		reset_bit = STMPE_SYS_CTRL_RESET;
 
 	ret = __stmpe_set_bits(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL],
-		STMPE1801_MSK_SYS_CTRL_RESET, STMPE1801_MSK_SYS_CTRL_RESET);
+			       reset_bit, reset_bit);
 	if (ret < 0)
 		return ret;
 
@@ -750,7 +759,7 @@ static int stmpe1801_reset(struct stmpe *stmpe)
 		ret = __stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_SYS_CTRL]);
 		if (ret < 0)
 			return ret;
-		if (!(ret & STMPE1801_MSK_SYS_CTRL_RESET))
+		if (!(ret & reset_bit))
 			return 0;
 		usleep_range(100, 200);
 	}
@@ -1074,11 +1083,9 @@ static int stmpe_chip_init(struct stmpe *stmpe)
 	if (ret)
 		return ret;
 
-	if (id == STMPE1801_ID)	{
-		ret =  stmpe1801_reset(stmpe);
-		if (ret < 0)
-			return ret;
-	}
+	ret =  stmpe_reset(stmpe);
+	if (ret < 0)
+		return ret;
 
 	if (stmpe->irq >= 0) {
 		if (id == STMPE801_ID)
diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
index 406f9f2..4ae343d 100644
--- a/drivers/mfd/stmpe.h
+++ b/drivers/mfd/stmpe.h
@@ -104,6 +104,8 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE_ICR_LSB_EDGE	(1 << 1)
 #define STMPE_ICR_LSB_GIM	(1 << 0)
 
+#define STMPE_SYS_CTRL_RESET	(1 << 7)
+
 /*
  * STMPE801
  */
@@ -126,6 +128,7 @@ int stmpe_remove(struct stmpe *stmpe);
 /*
  * STMPE811
  */
+#define STMPE811_ID			0x0811
 
 #define STMPE811_IRQ_TOUCH_DET		0
 #define STMPE811_IRQ_FIFO_TH		1
@@ -155,6 +158,8 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE811_REG_GPIO_FE		0x16
 #define STMPE811_REG_GPIO_AF		0x17
 
+#define STMPE811_SYS_CTRL_RESET		(1 << 1)
+
 #define STMPE811_SYS_CTRL2_ADC_OFF	(1 << 0)
 #define STMPE811_SYS_CTRL2_TSC_OFF	(1 << 1)
 #define STMPE811_SYS_CTRL2_GPIO_OFF	(1 << 2)
@@ -244,8 +249,6 @@ int stmpe_remove(struct stmpe *stmpe);
 #define STMPE1801_REG_GPIO_PULL_UP_MID		0x23
 #define STMPE1801_REG_GPIO_PULL_UP_HIGH		0x24
 
-#define STMPE1801_MSK_SYS_CTRL_RESET		(1 << 7)
-
 #define STMPE1801_MSK_INT_EN_KPC		(1 << 1)
 #define STMPE1801_MSK_INT_EN_GPIO		(1 << 3)
 
-- 
1.9.1
