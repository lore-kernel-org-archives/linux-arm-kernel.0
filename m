From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Mon, 14 Dec 2015 00:04:11 +0100
Subject: [PATCH v3] spi: dts: sun4i: Add support for hardware-based wait time
 between words
In-Reply-To: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <1450047853-9005-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
SPI slave devices to set a hardware based wait time between the
transmission of words. Also modifies the sun4i SPI master driver to make
use of the new property. This specific SPI controller needs 3 clock
cycles to set up the delay, which makes the minimum non-zero wait time
on this hardware 4 clock cycles.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
Changes from v1:
 * renamed the property for more clarity
 * wait time is set in nanoseconds instead of number of clock cycles
 * transparently handle the 3 setup clock cycles

Changes from v2:
 * fixed typo in comment
 * moved parameter to spi-bus binding, dropping the vendor prefix
 * changed commit summary and description to reflect the changes
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
 drivers/spi/spi-sun4i.c                           | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index bbaa857..2d6034f 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -61,6 +61,8 @@ contain the following properties.
                       used for MOSI. Defaults to 1 if not present.
 - spi-rx-bus-width - (optional) The bus width(number of data wires) that
                       used for MISO. Defaults to 1 if not present.
+- spi-word-wait-ns - (optional) Hardware based delay between transmission of
+                      words in nanoseconds
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f60a6d6..73995a1 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/spi/spi.h>
 
@@ -173,6 +174,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
+	u32 wait_ns = 0;
+	int wait_clk = 0;
+	int clk_ns = 0;
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -261,6 +265,25 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
 
+	/* Setup wait time between words */
+	of_property_read_u32(spi->dev.of_node, "spi-word-wait-ns",
+			     &wait_ns);
+	if (wait_ns) {
+		/* The wait time is set in SPI_CLK cycles. The SPI hardware
+		 * needs 3 additional cycles to setup the wait counter, so
+		 * the minimum delay time is 4 cycles.
+		 */
+		clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
+		wait_clk = DIV_ROUND_UP(wait_ns, clk_ns) - 3;
+		if (wait_clk < 1) {
+			wait_clk = 1;
+			dev_info(&spi->dev,
+				 "using minimum of 4 word wait cycles (%uns)",
+				 4 * clk_ns);
+		}
+	}
+	sun4i_spi_write(sspi, SUN4I_WAIT_REG, (u16)wait_clk);
+
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
 		tx_len = tfr->len;
-- 
1.9.1
