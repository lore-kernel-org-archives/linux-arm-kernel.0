From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 21 Aug 2010 11:07:36 +0200
Subject: [PATCH] SPI: fix APB pclk power regression on U300
Message-ID: <1282381656-8644-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of an AMBA PrimeCell per-cell block clock,
the pclk was left on after probe() unless explicitly disabled.
This clock is wired to the same clock on PL022 causing it to stay
always on since.

Fix this up properly by clocking the pclk whenever we want to
write into any PL022 registers and clocking the external clock
whenever we want to transmit messages on the bus.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Tested on U300 and U8500, even though the pclk stuff came in from
the ARM tree it is probably better to carry this through Grants
tree so as not to disturb other patches going in for PL022.
---
 drivers/spi/amba-pl022.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 5b3f575..59f8cfb 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -503,8 +503,9 @@ static void giveback(struct pl022 *pl022)
 	msg->state = NULL;
 	if (msg->complete)
 		msg->complete(msg->context);
-	/* This message is completed, so let's turn off the clock! */
+	/* This message is completed, so let's turn off the clocks! */
 	clk_disable(pl022->clk);
+	amba_pclk_disable(pl022->adev);
 }
 
 /**
@@ -1139,9 +1140,10 @@ static void pump_messages(struct work_struct *work)
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip = spi_get_ctldata(pl022->cur_msg->spi);
 	/*
-	 * We enable the clock here, then the clock will be disabled when
+	 * We enable the clocks here, then the clocks will be disabled when
 	 * giveback() is called in each method (poll/interrupt/DMA)
 	 */
+	amba_pclk_enable(pl022->adev);
 	clk_enable(pl022->clk);
 	restore_state(pl022);
 	flush(pl022);
@@ -1787,11 +1789,9 @@ pl022_probe(struct amba_device *adev, struct amba_id *id)
 	}
 
 	/* Disable SSP */
-	clk_enable(pl022->clk);
 	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
 	       SSP_CR1(pl022->virtbase));
 	load_ssp_default_config(pl022);
-	clk_disable(pl022->clk);
 
 	status = request_irq(adev->irq[0], pl022_interrupt_handler, 0, "pl022",
 			     pl022);
@@ -1819,6 +1819,8 @@ pl022_probe(struct amba_device *adev, struct amba_id *id)
 		goto err_spi_register;
 	}
 	dev_dbg(dev, "probe succeded\n");
+	/* Disable the silicon block pclk and clock it when needed */
+	amba_pclk_disable(adev);
 	return 0;
 
  err_spi_register:
@@ -1880,9 +1882,9 @@ static int pl022_suspend(struct amba_device *adev, pm_message_t state)
 		return status;
 	}
 
-	clk_enable(pl022->clk);
+	amba_pclk_enable(adev);
 	load_ssp_default_config(pl022);
-	clk_disable(pl022->clk);
+	amba_pclk_disable(adev);
 	dev_dbg(&adev->dev, "suspended\n");
 	return 0;
 }
-- 
1.6.3.3
