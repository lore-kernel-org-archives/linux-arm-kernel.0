From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 22 Nov 2011 09:24:18 +0100
Subject: [PATCH 1/7] spi/pl022: only enable RX interrupts when TX is complete
Message-ID: <1321950258-4683-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Blair <chris.blair@stericsson.com>

For interrupt mode transfers, start with only TX interrupts enabled
to reduce the overall number of interrupts received. Once TX is
complete, enable RX interrupts to complete the transfer.

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Chris Blair <chris.blair@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix comment style, add Viresh's Reviewed-by
---
 drivers/spi/spi-pl022.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 5559b22..5b7209f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1244,9 +1244,9 @@ static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 
 	if ((pl022->tx == pl022->tx_end) && (flag == 0)) {
 		flag = 1;
-		/* Disable Transmit interrupt */
-		writew(readw(SSP_IMSC(pl022->virtbase)) &
-		       (~SSP_IMSC_MASK_TXIM),
+		/* Disable Transmit interrupt, enable receive interrupt */
+		writew((readw(SSP_IMSC(pl022->virtbase)) &
+		       ~SSP_IMSC_MASK_TXIM) | SSP_IMSC_MASK_RXIM,
 		       SSP_IMSC(pl022->virtbase));
 	}
 
@@ -1379,12 +1379,17 @@ static void pump_transfers(unsigned long data)
 	}
 
 err_config_dma:
-	writew(ENABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
+	/* enable all interrupts except RX */
+	writew(ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM, SSP_IMSC(pl022->virtbase));
 }
 
 static void do_interrupt_dma_transfer(struct pl022 *pl022)
 {
-	u32 irqflags = ENABLE_ALL_INTERRUPTS;
+	/*
+	 * Default is to enable all interrupts except RX -
+	 * this will be enabled once TX is complete
+	 */
+	u32 irqflags = ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM;
 
 	/* Enable target chip */
 	pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
-- 
1.7.3.2
