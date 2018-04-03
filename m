From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue,  3 Apr 2018 18:44:48 +0300
Subject: [PATCH v3 5/6] spi: sun6i: introduce register set/unset helpers
In-Reply-To: <20180403154449.2443-1-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
Message-ID: <20180403154449.2443-6-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helper functions were added in order to set/unset
specified flags in registers.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun6i.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 0912404..2fa9d6e 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -115,29 +115,29 @@ static inline void sun6i_spi_write(struct sun6i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
-static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
+static inline void sun6i_spi_set(struct sun6i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
-
-	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
+	u32 reg = sun6i_spi_read(sspi, addr);
 
-	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
+	reg |= val;
+	sun6i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun6i_spi_enable_interrupt(struct sun6i_spi *sspi, u32 mask)
+static inline void sun6i_spi_unset(struct sun6i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
+	u32 reg = sun6i_spi_read(sspi, addr);
 
-	reg |= mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
+	reg &= ~val;
+	sun6i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
+static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 {
-	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
+	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
 
-	reg &= ~mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
+	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
+
+	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
 }
 
 static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
@@ -310,18 +310,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
 			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
 
-
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
 	 */
 	if (sspi->rx_buf)
-		reg &= ~SUN6I_TFR_CTL_DHB;
+		sun6i_spi_unset(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_DHB);
 	else
-		reg |= SUN6I_TFR_CTL_DHB;
-
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
+		sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_DHB);
 
 
 	/* Ensure that we have a parent clock fast enough */
@@ -376,8 +372,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 					 SUN6I_INT_CTL_RF_RDY);
 
 	/* Start the transfer */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
+	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
 
 	/* Wait for completion */
 	ret = sun6i_spi_wait_for_transfer(spi, tfr);
-- 
2.16.2
