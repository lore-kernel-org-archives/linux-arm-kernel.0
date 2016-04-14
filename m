From: vigneshr@ti.com (Vignesh R)
Date: Thu, 14 Apr 2016 15:48:20 +0530
Subject: [PATCH 1/2] ARM: dts: dra7x: Remove QSPI pinmux
In-Reply-To: <1460629101-24309-1-git-send-email-vigneshr@ti.com>
References: <1460629101-24309-1-git-send-email-vigneshr@ti.com>
Message-ID: <1460629101-24309-2-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7 family of processors from Texas Instruments, have a hardware module
called IODELAYCONFIG Module which is expected to be configured. This
block allows very specific custom fine tuning for electrical
characteristics of IO pins that are necessary for functionality and
device lifetime requirements. IODelay module has it's own register space
with registers to configure various pins.

According to AM572x TRM SPRUHZ6E October 2014?Revised January 2016[1]
section 18.4.6.1 Pad Configuration, in addition to pinmuxing(MUXMODE),
when operating a pad in certain mode, Virtual/Manual IO Timing Mode must
also be configured to ensure that IO timings are met (DELAYMODE and
MODESELECT fields of pad's IODELAYCONFIG module register). According to
section 18.4.6.1.7 Isolation Requirements of above TRM, when
reprogramming MUXMODE, DELAYMODE, and MODESELECT fields, there is a
potential for a significant glitch on the corresponding IO. It is hence
recommended to do this with I/O isolation (which can only be done in
initial stages of bootloader). QSPI is one such module that requires
IODELAY configuration. So, this patch removes the pinmux for
QSPI for DRA74/DRA72 EVM as it needs to be done in bootloader (U-Boot)
and cannot be done in kernel.

Users should migrate to U-Boot v2016.05-rc1 or higher.

[1] http://www.ti.com/lit/ug/spruhz6e/spruhz6e.pdf

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 17 -----------------
 arch/arm/boot/dts/dra72-evm.dts | 14 --------------
 2 files changed, 31 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d272cf140197..47d0745a08ad 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -226,21 +226,6 @@
 		>;
 	};
 
-	qspi1_pins: pinmux_qspi1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x344c, PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
-			DRA7XX_CORE_IOPAD(0x3450, PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_cs3 */
-			DRA7XX_CORE_IOPAD(0x3474, PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1_rtclk */
-			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1_d3 */
-			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1_d2 */
-			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_d1 */
-			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1_d0 */
-			DRA7XX_CORE_IOPAD(0x3488, PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1_sclk */
-			DRA7XX_CORE_IOPAD(0x34b8, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs2.qspi1_cs0 */
-			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
-		>;
-	};
-
 	usb1_pins: pinmux_usb1_pins {
                 pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
@@ -678,8 +663,6 @@
 
 &qspi {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi1_pins>;
 
 	spi-max-frequency = <48000000>;
 	m25p80 at 0 {
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 3e63f660cd7c..479b74e1641e 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -247,18 +247,6 @@
 		>;
 	};
 
-	qspi1_pins: pinmux_qspi1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3474, PIN_OUTPUT | MUX_MODE1)	/* gpmc_a13.qspi1_rtclk */
-			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)	/* gpmc_a14.qspi1_d3 */
-			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)	/* gpmc_a15.qspi1_d2 */
-			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1)	/* gpmc_a16.qspi1_d1 */
-			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)	/* gpmc_a17.qspi1_d0 */
-			DRA7XX_CORE_IOPAD(0x3488, PIN_OUTPUT | MUX_MODE1)	/* qpmc_a18.qspi1_sclk */
-			DRA7XX_CORE_IOPAD(0x34b8, PIN_OUTPUT | MUX_MODE1)	/* gpmc_cs2.qspi1_cs0 */
-		>;
-	};
-
 	hdmi_pins: pinmux_hdmi_pins {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1) /* i2c2_sda.hdmi1_ddc_scl */
@@ -715,8 +703,6 @@
 
 &qspi {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi1_pins>;
 
 	spi-max-frequency = <48000000>;
 	m25p80 at 0 {
-- 
2.8.1
