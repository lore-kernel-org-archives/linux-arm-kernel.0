From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 19 Apr 2016 14:18:32 +0200
Subject: [PATCH 3/8] gpio: stmpe: fix edge and rising/falling edge detection
In-Reply-To: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1461068317-28016-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

By cross-checking STMPE 610/801/811/1601/2401/2403 datasheets,
it appears that edge detection and rising/falling edge detection
is not supported by all STMPE variant:

           GPIO              GPIO
      Edge detection     rising/falling
                         edge detection
 610 |      X        |         X       |
 801 |               |                 |
 811 |      X        |         X       |
1600 |               |                 |
1601 |      X        |         X       |
1801 |               |         X       |
2401 |      X        |         X       |
2403 |      X        |         X       |

Rework stmpe_dbg_show_one() and stmpe_gpio_irq to correctly
take these cases into account.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/gpio/gpio-stmpe.c | 58 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 5197edf..225e075 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -231,27 +231,51 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 			   gpio, label ?: "(none)",
 			   val ? "hi" : "lo");
 	} else {
-		u8 edge_det_reg = stmpe->regs[STMPE_IDX_GPEDR_MSB] + num_banks - 1 - (offset / 8);
-		u8 rise_reg = stmpe->regs[STMPE_IDX_GPRER_LSB] - (offset / 8);
-		u8 fall_reg = stmpe->regs[STMPE_IDX_GPFER_LSB] - (offset / 8);
-		u8 irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB] - (offset / 8);
+		u8 edge_det_reg;
+		u8 rise_reg;
+		u8 fall_reg;
+		u8 irqen_reg;
 		bool edge_det;
 		bool rise;
 		bool fall;
 		bool irqen;
 
-		ret = stmpe_reg_read(stmpe, edge_det_reg);
-		if (ret < 0)
-			return;
-		edge_det = !!(ret & mask);
-		ret = stmpe_reg_read(stmpe, rise_reg);
-		if (ret < 0)
+		switch (stmpe->partnum) {
+		case STMPE610:
+		case STMPE811:
+		case STMPE1601:
+		case STMPE2401:
+		case STMPE2403:
+			edge_det_reg = stmpe->regs[STMPE_IDX_GPEDR_MSB] +
+				       num_banks - 1 - (offset / 8);
+			ret = stmpe_reg_read(stmpe, edge_det_reg);
+			if (ret < 0)
+				return;
+			edge_det = !!(ret & mask);
+
+		case STMPE1801:
+			rise_reg = stmpe->regs[STMPE_IDX_GPRER_LSB] -
+				   (offset / 8);
+			fall_reg = stmpe->regs[STMPE_IDX_GPFER_LSB] -
+				   (offset / 8);
+			ret = stmpe_reg_read(stmpe, rise_reg);
+			if (ret < 0)
+				return;
+			rise = !!(ret & mask);
+			ret = stmpe_reg_read(stmpe, fall_reg);
+			if (ret < 0)
+				return;
+			fall = !!(ret & mask);
+
+		case STMPE801:
+			irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB] -
+				    (offset / 8);
+			break;
+
+		default:
 			return;
-		rise = !!(ret & mask);
-		ret = stmpe_reg_read(stmpe, fall_reg);
-		if (ret < 0)
-			return;
-		fall = !!(ret & mask);
+		}
+
 		ret = stmpe_reg_read(stmpe, irqen_reg);
 		if (ret < 0)
 			return;
@@ -322,8 +346,8 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 
 		stmpe_reg_write(stmpe, statmsbreg + i, status[i]);
 
-		/* Edge detect register is not present on 801 */
-		if (stmpe->partnum != STMPE801)
+		/* Edge detect register is not present on 801 and 1801 */
+		if (stmpe->partnum != STMPE801 || stmpe->partnum != STMPE1801)
 			stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_GPEDR_MSB]
 					+ i, status[i]);
 	}
-- 
1.9.1
