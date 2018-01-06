From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 6 Jan 2018 08:10:41 +0800
Subject: [PATCH v2 2/5] ARM64: dts: meson-axg: uart: drop legacy compatible
 name from EE UART
In-Reply-To: <20180106001044.108163-1-yixun.lan@amlogic.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
Message-ID: <20180106001044.108163-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When update the clock info for the UART controller in the EE domain,
the driver explicitly require 'pclk' in order to work properly.

With current logic of the code, the driver will go for the legacy clock probe
routine[1] if it find current compatible string match to 'amlogic,meson-uart',
which result in not requesting the 'pclk' clock, thus break the driver in the end.

[1] drivers/tty/serial/meson_uart.c:685

        /* Use legacy way until all platforms switch to new bindings */
	if (of_device_is_compatible(pdev->dev.of_node, "amlogic,meson-uart"))
		ret = meson_uart_probe_clocks_legacy(pdev, port);
	else
		ret = meson_uart_probe_clocks(pdev, port);

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 70c776ef7aa7..644d0f9eaf8c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -164,17 +164,21 @@
 			};
 
 			uart_A: serial at 24000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x24000 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
+				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
 			};
 
 			uart_B: serial at 23000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson-gx-uart";
 				reg = <0x0 0x23000 0x0 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
+				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
 			};
 		};
 
-- 
2.15.1
