From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Fri, 30 Mar 2018 10:22:42 +0300
Subject: [PATCH 5/6] spi: sun6i: introduce register set/unset helpers
In-Reply-To: <20180330072243.19368-1-ssuloev@orpaltech.com>
References: <20180330072243.19368-1-ssuloev@orpaltech.com>
Message-ID: <20180330072243.19368-6-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helper functions were added in order to update
registers easily.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fc43752..a6e6812 100644
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
+
+	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
 
-	reg &= ~mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
+	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
 }
 
 static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
@@ -357,11 +357,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
 
 	/* Enable transfer complete interrupt */
-	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC);
+	sun6i_spi_set(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
 
 	/* Start the transfer */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
+	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
 
 	/* Wait for completion */
 	ret = sun6i_spi_wait_for_transfer(spi, tfr);
-- 
2.16.2
