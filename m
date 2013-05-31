From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:53 +0200
Subject: [PATCH 18/39] ARM: u300: add SPI PL022 to the device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-19-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This registers the PL022 PrimeCell from the U300 device
tree. We make a new copy of the platform data for the
device tree boot path, as the old platform data is in an
older file which will be going away.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add DMA channels.
---
 arch/arm/boot/dts/ste-u300.dts | 12 ++++++++++++
 arch/arm/mach-u300/core.c      | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 4dc9f26..355ac60 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -222,5 +222,17 @@
 			dmas = <&dmac 14>;
 			dma-names = "rx";
 		};
+
+		spi: ssp at c0006000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0xc0006000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <23>;
+			dmas = <&dmac 27 &dmac 28>;
+			dma-names = "tx", "rx";
+			num-cs = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 7866f54..d102cb5 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -19,6 +19,7 @@
 #include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/serial.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
@@ -704,6 +705,22 @@ MACHINE_END
 
 #ifdef CONFIG_OF
 
+static struct pl022_ssp_controller spi_plat_data = {
+	/* If you have several SPI buses this varies, we have only bus 0 */
+	.bus_id = 0,
+	/*
+	 * On the APP CPU GPIO 4, 5 and 6 are connected as generic
+	 * chip selects for SPI. (Same on U330, U335 and U365.)
+	 * TODO: make sure the GPIO driver can select these properly
+	 * and do padmuxing accordingly too.
+	 */
+	.num_chipselect = 3,
+	.enable_dma = 1,
+	.dma_filter = coh901318_filter_id,
+	.dma_rx_param = (void *) U300_DMA_SPI_RX,
+	.dma_tx_param = (void *) U300_DMA_SPI_TX,
+};
+
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,pinctrl-u300", U300_SYSCON_BASE,
@@ -720,6 +737,8 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
 		"uart1", &uart1_plat_data),
+	OF_DEV_AUXDATA("arm,primecell", U300_SPI_BASE,
+		"pl022", &spi_plat_data),
 	OF_DEV_AUXDATA("st,ddci2c", U300_I2C0_BASE,
 		"stu300.0", NULL),
 	OF_DEV_AUXDATA("st,ddci2c", U300_I2C1_BASE,
-- 
1.7.11.3
