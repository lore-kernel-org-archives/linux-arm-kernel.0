From: danindrey@mail.ru (Andrey Danin)
Date: Mon, 20 Jul 2015 23:35:45 +0300
Subject: [PATCH v3 3/4] staging/nvec: remove old code
In-Reply-To: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
Message-ID: <1437424546-30405-4-git-send-email-danindrey@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
No changes for v3

No changes for v2

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
 drivers/staging/nvec/nvec.c | 211 --------------------------------------------
 1 file changed, 211 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 7da3dfe..fc0ee5c 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -516,23 +516,6 @@ static void nvec_rx_completed(struct nvec_chip *nvec)
 	schedule_work(&nvec->rx_work);
 }
 
-#if 0
-/**
- * nvec_invalid_flags - Send an error message about invalid flags and jump
- * @nvec: The nvec device
- * @status: The status flags
- * @reset: Whether we shall jump to state 0.
- */
-static void nvec_invalid_flags(struct nvec_chip *nvec, unsigned int status,
-			       bool reset)
-{
-	dev_err(nvec->dev, "unexpected status flags 0x%02x during state %i\n",
-		status, nvec->state);
-	if (reset)
-		nvec->state = 0;
-}
-#endif /* FIXME: remove old code */
-
 /**
  * nvec_tx_set - Set the message to transfer (nvec->tx)
  * @nvec: A &struct nvec_chip
@@ -562,200 +545,6 @@ static void nvec_tx_set(struct nvec_chip *nvec)
 		(uint)nvec->tx->size, nvec->tx->data[1]);
 }
 
-
-#if 0
-/**
- * nvec_interrupt - Interrupt handler
- * @irq: The IRQ
- * @dev: The nvec device
- *
- * Interrupt handler that fills our RX buffers and empties our TX
- * buffers. This uses a finite state machine with ridiculous amounts
- * of error checking, in order to be fairly reliable.
- */
-static irqreturn_t nvec_interrupt(int irq, void *dev)
-{
-	unsigned long status;
-	unsigned int received = 0;
-	unsigned char to_send = 0xff;
-	const unsigned long irq_mask = I2C_SL_IRQ | END_TRANS | RCVD | RNW;
-	struct nvec_chip *nvec = dev;
-	unsigned int state = nvec->state;
-
-	status = readl(nvec->base + I2C_SL_STATUS);
-
-	/* Filter out some errors */
-	if ((status & irq_mask) == 0 && (status & ~irq_mask) != 0) {
-		dev_err(nvec->dev, "unexpected irq mask %lx\n", status);
-		return IRQ_HANDLED;
-	}
-	if ((status & I2C_SL_IRQ) == 0) {
-		dev_err(nvec->dev, "Spurious IRQ\n");
-		return IRQ_HANDLED;
-	}
-
-	/* The EC did not request a read, so it send us something, read it */
-	if ((status & RNW) == 0) {
-		received = readl(nvec->base + I2C_SL_RCVD);
-		if (status & RCVD)
-			writel(0, nvec->base + I2C_SL_RCVD);
-	}
-
-	if (status == (I2C_SL_IRQ | RCVD))
-		nvec->state = 0;
-
-	switch (nvec->state) {
-	case 0:		/* Verify that its a transfer start, the rest later */
-		if (status != (I2C_SL_IRQ | RCVD))
-			nvec_invalid_flags(nvec, status, false);
-		break;
-	case 1:		/* command byte */
-		if (status != I2C_SL_IRQ) {
-			nvec_invalid_flags(nvec, status, true);
-		} else {
-			nvec->rx = nvec_msg_alloc(nvec, NVEC_MSG_RX);
-			/* Should not happen in a normal world */
-			if (unlikely(nvec->rx == NULL)) {
-				nvec->state = 0;
-				break;
-			}
-			nvec->rx->data[0] = received;
-			nvec->rx->pos = 1;
-			nvec->state = 2;
-		}
-		break;
-	case 2:		/* first byte after command */
-		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
-			udelay(33);
-			if (nvec->rx->data[0] != 0x01) {
-				dev_err(nvec->dev,
-					"Read without prior read command\n");
-				nvec->state = 0;
-				break;
-			}
-			nvec_msg_free(nvec, nvec->rx);
-			nvec->state = 3;
-			nvec_tx_set(nvec);
-			BUG_ON(nvec->tx->size < 1);
-			to_send = nvec->tx->data[0];
-			nvec->tx->pos = 1;
-		} else if (status == (I2C_SL_IRQ)) {
-			BUG_ON(nvec->rx == NULL);
-			nvec->rx->data[1] = received;
-			nvec->rx->pos = 2;
-			nvec->state = 4;
-		} else {
-			nvec_invalid_flags(nvec, status, true);
-		}
-		break;
-	case 3:		/* EC does a block read, we transmit data */
-		if (status & END_TRANS) {
-			nvec_tx_completed(nvec);
-		} else if ((status & RNW) == 0 || (status & RCVD)) {
-			nvec_invalid_flags(nvec, status, true);
-		} else if (nvec->tx && nvec->tx->pos < nvec->tx->size) {
-			to_send = nvec->tx->data[nvec->tx->pos++];
-		} else {
-			dev_err(nvec->dev, "tx buffer underflow on %p (%u > %u)\n",
-				nvec->tx,
-				(uint) (nvec->tx ? nvec->tx->pos : 0),
-				(uint) (nvec->tx ? nvec->tx->size : 0));
-			nvec->state = 0;
-		}
-		break;
-	case 4:		/* EC does some write, we read the data */
-		if ((status & (END_TRANS | RNW)) == END_TRANS)
-			nvec_rx_completed(nvec);
-		else if (status & (RNW | RCVD))
-			nvec_invalid_flags(nvec, status, true);
-		else if (nvec->rx && nvec->rx->pos < NVEC_MSG_SIZE)
-			nvec->rx->data[nvec->rx->pos++] = received;
-		else
-			dev_err(nvec->dev,
-				"RX buffer overflow on %p: Trying to write byte %u of %u\n",
-				nvec->rx, nvec->rx ? nvec->rx->pos : 0,
-				NVEC_MSG_SIZE);
-		break;
-	default:
-		nvec->state = 0;
-	}
-
-	/* If we are told that a new transfer starts, verify it */
-	if ((status & (RCVD | RNW)) == RCVD) {
-		if (received != nvec->i2c_addr)
-			dev_err(nvec->dev,
-			"received address 0x%02x, expected 0x%02x\n",
-			received, nvec->i2c_addr);
-		nvec->state = 1;
-	}
-
-	/* Send data if requested, but not on end of transmission */
-	if ((status & (RNW | END_TRANS)) == RNW)
-		writel(to_send, nvec->base + I2C_SL_RCVD);
-
-	/* If we have send the first byte */
-	if (status == (I2C_SL_IRQ | RNW | RCVD))
-		nvec_gpio_set_value(nvec, 1);
-
-	dev_dbg(nvec->dev,
-		"Handled: %s 0x%02x, %s 0x%02x in state %u [%s%s%s]\n",
-		(status & RNW) == 0 ? "received" : "R=",
-		received,
-		(status & (RNW | END_TRANS)) ? "sent" : "S=",
-		to_send,
-		state,
-		status & END_TRANS ? " END_TRANS" : "",
-		status & RCVD ? " RCVD" : "",
-		status & RNW ? " RNW" : "");
-
-
-	/*
-	 * TODO: A correct fix needs to be found for this.
-	 *
-	 * We experience less incomplete messages with this delay than without
-	 * it, but we don't know why. Help is appreciated.
-	 */
-	udelay(100);
-
-	return IRQ_HANDLED;
-}
-
-static void tegra_init_i2c_slave(struct nvec_chip *nvec)
-{
-	u32 val;
-
-	clk_prepare_enable(nvec->i2c_clk);
-
-	reset_control_assert(nvec->rst);
-	udelay(2);
-	reset_control_deassert(nvec->rst);
-
-	val = I2C_CNFG_NEW_MASTER_SFM | I2C_CNFG_PACKET_MODE_EN |
-	    (0x2 << I2C_CNFG_DEBOUNCE_CNT_SHIFT);
-	writel(val, nvec->base + I2C_CNFG);
-
-	clk_set_rate(nvec->i2c_clk, 8 * 80000);
-
-	writel(I2C_SL_NEWSL, nvec->base + I2C_SL_CNFG);
-	writel(0x1E, nvec->base + I2C_SL_DELAY_COUNT);
-
-	writel(nvec->i2c_addr>>1, nvec->base + I2C_SL_ADDR1);
-	writel(0, nvec->base + I2C_SL_ADDR2);
-
-	enable_irq(nvec->irq);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static void nvec_disable_i2c_slave(struct nvec_chip *nvec)
-{
-	disable_irq(nvec->irq);
-	writel(I2C_SL_NEWSL | I2C_SL_NACK, nvec->base + I2C_SL_CNFG);
-	clk_disable_unprepare(nvec->i2c_clk);
-}
-#endif
-#endif /* FIXME: remove old code. */
-
-
 /**
  * nvec_slave_cb - I2C slave callback
  *
-- 
1.9.1
