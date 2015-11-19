From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Thu, 19 Nov 2015 16:53:42 +0100
Subject: [PATCH] spi: dts: sun4i: Add support for inter-word wait cycles using
 the SPI Wait Clock Register
In-Reply-To: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support and documentation for a new slave device property
"sun4i,spi-wdelay" that allows to set the SPI Wait Clock Register per
device / transfer. The SPI hardware will wait the specified amount of
SPI clock periods (plus a constant 3 clock periods) before transmitting
the next word.

The constant additional 3 clock periods are not documented by the vendor
and have been determined by analyzing the generated waveforms across
many different transmission speeds.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sun4i.txt | 11 +++++++++++
 drivers/spi/spi-sun4i.c                             |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
index de827f5..9c4d723 100644
--- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
@@ -10,6 +10,10 @@ Required properties:
   - "mod": the parent module clock
 - clock-names: Must contain the clock names described just above
 
+Optional properties for slave devices:
+- sun4i,spi-wdelay : delay between transmission of words, specified in number
+  of SPI clock periods (actual delay is wdelay + 3 clock periods)
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
+		spi-max-frequency = <1000000>; /* 1Mhz = 1us clock period */
+		sun4i,spi-wdelay = <2>; /* delay 5us (2 + 3 clock periods) */
+	};
 };
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f60a6d6..a8e39f1 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/spi/spi.h>
 
@@ -173,6 +174,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
+	u32 wdelay = 0;
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -261,6 +263,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
 
+	/* Set optional inter-word wait cycles */
+	of_property_read_u32(spi->dev.of_node, "sun4i,spi-wdelay",
+			     &wdelay);
+	sun4i_spi_write(sspi, SUN4I_WAIT_REG, (u16)wdelay);
+
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
 		tx_len = tfr->len;
-- 
1.9.1
