From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Fri, 11 Dec 2015 23:45:39 +0100
Subject: [PATCH v2] spi: dts: sun4i: Add support for inter-word wait cycles
 using the SPI Wait Clock Register
Message-ID: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support and binding documentation for a new slave device property
"sun4i,spi-word-wait-ns" that allows to set a hardware based delay
between the transmission of words using the SPI Wait Clock Register.
The SPI hardware needs 3 clock cycles to set up the delay, which makes
the minimum non-zero wait time 4 clock cycles.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
Changes from v1:
 * renamed the property for more clarity
 * wait time is set in nanoseconds instead of number of clock cycles
 * transparently handle the 3 setup clock cycles

There is one review comment that I didn't address: Rob Herring suggested
that this should be in the core-binding rather than in sun4i. I checked
many of the hardware manuals of other SPI drivers and it looks to me like
this hardware based inter-word delay is a feature that not many SPI
controllers offer. And the SPI core currently has no way to control an
inter-word delay, only inter-message. So I would like to propose this again
as a sun4i binding, as it targets a sun4i (or sunxi?) specific hardware
feature.
---
 .../devicetree/bindings/spi/spi-sun4i.txt          | 11 +++++++++++
 drivers/spi/spi-sun4i.c                            | 23 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
index de827f5..d6c55fc 100644
--- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
@@ -10,6 +10,10 @@ Required properties:
   - "mod": the parent module clock
 - clock-names: Must contain the clock names described just above
 
+Optional properties for slave devices:
+- sun4i,spi-word-wait-ns: hardware based delay in nanoseconds between
+			  transmission of words
+
 Example:
 
 spi1: spi at 01c06000 {
@@ -21,4 +25,11 @@ spi1: spi at 01c06000 {
 	status = "disabled";
 	#address-cells = <1>;
 	#size-cells = <0>;
+
+	spi1_0 {
+		compatible = "example,dummy";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		sun4i,spi-word-wait-ns = <12000>;
+	};
 };
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f60a6d6..8cfd96c 100644
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
 
+	/* Setup wait time beteen words */
+	of_property_read_u32(spi->dev.of_node, "sun4i,spi-word-wait-ns",
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
