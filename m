From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 19 Apr 2016 14:18:33 +0200
Subject: [PATCH 4/8] gpio: stmpe: write int status register only when needed
In-Reply-To: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1461068317-28016-5-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

On STMPE801/1801 datasheets, it's mentionned writing
in interrupt status register has no effect, bits are
cleared when reading.

Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/gpio/gpio-stmpe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 225e075..f8c9d22 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -344,12 +344,16 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
 			stat &= ~(1 << bit);
 		}
 
-		stmpe_reg_write(stmpe, statmsbreg + i, status[i]);
-
-		/* Edge detect register is not present on 801 and 1801 */
-		if (stmpe->partnum != STMPE801 || stmpe->partnum != STMPE1801)
+		/*
+		 * interrupt status register write has no effect on
+		 * 801 and 1801, bits are cleared when read.
+		 * Edge detect register is not present on 801 and 1801
+		 */
+		if (stmpe->partnum != STMPE801 || stmpe->partnum != STMPE1801) {
+			stmpe_reg_write(stmpe, statmsbreg + i, status[i]);
 			stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_GPEDR_MSB]
 					+ i, status[i]);
+		}
 	}
 
 	return IRQ_HANDLED;
-- 
1.9.1
