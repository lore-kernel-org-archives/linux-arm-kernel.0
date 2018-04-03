From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue,  3 Apr 2018 18:29:04 +0300
Subject: [PATCH v2 5/6] spi: sun4i: introduce register set/unset helpers
In-Reply-To: <20180403152905.1524-1-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
Message-ID: <20180403152905.1524-6-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helper functions were added in order to set/unset
specified flags in registers.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun4i.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 9d1bc20..d81d31c 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -107,29 +107,29 @@ static inline void sun4i_spi_write(struct sun4i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
-static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
+static inline void sun4i_spi_set(struct sun4i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
-
-	reg >>= SUN4I_FIFO_STA_TF_CNT_BITS;
+	u32 reg = sun4i_spi_read(sspi, addr);
 
-	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
+	reg |= val;
+	sun4i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun4i_spi_enable_interrupt(struct sun4i_spi *sspi, u32 mask)
+static inline void sun4i_spi_unset(struct sun4i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	u32 reg = sun4i_spi_read(sspi, addr);
 
-	reg |= mask;
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+	reg &= ~val;
+	sun4i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi, u32 mask)
+static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
 {
-	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	u32 reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
 
-	reg &= ~mask;
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+	reg >>= SUN4I_FIFO_STA_TF_CNT_BITS;
+
+	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
 }
 
 static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
@@ -256,13 +256,12 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	/* Clear pending interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_STA_REG, ~0);
 
+	/* Reset FIFOs */
+	sun4i_spi_set(sspi, SUN4I_CTL_REG,
+		      SUN4I_CTL_RF_RST | SUN4I_CTL_TF_RST);
 
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
 
-	/* Reset FIFOs */
-	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			reg | SUN4I_CTL_RF_RST | SUN4I_CTL_TF_RST);
-
 	/*
 	 * Setup the transfer control register: Chip Select,
 	 * polarities, etc.
@@ -342,12 +341,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
 
 	/* Enable the interrupts */
-	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC |
-					 SUN4I_INT_CTL_RF_F34);
+	sun4i_spi_set(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
+					       SUN4I_INT_CTL_RF_F34);
 
 	/* Start the transfer */
-	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
-	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
+	sun4i_spi_set(sspi, SUN4I_CTL_REG, SUN4I_CTL_XCH);
 
 	ret = sun4i_spi_wait_for_transfer(spi, tfr);
 
-- 
2.16.2
