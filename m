From: eric@anholt.net (Eric Anholt)
Date: Tue, 18 Oct 2016 09:38:08 -0700
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
Message-ID: <20161018163808.6318-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The idea is to give useful names to GPIO lines that an implementer
will be using from userspace, e.g. for maker type projects.  These are
user-visible using tools/gpio/lsgpio.c

v2: Major rewrite by anholt: Flatten each GPIO line to a line in the
    file for better diffing, prefix all expansion header pins with
    "P<number>" or "P5HEADER_P<number>" and drop the mostly-unused
    GPIO_GEN<smallnumber> names in favor of GPIO<socgpionumber>, fix
    extra '[]' on a couple of lines, fix locations of SD_CARD_DETECT,
    CAM_GPIO and STATUS_LED, fix HDMI_HPD polarities, rewrite A+ using
    unreleased schematics.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---

Note: I haven't actually booted these and checked that the names line
up, just tried to visually review them.  Hopefully with more
GPIO<number> values, it's easier to spot errors.

The only other thing here I think I would do is drop the [] around
names for behavior when pinmuxed.  I find it more confusing than
helpful.

Linus, are these names considered ABI?  Will we be locked into
whatever set of names we merge and release?  My assumption would be
"yes".

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 66 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 68 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 67 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 67 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 68 ++++++++++++++++++++++++++++++++
 5 files changed, 336 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 21507c922783..cec4c6e49e7b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -22,6 +22,72 @@
 };
 
 &gpio {
+	/*
+	 * This is based on the unreleased schematic for the Model A+.
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "[FOO]" = pin is muxed for peripheral FOO (not GPIO)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "[SDA0]",
+			  "[SCL0]",
+			  "[P3_SDA1]",
+			  "[P5_SCL1]",
+			  "[P7_GPIO_GCLK]",
+			  "P29_GPIO5",
+			  "P31_GPIO6",
+			  "[P26_SPI_CE1_N]",
+			  "[P24_SPI_CE0_N]",
+			  "[P21_SPI_MISO]",
+			  "[P19_SPI_MOSI]",
+			  "[P23_SPI_SCLK]",
+			  "P32_GPIO12",
+			  "P33_GPIO13",
+			  /* Serial port */
+			  "[P8_TXD0]",
+			  "[P10_RXD0]",
+			  "P36_GPIO16",
+			  "P11_GPIO17",
+			  "P12_GPIO18",
+			  "P35_GPIO19",
+			  "P38_GPIO20",
+			  "P40_GPIO21",
+			  "P15_GPIO22",
+			  "P16_GPIO23",
+			  "P18_GPIO24",
+			  "P22_GPIO25",
+			  "P37_GPIO26",
+			  "P13_GPIO27",
+			  "[SDA0]",
+			  "[SCL0]",
+			  "NC", /* GPIO30 */
+			  "NC", /* GPIO31 */
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "PWR_LOW_N", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "[PWM0_OUT]", /* GPIO40 */
+			  "CAM_GPIO0", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "[PWM1_OUT]", /* GPIO45 */
+			  "HDMI_HPD_N",
+			  "STATUS_LED",
+			  /* Used by SD Card */
+			  "[SD_CLK_R]",
+			  "[SD_CMD_R]",
+			  "[SD_DATA0_R]",
+			  "[SD_DATA1_R]",
+			  "[SD_DATA2_R]",
+			  "[SD_DATA3_R]";
+
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 5afba0900449..0ff96ed4d15b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -15,6 +15,74 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-Rev-1.0-Model-AB-Schematics.pdf
+	 * RPI00021 sheet 02
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "[FOO]" = pin is muxed for peripheral FOO (not GPIO)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "[P3_SDA0]",
+			  "[P5_SCL0]",
+			  "[SDA1]",
+			  "[SCL1]",
+			  "[P7_GPIO_GCLK]",
+			  "[CAM_CLK]",
+			  "LAN_RUN",
+			  "[P26_SPI_CE1_N]",
+			  "[P24_SPI_CE0_N]",
+			  "[P21_SPI_MISO]",
+			  "[P19_SPI_MOSI]",
+			  "[P23_SPI_SCLK]",
+			  "NC", /* GPIO12 */
+			  "NC", /* GPIO13 */
+			  /* Serial port */
+			  "[P8_TXD0]",
+			  "[P10_RXD0]",
+			  "STATUS_LED_N",
+			  "P11_GPIO17",
+			  "P12_GPIO18",
+			  "NC", /* GPIO19 */
+			  "NC", /* GPIO20 */
+			  "P13_GPIO21",
+			  "P15_GPIO22",
+			  "P16_GPIO23",
+			  "P18_GPIO24",
+			  "P22_GPIO25",
+			  "NC", /* GPIO26 */
+			  "CAM_GPIO",
+			  /* Binary number representing build/revision */
+			  "CONFIG0",
+			  "CONFIG1",
+			  "CONFIG2",
+			  "CONFIG3",
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "[PWM0_OUT]",
+			  "NC", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "[PWM1_OUT]",
+			  "HDMI_HPD_P",
+			  "SD_CARD_DET",
+			  /* Used by SD Card */
+			  "[SD_CLK_R]",
+			  "[SD_CMD_R]",
+			  "[SD_DATA0_R]",
+			  "[SD_DATA1_R]",
+			  "[SD_DATA2_R]",
+			  "[SD_DATA3_R]";
+
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 38f66aa244fe..0e04fc2eb65e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -23,6 +23,73 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-B-Plus-V1.2-Schematics.pdf
+	 * RPI-BPLUS sheet 1
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "[FOO]" = pin is muxed for peripheral FOO (not GPIO)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "[ID_SD]",
+			  "[ID_SC]",
+			  "[P3_SDA1]",
+			  "[P5_SCL1]",
+			  "[P7_GPIO_GCLK]",
+			  "P29_GPIO5",
+			  "P31_GPIO6",
+			  "[P26_SPI_CE1_N]",
+			  "[P24_SPI_CE0_N]",
+			  "[P21_SPI_MISO]",
+			  "[P19_SPI_MOSI]",
+			  "[P23_SPI_SCLK]",
+			  "P23_GPIO12",
+			  "P33_GPIO13",
+			  /* Serial port */
+			  "[P8_TXD0]",
+			  "[P10_RXD0]",
+			  "P36_GPIO16",
+			  "P11_GPIO17",
+			  "P12_GPIO18",
+			  "P35_GPIO19",
+			  "P38_GPIO20",
+			  "P40_GPIO21",
+			  "P15_GPIO22",
+			  "P16_GPIO23",
+			  "P18_GPIO24",
+			  "P22_GPIO25",
+			  "P37_GPIO26",
+			  "P13_GPIO27",
+			  "[SDA0]",
+			  "[SCL0]",
+			  "NC", /* GPIO30 */
+			  "LAN_RUN", /* GPIO31 */
+			  "CAM_GPIO1", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "PWR_LOW_N", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "[PWM0_OUT]", /* GPIO40 */
+			  "CAM_GPIO0", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "ETHCLK", /* GPIO44 */
+			  "[PWM1_OUT]", /* GPIO45 */
+			  "HDMI_HPD_N",
+			  "STATUS_LED",
+			  /* Used by SD Card */
+			  "[SD_CLK_R]",
+			  "[SD_CMD_R]",
+			  "[SD_DATA0_R]",
+			  "[SD_DATA1_R]",
+			  "[SD_DATA2_R]",
+			  "[SD_DATA3_R]";
+
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 75e045aba7ce..6c91c9f0536c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -16,6 +16,73 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-Rev-2.0-Model-AB-Schematics.pdf
+	 * RPI00022 sheet 02
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "[FOO]" = pin is muxed for peripheral FOO (not GPIO)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "[SDA0]",
+			  "[SCL0]",
+			  "[P3_SDA1]",
+			  "[P5_SCL1]",
+			  "[P7_GPIO_GCLK]",
+			  "[CAM_CLK]",
+			  "LAN_RUN",
+			  "[P26_SPI_CE1_N]",
+			  "[P24_SPI_CE0_N]",
+			  "[P21_SPI_MISO]",
+			  "[P19_SPI_MOSI]",
+			  "[P23_SPI_SCLK]",
+			  "NC", /* GPIO12 */
+			  "NC", /* GPIO13 */
+			  /* Serial port */
+			  "[P8_TXD0]",
+			  "[P10_RXD0]",
+			  "STATUS_LED_N",
+			  "P11_GPIO17",
+			  "P12_GPIO18",
+			  "NC", /* GPIO19 */
+			  "NC", /* GPIO20 */
+			  "CAM_GPIO",
+			  "P15_GPIO22",
+			  "P16_GPIO23",
+			  "P18_GPIO24",
+			  "P22_GPIO25",
+			  "NC", /* GPIO 26 */
+			  "P13_GPIO27",
+			  "P5HEADER_P3_GPIO28",
+			  "P5HEADER_P4_GPIO29",
+			  "P5HEADER_P5_GPIO30",
+			  "P5HEADER_P6_GPIO31",
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "[PWM0_OUT]",
+			  "NC", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "[PWM1_OUT]",
+			  "HDMI_HPD_P",
+			  "SD_CARD_DET",
+			  /* Used by SD Card */
+			  "[SD_CLK_R]",
+			  "[SD_CMD_R]",
+			  "[SD_DATA0_R]",
+			  "[SD_DATA1_R]",
+			  "[SD_DATA2_R]",
+			  "[SD_DATA3_R]";
+
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 76a254b3219a..023239946826 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -16,6 +16,74 @@
 };
 
 &gpio {
+	/*
+	 * Taken from Raspberry-Pi-Rev-1.0-Model-AB-Schematics.pdf
+	 * RPI00021 sheet 02
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "[FOO]" = pin is muxed for peripheral FOO (not GPIO)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "[P3_SDA0]",
+			  "[P5_SCL0]",
+			  "[SDA1]",
+			  "[SCL1]",
+			  "[P7_GPIO_GCLK]",
+			  "[CAM_CLK]",
+			  "LAN_RUN",
+			  "[P26_SPI_CE1_N]",
+			  "[P24_SPI_CE0_N]",
+			  "[P21_SPI_MISO]",
+			  "[P19_SPI_MOSI]",
+			  "[P23_SPI_SCLK]",
+			  "NC", /* GPIO12 */
+			  "NC", /* GPIO13 */
+			  /* Serial port */
+			  "[P8_TXD0]",
+			  "[P10_RXD0]",
+			  "STATUS_LED_N",
+			  "P11_GPIO17",
+			  "P12_GPIO18",
+			  "NC", /* GPIO19 */
+			  "NC", /* GPIO20 */
+			  "P13_GPIO21",
+			  "P15_GPIO22",
+			  "P16_GPIO23",
+			  "P18_GPIO24",
+			  "P22_GPIO25",
+			  "NC", /* GPIO26 */
+			  "CAM_GPIO",
+			  /* Binary number representing build/revision */
+			  "CONFIG0",
+			  "CONFIG1",
+			  "CONFIG2",
+			  "CONFIG3",
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "[PWM0_OUT]",
+			  "NC", /* GPIO41 */
+			  "NC", /* GPIO42 */
+			  "NC", /* GPIO43 */
+			  "NC", /* GPIO44 */
+			  "[PWM1_OUT]",
+			  "HDMI_HPD_P",
+			  "SD_CARD_DET",
+			  /* Used by SD Card */
+			  "[SD_CLK_R]",
+			  "[SD_CMD_R]",
+			  "[SD_DATA0_R]",
+			  "[SD_DATA1_R]",
+			  "[SD_DATA2_R]",
+			  "[SD_DATA3_R]";
+
 	pinctrl-0 = <&gpioout &alt0>;
 };
 
-- 
2.9.3
