From: mr.nuke.me@gmail.com (Alexandru Gagniuc)
Date: Wed, 19 Mar 2014 15:41:08 -0500
Subject: [PATCH v2 1/1] ARM: sun4i: spi: Allow transfers larger than FIFO size
In-Reply-To: <1395261670-19386-1-git-send-email-mr.nuke.me@gmail.com>
References: <1395261670-19386-1-git-send-email-mr.nuke.me@gmail.com>
Message-ID: <1395261670-19386-2-git-send-email-mr.nuke.me@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI transfers were limited to one FIFO depth, which is 64 bytes.
This was an artificial limitation, however, as the hardware can handle
much larger bursts. To accommodate this, we enable the interrupt when
the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
handler. The 3/4 ratio was chosen arbitrarily, with the intention to
reduce the potential number of interrupts.

Since the SUN4I_CTL_TP bit is set, the hardware will pause
transmission whenever the FIFO is full, so there is no risk of losing
data if we can't service the interrupt in time.

For the Tx side, enable and use the Tx FIFO 3/4 empty interrupt to
replenish the FIFO on large SPI bursts. This requires more care in
when the interrupt is left enabled, as this interrupt will continually
trigger when the FIFO is less than 1/4 full, even though we
acknowledge it.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/spi/spi-sun4i.c | 68 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 3f82705..a12da6d 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -47,6 +47,8 @@
 #define SUN4I_CTL_TP				BIT(18)

 #define SUN4I_INT_CTL_REG		0x0c
+#define SUN4I_INT_CTL_RF_F34			BIT(4)
+#define SUN4I_INT_CTL_TF_E34			BIT(12)
 #define SUN4I_INT_CTL_TC			BIT(16)

 #define SUN4I_INT_STA_REG		0x10
@@ -68,6 +70,8 @@
 #define SUN4I_XMIT_CNT_REG		0x24
 #define SUN4I_XMIT_CNT(cnt)			((cnt) & 0xffffff)

+#define SUN4I_MAX_XFER_SIZE			0xffffff
+
 #define SUN4I_FIFO_STA_REG		0x28
 #define SUN4I_FIFO_STA_RF_CNT_MASK		0x7f
 #define SUN4I_FIFO_STA_RF_CNT_BITS		0
@@ -97,6 +101,28 @@ static inline void sun4i_spi_write(struct sun4i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }

+static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
+{
+	u32 reg;
+	reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
+	reg >>= SUN4I_FIFO_STA_TF_CNT_BITS;
+	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
+}
+
+static inline void sun4i_spi_enable_interrupt(struct sun4i_spi *sspi, u32 mask)
+{
+	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	reg |= mask;
+	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+}
+
+static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi, u32 mask)
+{
+	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	reg &= ~mask;
+	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+}
+
 static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
 {
 	u32 reg, cnt;
@@ -119,8 +145,15 @@ static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)

 static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
 {
+	u32 cnt;
 	u8 byte;

+	/* See how much data we can fit */
+	cnt = SUN4I_FIFO_DEPTH - sun4i_spi_get_tx_fifo_count(sspi);
+
+	if (len > cnt)
+		len = cnt;
+
 	if (len > sspi->len)
 		len = sspi->len;

@@ -175,8 +208,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	int ret = 0;
 	u32 reg;

-	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN4I_FIFO_DEPTH)
+	if (tfr->len > SUN4I_MAX_XFER_SIZE)
 		return -EINVAL;

 	reinit_completion(&sspi->done);
@@ -274,7 +306,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);

 	/* Enable the interrupts */
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
+	reg = SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
+	/* Only enable Tx FIFO interrupt if we really need it */
+	if (tx_len > SUN4I_FIFO_DEPTH)
+		reg |= SUN4I_INT_CTL_TF_E34;
+	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);

 	/* Start the transfer */
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
@@ -287,8 +323,6 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}

-	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
-
 out:
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);

@@ -299,14 +333,38 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 {
 	struct sun4i_spi *sspi = dev_id;
 	u32 status = sun4i_spi_read(sspi, SUN4I_INT_STA_REG);
+	u32 cnt;

 	/* Transfer complete */
 	if (status & SUN4I_INT_CTL_TC) {
 		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
+		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}

+	/* Receive FIFO 3/4 full */
+	if (status & SUN4I_INT_CTL_RF_F34) {
+		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+		/* Only clear the interrupt _after_ draining the FIFO */
+		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_RF_F34);
+		return IRQ_HANDLED;
+	}
+
+	/* Transmit FIFO 3/4 empty */
+	if (status & SUN4I_INT_CTL_TF_E34) {
+		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+
+		if(!sspi->len)
+			/* nothing left to transmit */
+			sun4i_spi_disable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
+
+		/* Only clear the interrupt _after_ re-seeding the FIFO */
+		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TF_E34);
+
+		return IRQ_HANDLED;
+	}
+
 	return IRQ_NONE;
 }

--
1.8.5.3
