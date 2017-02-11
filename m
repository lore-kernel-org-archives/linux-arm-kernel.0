From: viniciusfre@gmail.com (Vinicius Maciel)
Date: Sat, 11 Feb 2017 00:54:47 -0300
Subject: [PATCH v2] ARM: spi/sun7i: Add Master Sample Data Mode for SPI
Message-ID: <20170211035447.3819-1-viniciusfre@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to work appropriately, the max11043 ADC chip and probably
others, needs SPI master samples the data at the correct edge. From
max11043 datasheet: "The data at DIN is latched on the rising edge
of SCLK". Same to DOUT.

This patch add Master Sample Data Mode bit in normal sample mode.
It will affect only A20.

Signed-off-by: Vinicius Maciel <viniciusfre@gmail.com>
Reviewed-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 drivers/spi/spi-sun4i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635c28f3..6325be2ce8d9 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -44,6 +44,7 @@
 #define SUN4I_CTL_CS_MANUAL			BIT(16)
 #define SUN4I_CTL_CS_LEVEL			BIT(17)
 #define SUN4I_CTL_TP				BIT(18)
+#define SUN4I_CTL_SDM				BIT(20)
 
 #define SUN4I_INT_CTL_REG		0x0c
 #define SUN4I_INT_CTL_RF_F34			BIT(4)
@@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP |
+			SUN4I_CTL_SDM);
 
 	return 0;
 
-- 
2.11.0
