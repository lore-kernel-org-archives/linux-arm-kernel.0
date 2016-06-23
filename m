From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Jun 2016 01:06:04 +0200
Subject: [PATCH v2] arm64: dts: hikey: name the GPIO lines
Message-ID: <1466723164-9937-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This names the GPIO lines on the HiKey board in accordance with
the 96Board Specification for especially the Low Speed External
Connector: "GPIO-A" thru "GPIO-L".

This will make these line names reflect through to userspace
so that they can easily be identified and used with the new
character device ABI.

Some care has been taken to name all lines, not just those used
by the external connectors, also lines that are muxed into some
other function than GPIO: these are named "[FOO]" so that users
can see with lsgpio what all lines are used for.

Cc: devicetree at vger.kernel.org
Cc: John Stultz <john.stultz@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: David Mandala <david.mandala@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use the right property name: old patch using "gpio-names" rather
  than "gpio-line-names" that we agreed upon. Sorry...

This would be nice to have merged for kernel v4.8 so that the
new chardev ABI can be used to obtain the lines for the external
connector and use them from userspace from this kernel version.
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 143 +++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e92a30c87a82..593c7e43de79 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -66,6 +66,149 @@
 			status = "ok";
 		};
 
+		/*
+		 * Legend: proper name = the GPIO line is used as GPIO
+		 *         NC = not connected (not routed from the SoC)
+		 *         "[PER]" = pin is muxed for peripheral (not GPIO)
+		 *         "" = no idea, schematic doesn't say, could be
+		 *              unrouted (not connected to any external pin)
+		 *         LSEC = Low Speed External Connector
+		 *         HSEC = High Speed External Connector
+		 *
+		 * Pin assignments taken from LeMaker and CircuitCo Schematics
+		 * Rev A1.
+		 *
+		 * For the lines routed to the external connectors the
+		 * lines are named after the 96Boards CE Specification 1.0,
+		 * Appendix "Expansion Connector Signal Description".
+		 *
+		 * When the 96Board naming of a line and the schematic name of
+		 * the same line are in conflict, the 96Board specification
+		 * takes precedence, which means that the external UART on the
+		 * LSEC is named UART0 while the schematic and SoC names this
+		 * UART2. This is only for the informational lines i.e. "[FOO]",
+		 * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
+		 * ones actually used for GPIO.
+		 */
+		gpio0: gpio at f8011000 {
+			gpio-line-names = "PWR_HOLD", "DSI_SEL",
+			"USB_HUB_RESET_N", "USB_SEL", "HDMI_PD", "WL_REG_ON",
+			"PWRON_DET", "5V_HUB_EN";
+		};
+
+		gpio1: gpio at f8012000 {
+			gpio-line-names = "SD_DET", "HDMI_INT", "PMU_IRQ_N",
+			"WL_HOST_WAKE", "NC", "NC", "NC", "BT_REG_ON";
+		};
+
+		gpio2: gpio at f8013000 {
+			gpio-line-names =
+				"GPIO-A", /* LSEC Pin 23: GPIO2_0 */
+				"GPIO-B", /* LSEC Pin 24: GPIO2_1 */
+				"GPIO-C", /* LSEC Pin 25: GPIO2_2 */
+				"GPIO-D", /* LSEC Pin 26: GPIO2_3 */
+				"GPIO-E", /* LSEC Pin 27: GPIO2_4 */
+				"USB_ID_DET", "USB_VBUS_DET",
+				"GPIO-H"; /* LSEC Pin 30: GPIO2_7 */
+		};
+
+		gpio3: gpio at f8014000 {
+			gpio-line-names = "GPIO3_0", "NC", "NC", "", "NC", "",
+			"WLAN_ACTIVE", "NC", "NC";
+		};
+
+		gpio4: gpio at f7020000 {
+			gpio-line-names = "USER_LED1", "USER_LED2", "USER_LED3",
+			"USER_LED4", "SD_SEL", "NC", "NC", "BT_ACTIVE";
+		};
+
+		gpio5: gpio at f7021000 {
+			gpio-line-names = "NC", "NC",
+			"[UART1_RxD]", /* LSEC Pin 11: UART3_RX */
+			"[UART1_TxD]", /* LSEC Pin 13: UART3_TX */
+			"[AUX_SSI1]", "NC",
+			"[PCM_CLK]", /* LSEC Pin 18: MODEM_PCM_XCLK */
+			"[PCM_FS]"; /* LSEC Pin 16: MODEM_PCM_XFS */
+		};
+
+		gpio6: gpio at f7022000 {
+			gpio-line-names =
+			"[SPI0_DIN]", /* Pin 10: SPI0_DI */
+			"[SPI0_DOUT]", /* Pin 14: SPI0_DO */
+			"[SPI0_CS]", /* Pin 12: SPI0_CS_N */
+			"[SPI0_SCLK]", /* Pin 8: SPI0_SCLK */
+			"NC", "NC", "NC",
+			"GPIO-G"; /* Pin 29: GPIO6_7_DSI_TE0 */
+		};
+
+		gpio7: gpio at f7023000 {
+			gpio-line-names = "NC", "NC", "NC", "NC",
+			"[PCM_DI]", /* Pin 22: MODEM_PCM_DI */
+			"[PCM_DO]", /* Pin 20: MODEM_PCM_DO */
+			"NC", "NC";
+		};
+
+		gpio8: gpio at f7024000 {
+			gpio-line-names = "NC", "[CEC_CLK_19_2MHZ]", "NC",
+			"", "", "", "", "", "";
+		};
+
+		gpio9: gpio at f7025000 {
+			gpio-line-names = "",
+			"GPIO-J", /* LSEC Pin 32: ISP_PWDN0_GPIO9_1 */
+			"GPIO-L", /* LSEC Pin 34: ISP_PWDN1_GPIO9_2 */
+			"NC", "NC", "NC", "NC", "[ISP_CCLK0]";
+		};
+
+		gpio10: gpio at f7026000 {
+			gpio-line-names = "BOOT_SEL",
+			"[ISP_CCLK1]",
+			"GPIO-I", /* LSEC Pin 31: ISP_RSTB0_GPIO10_2 */
+			"GPIO-K", /* LSEC Pin 33: ISP_RSTB1_GPIO10_3 */
+			"NC", "NC",
+			"[I2C2_SDA]", /* HSEC Pin 34: ISP0_SDA */
+			"[I2C2_SCL]"; /* HSEC Pin 32: ISP0_SCL */
+		};
+
+		gpio11: gpio at f7027000 {
+			gpio-line-names =
+			"[I2C3_SDA]", /* HSEC Pin 38: ISP1_SDA */
+			"[I2C3_SCL]", /* HSEC Pin 36: ISP1_SCL */
+			"", "NC", "NC", "NC", "", "";
+		};
+
+		gpio12: gpio at f7028000 {
+			gpio-line-names = "[BT_PCM_XFS]", "[BT_PCM_DI]",
+			"[BT_PCM_DO]",
+			"NC", "NC", "NC", "NC",
+			"GPIO-F"; /* LSEC Pin 28: BL_PWM_GPIO12_7 */
+		};
+
+		gpio13: gpio at f7029000 {
+			gpio-line-names = "[UART0_RX]", "[UART0_TX]",
+			"[BT_UART1_CTS]", "[BT_UART1_RTS]",
+			"[BT_UART1_RX]", "[BT_UART1_TX]",
+			"[UART0_CTS]", /* LSEC Pin 3: UART2_CTS_N */
+			"[UART0_RTS]"; /* LSEC Pin 9: UART2_RTS_N */
+		};
+
+		gpio14: gpio at f702a000 {
+			gpio-line-names =
+			"[UART0_RxD]", /* LSEC Pin 7: UART2_RX */
+			"[UART0_TxD]", /* LSEC Pin 5: UART2_TX */
+			"[I2C0_SCL]", /* LSEC Pin 15: I2C0_SCL */
+			"[I2C0_SDA]", /* LSEC Pin 17: I2C0_SDA */
+			"[I2C1_SCL]", /* LSEC Pin 19: I2C1_SCL */
+			"[I2C1_SDA]", /* LSEC Pin 21: I2C1_SDA */
+			"[I2C2_SCL]", "[I2C2_SDA]";
+		};
+
+		gpio15: gpio at f702b000 {
+			gpio-line-names = "", "", "", "", "", "", "NC", "";
+		};
+
+		/* GPIO blocks 16 thru 19 do not appear to be routed to pins */
+
 		dwmmc_2: dwmmc2 at f723f000 {
 			ti,non-removable;
 			non-removable;
-- 
2.4.11
