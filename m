From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Fri, 30 Mar 2018 10:22:39 +0300
Subject: [PATCH 2/6] spi: sun6i: handle chip select polarity flag
In-Reply-To: <20180330072243.19368-1-ssuloev@orpaltech.com>
References: <20180330072243.19368-1-ssuloev@orpaltech.com>
Message-ID: <20180330072243.19368-3-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip select polarity flag is declared as supported
but is not handled in the code.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ff790dc..f992a7d 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -193,6 +193,12 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	else
 		reg &= ~SUN6I_TFR_CTL_CS_LEVEL;
 
+	/* Handle chip select "reverse" polarity */
+	if (spi->mode & SPI_CS_HIGH)
+		reg &= ~SUN6I_TFR_CTL_SPOL;
+	else
+		reg |= SUN6I_TFR_CTL_SPOL;
+
 	/* We want to control the chip select manually */
 	reg |= SUN6I_TFR_CTL_CS_MANUAL;
 
-- 
2.16.2
