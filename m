From: denis@eukrea.com (Denis Carikli)
Date: Thu, 31 Oct 2013 10:15:26 +0100
Subject: [PATCHv9][ 4/6] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <1383210928-18906-1-git-send-email-denis@eukrea.com>
References: <1383210928-18906-1-git-send-email-denis@eukrea.com>
Message-ID: <1383210928-18906-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is mostly cut and paste from the imx35 pinctrl driver.
The data was generated using sed and awk on
  arch/arm/plat-mxc/include/mach/iomux-mx25.h.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- Whitespace cleanup betwen the CC: and Signed-off-by.
- Kconfig: rebased to make it apply on the new HEAD.
---
 .../bindings/pinctrl/fsl,imx25-pinctrl.txt         |   33 ++
 arch/arm/boot/dts/imx25-pinfunc.h                  |  513 ++++++++++++++++++++
 arch/arm/boot/dts/imx25.dtsi                       |    1 +
 arch/arm/mach-imx/Kconfig                          |    2 +
 drivers/pinctrl/Kconfig                            |    8 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-imx25.c                    |  351 ++++++++++++++
 7 files changed, 909 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx25-pinfunc.h
 create mode 100644 drivers/pinctrl/pinctrl-imx25.c

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
new file mode 100644
index 0000000..64906ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
@@ -0,0 +1,33 @@
+* Freescale IMX25 IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
+and usage.
+
+Required properties:
+- compatible: "fsl,imx25-iomuxc"
+- fsl,pins: two integers array, represents a group of pins mux and config
+  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
+  pin working on a specific function, CONFIG is the pad setting value like
+  pull-up for this pin. Please refer to imx25 datasheet for the valid pad
+  config settings.
+
+CONFIG bits definition:
+PAD_CTL_DRIVE_VOLAGAGE_18	(1 << 13)
+PAD_CTL_DRIVE_VOLAGAGE_33	(0 << 13)
+PAD_CTL_HYS			(1 << 8)
+PAD_CTL_PKE			(1 << 7)
+PAD_CTL_PUE			(1 << 6)
+PAD_CTL_PUS_100K_DOWN		(0 << 4)
+PAD_CTL_PUS_47K_UP		(1 << 4)
+PAD_CTL_PUS_100K_UP		(2 << 4)
+PAD_CTL_PUS_22K_UP		(3 << 4)
+PAD_CTL_ODE_CMOS		(0 << 3)
+PAD_CTL_ODE_OPENDRAIN		(1 << 3)
+PAD_CTL_DSE_NOMINAL		(0 << 1)
+PAD_CTL_DSE_HIGH		(1 << 1)
+PAD_CTL_DSE_MAX			(2 << 1)
+PAD_CTL_SRE_FAST		(1 << 0)
+PAD_CTL_SRE_SLOW		(0 << 0)
+
+Refer to imx25-pinfunc.h in device tree source folder for all available
+imx25 PIN_FUNC_ID.
diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
new file mode 100644
index 0000000..0a9f9a2
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -0,0 +1,513 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ * Based on imx35-pinfunc.h in the same directory Which is:
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DTS_IMX25_PINFUNC_H
+#define __DTS_IMX25_PINFUNC_H
+
+/*
+ * The pin function ID is a tuple of
+ * <mux_reg conf_reg input_reg mux_mode input_val>
+ */
+
+#define MX25_PAD_A10__A10			0x008 0x000 0x000 0x00 0x000
+#define MX25_PAD_A10__GPIO_4_0			0x008 0x000 0x000 0x05 0x000
+
+#define MX25_PAD_A13__A13			0x00c 0x22C 0x000 0x00 0x000
+#define MX25_PAD_A13__GPIO_4_1			0x00c 0x22C 0x000 0x05 0x000
+
+#define MX25_PAD_A14__A14			0x010 0x230 0x000 0x10 0x000
+#define MX25_PAD_A14__GPIO_2_0			0x010 0x230 0x000 0x15 0x000
+
+#define MX25_PAD_A15__A15			0x014 0x234 0x000 0x10 0x000
+#define MX25_PAD_A15__GPIO_2_1			0x014 0x234 0x000 0x15 0x000
+
+#define MX25_PAD_A16__A16			0x018 0x000 0x000 0x10 0x000
+#define MX25_PAD_A16__GPIO_2_2			0x018 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_A17__A17			0x01c 0x238 0x000 0x10 0x000
+#define MX25_PAD_A17__GPIO_2_3			0x01c 0x238 0x000 0x15 0x000
+
+#define MX25_PAD_A18__A18			0x020 0x23c 0x000 0x10 0x000
+#define MX25_PAD_A18__GPIO_2_4			0x020 0x23c 0x000 0x15 0x000
+#define MX25_PAD_A18__FEC_COL			0x020 0x23c 0x504 0x17 0x000
+
+#define MX25_PAD_A19__A19			0x024 0x240 0x000 0x10 0x000
+#define MX25_PAD_A19__FEC_RX_ER			0x024 0x240 0x518 0x17 0x000
+#define MX25_PAD_A19__GPIO_2_5			0x024 0x240 0x000 0x15 0x000
+
+#define MX25_PAD_A20__A20			0x028 0x244 0x000 0x10 0x000
+#define MX25_PAD_A20__GPIO_2_6			0x028 0x244 0x000 0x15 0x000
+#define MX25_PAD_A20__FEC_RDATA2		0x028 0x244 0x50c 0x17 0x000
+
+#define MX25_PAD_A21__A21			0x02c 0x248 0x000 0x10 0x000
+#define MX25_PAD_A21__GPIO_2_7			0x02c 0x248 0x000 0x15 0x000
+#define MX25_PAD_A21__FEC_RDATA3		0x02c 0x248 0x510 0x17 0x000
+
+#define MX25_PAD_A22__A22			0x030 0x000 0x000 0x10 0x000
+#define MX25_PAD_A22__GPIO_2_8			0x030 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_A23__A23			0x034 0x24c 0x000 0x10 0x000
+#define MX25_PAD_A23__GPIO_2_9			0x034 0x24c 0x000 0x15 0x000
+
+#define MX25_PAD_A24__A24			0x038 0x250 0x000 0x10 0x000
+#define MX25_PAD_A24__GPIO_2_10			0x038 0x250 0x000 0x15 0x000
+#define MX25_PAD_A24__FEC_RX_CLK		0x038 0x250 0x514 0x17 0x000
+
+#define MX25_PAD_A25__A25			0x03c 0x254 0x000 0x10 0x000
+#define MX25_PAD_A25__GPIO_2_11			0x03c 0x254 0x000 0x15 0x000
+#define MX25_PAD_A25__FEC_CRS			0x03c 0x254 0x508 0x17 0x000
+
+#define MX25_PAD_EB0__EB0			0x040 0x258 0x000 0x10 0x000
+#define MX25_PAD_EB0__AUD4_TXD			0x040 0x258 0x464 0x14 0x000
+#define MX25_PAD_EB0__GPIO_2_12			0x040 0x258 0x000 0x15 0x000
+
+#define MX25_PAD_EB1__EB1			0x044 0x25c 0x000 0x10 0x000
+#define MX25_PAD_EB1__AUD4_RXD			0x044 0x25c 0x460 0x14 0x000
+#define MX25_PAD_EB1__GPIO_2_13			0x044 0x25c 0x000 0x15 0x000
+
+#define MX25_PAD_OE__OE				0x048 0x260 0x000 0x10 0x000
+#define MX25_PAD_OE__AUD4_TXC			0x048 0x260 0x000 0x14 0x000
+#define MX25_PAD_OE__GPIO_2_14			0x048 0x260 0x000 0x15 0x000
+
+#define MX25_PAD_CS0__CS0			0x04c 0x000 0x000 0x00 0x000
+#define MX25_PAD_CS0__GPIO_4_2			0x04c 0x000 0x000 0x05 0x000
+
+#define MX25_PAD_CS1__CS1			0x050 0x000 0x000 0x00 0x000
+#define MX25_PAD_CS1__NF_CE3			0x050 0x000 0x000 0x01 0x000
+#define MX25_PAD_CS1__GPIO_4_3			0x050 0x000 0x000 0x05 0x000
+
+#define MX25_PAD_CS4__CS4			0x054 0x264 0x000 0x10 0x000
+#define MX25_PAD_CS4__NF_CE1			0x054 0x264 0x000 0x01 0x000
+#define MX25_PAD_CS4__UART5_CTS			0x054 0x264 0x000 0x13 0x000
+#define MX25_PAD_CS4__GPIO_3_20			0x054 0x264 0x000 0x15 0x000
+
+#define MX25_PAD_CS5__CS5			0x058 0x268 0x000 0x10 0x000
+#define MX25_PAD_CS5__NF_CE2			0x058 0x268 0x000 0x01 0x000
+#define MX25_PAD_CS5__UART5_RTS			0x058 0x268 0x574 0x13 0x000
+#define MX25_PAD_CS5__GPIO_3_21			0x058 0x268 0x000 0x15 0x000
+
+#define MX25_PAD_NF_CE0__NF_CE0			0x05c 0x26c 0x000 0x10 0x000
+#define MX25_PAD_NF_CE0__GPIO_3_22		0x05c 0x26c 0x000 0x15 0x000
+
+#define MX25_PAD_ECB__ECB			0x060 0x270 0x000 0x10 0x000
+#define MX25_PAD_ECB__UART5_TXD_MUX		0x060 0x270 0x000 0x13 0x000
+#define MX25_PAD_ECB__GPIO_3_23			0x060 0x270 0x000 0x15 0x000
+
+#define MX25_PAD_LBA__LBA			0x064 0x274 0x000 0x10 0x000
+#define MX25_PAD_LBA__UART5_RXD_MUX		0x064 0x274 0x578 0x13 0x000
+#define MX25_PAD_LBA__GPIO_3_24			0x064 0x274 0x000 0x15 0x000
+
+#define MX25_PAD_BCLK__BCLK			0x068 0x000 0x000 0x00 0x000
+#define MX25_PAD_BCLK__GPIO_4_4			0x068 0x000 0x000 0x05 0x000
+
+#define MX25_PAD_RW__RW				0x06c 0x278 0x000 0x10 0x000
+#define MX25_PAD_RW__AUD4_TXFS			0x06c 0x278 0x474 0x14 0x000
+#define MX25_PAD_RW__GPIO_3_25			0x06c 0x278 0x000 0x15 0x000
+
+#define MX25_PAD_NFWE_B__NFWE_B			0x070 0x000 0x000 0x10 0x000
+#define MX25_PAD_NFWE_B__GPIO_3_26		0x070 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_NFRE_B__NFRE_B			0x074 0x000 0x000 0x10 0x000
+#define MX25_PAD_NFRE_B__GPIO_3_27		0x074 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_NFALE__NFALE			0x078 0x000 0x000 0x10 0x000
+#define MX25_PAD_NFALE__GPIO_3_28		0x078 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_NFCLE__NFCLE			0x07c 0x000 0x000 0x10 0x000
+#define MX25_PAD_NFCLE__GPIO_3_29		0x07c 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_NFWP_B__NFWP_B			0x080 0x000 0x000 0x10 0x000
+#define MX25_PAD_NFWP_B__GPIO_3_30		0x080 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_NFRB__NFRB			0x084 0x27c 0x000 0x10 0x000
+#define MX25_PAD_NFRB__GPIO_3_31		0x084 0x27c 0x000 0x15 0x000
+
+#define MX25_PAD_D15__D15			0x088 0x280 0x000 0x00 0x000
+#define MX25_PAD_D15__LD16			0x088 0x280 0x000 0x01 0x000
+#define MX25_PAD_D15__GPIO_4_5			0x088 0x280 0x000 0x05 0x000
+
+#define MX25_PAD_D14__D14			0x08c 0x284 0x000 0x00 0x000
+#define MX25_PAD_D14__LD17			0x08c 0x284 0x000 0x01 0x000
+#define MX25_PAD_D14__GPIO_4_6			0x08c 0x284 0x000 0x05 0x000
+
+#define MX25_PAD_D13__D13			0x090 0x288 0x000 0x00 0x000
+#define MX25_PAD_D13__LD18			0x090 0x288 0x000 0x01 0x000
+#define MX25_PAD_D13__GPIO_4_7			0x090 0x288 0x000 0x05 0x000
+
+#define MX25_PAD_D12__D12			0x094 0x28c 0x000 0x00 0x000
+#define MX25_PAD_D12__GPIO_4_8			0x094 0x28c 0x000 0x05 0x000
+
+#define MX25_PAD_D11__D11			0x098 0x290 0x000 0x00 0x000
+#define MX25_PAD_D11__GPIO_4_9			0x098 0x290 0x000 0x05 0x000
+
+#define MX25_PAD_D10__D10			0x09c 0x294 0x000 0x00 0x000
+#define MX25_PAD_D10__GPIO_4_10			0x09c 0x294 0x000 0x05 0x000
+#define MX25_PAD_D10__USBOTG_OC			0x09c 0x294 0x57c 0x06 0x000
+
+#define MX25_PAD_D9__D9				0x0a0 0x298 0x000 0x00 0x000
+#define MX25_PAD_D9__GPIO_4_11			0x0a0 0x298 0x000 0x05 0x000
+#define MX25_PAD_D9__USBH2_PWR			0x0a0 0x298 0x000 0x06 0x000
+
+#define MX25_PAD_D8__D8				0x0a4 0x29c 0x000 0x00 0x000
+#define MX25_PAD_D8__GPIO_4_12			0x0a4 0x29c 0x000 0x05 0x000
+#define MX25_PAD_D8__USBH2_OC			0x0a4 0x29c 0x580 0x06 0x000
+
+#define MX25_PAD_D7__D7				0x0a8 0x2a0 0x000 0x00 0x000
+#define MX25_PAD_D7__GPIO_4_13			0x0a8 0x2a0 0x000 0x05 0x000
+
+#define MX25_PAD_D6__D6				0x0ac 0x2a4 0x000 0x00 0x000
+#define MX25_PAD_D6__GPIO_4_14			0x0ac 0x2a4 0x000 0x05 0x000
+
+#define MX25_PAD_D5__D5				0x0b0 0x2a8 0x000 0x00 0x000
+#define MX25_PAD_D5__GPIO_4_15			0x0b0 0x2a8 0x000 0x05 0x000
+
+#define MX25_PAD_D4__D4				0x0b4 0x2ac 0x000 0x00 0x000
+#define MX25_PAD_D4__GPIO_4_16			0x0b4 0x2ac 0x000 0x05 0x000
+
+#define MX25_PAD_D3__D3				0x0b8 0x2b0 0x000 0x00 0x000
+#define MX25_PAD_D3__GPIO_4_17			0x0b8 0x2b0 0x000 0x05 0x000
+
+#define MX25_PAD_D2__D2				0x0bc 0x2b4 0x000 0x00 0x000
+#define MX25_PAD_D2__GPIO_4_18			0x0bc 0x2b4 0x000 0x05 0x000
+
+#define MX25_PAD_D1__D1				0x0c0 0x2b8 0x000 0x00 0x000
+#define MX25_PAD_D1__GPIO_4_19			0x0c0 0x2b8 0x000 0x05 0x000
+
+#define MX25_PAD_D0__D0				0x0c4 0x2bc 0x000 0x00 0x000
+#define MX25_PAD_D0__GPIO_4_20			0x0c4 0x2bc 0x000 0x05 0x000
+
+#define MX25_PAD_LD0__LD0			0x0c8 0x2c0 0x000 0x10 0x000
+#define MX25_PAD_LD0__CSI_D0			0x0c8 0x2c0 0x488 0x12 0x000
+#define MX25_PAD_LD0__GPIO_2_15			0x0c8 0x2c0 0x000 0x15 0x000
+
+#define MX25_PAD_LD1__LD1			0x0cc 0x2c4 0x000 0x10 0x000
+#define MX25_PAD_LD1__CSI_D1			0x0cc 0x2c4 0x48c 0x12 0x000
+#define MX25_PAD_LD1__GPIO_2_16			0x0cc 0x2c4 0x000 0x15 0x000
+
+#define MX25_PAD_LD2__LD2			0x0d0 0x2c8 0x000 0x10 0x000
+#define MX25_PAD_LD2__GPIO_2_17			0x0d0 0x2c8 0x000 0x15 0x000
+
+#define MX25_PAD_LD3__LD3			0x0d4 0x2cc 0x000 0x10 0x000
+#define MX25_PAD_LD3__GPIO_2_18			0x0d4 0x2cc 0x000 0x15 0x000
+
+#define MX25_PAD_LD4__LD4			0x0d8 0x2d0 0x000 0x10 0x000
+#define MX25_PAD_LD4__GPIO_2_19			0x0d8 0x2d0 0x000 0x15 0x000
+
+#define MX25_PAD_LD5__LD5			0x0dc 0x2d4 0x000 0x10 0x000
+#define MX25_PAD_LD5__GPIO_1_19			0x0dc 0x2d4 0x000 0x15 0x000
+
+#define MX25_PAD_LD6__LD6			0x0e0 0x2d8 0x000 0x10 0x000
+#define MX25_PAD_LD6__GPIO_1_20			0x0e0 0x2d8 0x000 0x15 0x000
+
+#define MX25_PAD_LD7__LD7			0x0e4 0x2dc 0x000 0x10 0x000
+#define MX25_PAD_LD7__GPIO_1_21			0x0e4 0x2dc 0x000 0x15 0x000
+
+#define MX25_PAD_LD8__LD8			0x0e8 0x2e0 0x000 0x10 0x000
+#define MX25_PAD_LD8__FEC_TX_ERR		0x0e8 0x2e0 0x000 0x15 0x000
+
+#define MX25_PAD_LD9__LD9			0x0ec 0x2e4 0x000 0x10 0x000
+#define MX25_PAD_LD9__FEC_COL			0x0ec 0x2e4 0x504 0x15 0x001
+
+#define MX25_PAD_LD10__LD10			0x0f0 0x2e8 0x000 0x10 0x000
+#define MX25_PAD_LD10__FEC_RX_ER		0x0f0 0x2e8 0x518 0x15 0x001
+
+#define MX25_PAD_LD11__LD11			0x0f4 0x2ec 0x000 0x10 0x000
+#define MX25_PAD_LD11__FEC_RDATA2		0x0f4 0x2ec 0x50c 0x15 0x001
+
+#define MX25_PAD_LD12__LD12			0x0f8 0x2f0 0x000 0x10 0x000
+#define MX25_PAD_LD12__FEC_RDATA3		0x0f8 0x2f0 0x510 0x15 0x001
+
+#define MX25_PAD_LD13__LD13			0x0fc 0x2f4 0x000 0x10 0x000
+#define MX25_PAD_LD13__FEC_TDATA2		0x0fc 0x2f4 0x000 0x15 0x000
+
+#define MX25_PAD_LD14__LD14			0x100 0x2f8 0x000 0x10 0x000
+#define MX25_PAD_LD14__FEC_TDATA3		0x100 0x2f8 0x000 0x15 0x000
+
+#define MX25_PAD_LD15__LD15			0x104 0x2fc 0x000 0x10 0x000
+#define MX25_PAD_LD15__FEC_RX_CLK		0x104 0x2fc 0x514 0x15 0x001
+
+#define MX25_PAD_HSYNC__HSYNC			0x108 0x300 0x000 0x10 0x000
+#define MX25_PAD_HSYNC__GPIO_1_22		0x108 0x300 0x000 0x15 0x000
+
+#define MX25_PAD_VSYNC__VSYNC			0x10c 0x304 0x000 0x10 0x000
+#define MX25_PAD_VSYNC__GPIO_1_23		0x10c 0x304 0x000 0x15 0x000
+
+#define MX25_PAD_LSCLK__LSCLK			0x110 0x308 0x000 0x10 0x000
+#define MX25_PAD_LSCLK__GPIO_1_24		0x110 0x308 0x000 0x15 0x000
+
+#define MX25_PAD_OE_ACD__OE_ACD			0x114 0x30c 0x000 0x10 0x000
+#define MX25_PAD_OE_ACD__GPIO_1_25		0x114 0x30c 0x000 0x15 0x000
+
+#define MX25_PAD_CONTRAST__CONTRAST		0x118 0x310 0x000 0x10 0x000
+#define MX25_PAD_CONTRAST__PWM4_PWMO		0x118 0x310 0x000 0x14 0x000
+#define MX25_PAD_CONTRAST__FEC_CRS		0x118 0x310 0x508 0x15 0x001
+
+#define MX25_PAD_PWM__PWM			0x11c 0x314 0x000 0x10 0x000
+#define MX25_PAD_PWM__GPIO_1_26			0x11c 0x314 0x000 0x15 0x000
+#define MX25_PAD_PWM__USBH2_OC			0x11c 0x314 0x580 0x16 0x001
+
+#define MX25_PAD_CSI_D2__CSI_D2			0x120 0x318 0x000 0x10 0x000
+#define MX25_PAD_CSI_D2__UART5_RXD_MUX		0x120 0x318 0x578 0x11 0x001
+#define MX25_PAD_CSI_D2__GPIO_1_27		0x120 0x318 0x000 0x15 0x000
+#define MX25_PAD_CSI_D2__CSPI3_MOSI		0x120 0x318 0x000 0x17 0x000
+
+#define MX25_PAD_CSI_D3__CSI_D3			0x124 0x31c 0x000 0x10 0x000
+#define MX25_PAD_CSI_D3__GPIO_1_28		0x124 0x31c 0x000 0x15 0x000
+#define MX25_PAD_CSI_D3__CSPI3_MISO		0x124 0x31c 0x4b4 0x17 0x001
+
+#define MX25_PAD_CSI_D4__CSI_D4			0x128 0x320 0x000 0x10 0x000
+#define MX25_PAD_CSI_D4__UART5_RTS		0x128 0x320 0x574 0x11 0x001
+#define MX25_PAD_CSI_D4__GPIO_1_29		0x128 0x320 0x000 0x15 0x000
+#define MX25_PAD_CSI_D4__CSPI3_SCLK		0x128 0x320 0x000 0x17 0x000
+
+#define MX25_PAD_CSI_D5__CSI_D5			0x12c 0x324 0x000 0x10 0x000
+#define MX25_PAD_CSI_D5__GPIO_1_30		0x12c 0x324 0x000 0x15 0x000
+#define MX25_PAD_CSI_D5__CSPI3_RDY		0x12c 0x324 0x000 0x17 0x000
+
+#define MX25_PAD_CSI_D6__CSI_D6			0x130 0x328 0x000 0x10 0x000
+#define MX25_PAD_CSI_D6__GPIO_1_31		0x130 0x328 0x000 0x15 0x000
+
+#define MX25_PAD_CSI_D7__CSI_D7			0x134 0x32c 0x000 0x10 0x000
+#define MX25_PAD_CSI_D7__GPIO_1_6		0x134 0x32c 0x000 0x15 0x000
+
+#define MX25_PAD_CSI_D8__CSI_D8			0x138 0x330 0x000 0x10 0x000
+#define MX25_PAD_CSI_D8__GPIO_1_7		0x138 0x330 0x000 0x15 0x000
+
+#define MX25_PAD_CSI_D9__CSI_D9			0x13c 0x334 0x000 0x10 0x000
+#define MX25_PAD_CSI_D9__GPIO_4_21		0x13c 0x334 0x000 0x15 0x000
+
+#define MX25_PAD_CSI_MCLK__CSI_MCLK		0x140 0x338 0x000 0x10 0x000
+#define MX25_PAD_CSI_MCLK__GPIO_1_8		0x140 0x338 0x000 0x15 0x000
+
+#define MX25_PAD_CSI_VSYNC__CSI_VSYNC		0x144 0x33c 0x000 0x10 0x000
+#define MX25_PAD_CSI_VSYNC__GPIO_1_9		0x144 0x33c 0x000 0x15 0x000
+
+#define MX25_PAD_CSI_HSYNC__CSI_HSYNC		0x148 0x340 0x000 0x10 0x000
+#define MX25_PAD_CSI_HSYNC__GPIO_1_10		0x148 0x340 0x000 0x15 0x000
+
+#define MX25_PAD_CSI_PIXCLK__CSI_PIXCLK		0x14c 0x344 0x000 0x10 0x000
+#define MX25_PAD_CSI_PIXCLK__GPIO_1_11		0x14c 0x344 0x000 0x15 0x000
+
+#define MX25_PAD_I2C1_CLK__I2C1_CLK		0x150 0x348 0x000 0x10 0x000
+#define MX25_PAD_I2C1_CLK__GPIO_1_12		0x150 0x348 0x000 0x15 0x000
+
+#define MX25_PAD_I2C1_DAT__I2C1_DAT		0x154 0x34c 0x000 0x10 0x000
+#define MX25_PAD_I2C1_DAT__GPIO_1_13		0x154 0x34c 0x000 0x15 0x000
+
+#define MX25_PAD_CSPI1_MOSI__CSPI1_MOSI		0x158 0x350 0x000 0x10 0x000
+#define MX25_PAD_CSPI1_MOSI__GPIO_1_14		0x158 0x350 0x000 0x15 0x000
+
+#define MX25_PAD_CSPI1_MISO__CSPI1_MISO		0x15c 0x354 0x000 0x10 0x000
+#define MX25_PAD_CSPI1_MISO__GPIO_1_15		0x15c 0x354 0x000 0x15 0x000
+
+#define MX25_PAD_CSPI1_SS0__CSPI1_SS0		0x160 0x358 0x000 0x10 0x000
+#define MX25_PAD_CSPI1_SS0__GPIO_1_16		0x160 0x358 0x000 0x15 0x000
+
+#define MX25_PAD_CSPI1_SS1__CSPI1_SS1		0x164 0x35c 0x000 0x10 0x000
+#define MX25_PAD_CSPI1_SS1__GPIO_1_17		0x164 0x35c 0x000 0x15 0x000
+
+#define MX25_PAD_CSPI1_SCLK__CSPI1_SCLK		0x168 0x360 0x000 0x10 0x000
+#define MX25_PAD_CSPI1_SCLK__GPIO_1_18		0x168 0x360 0x000 0x15 0x000
+
+#define MX25_PAD_CSPI1_RDY__CSPI1_RDY		0x16c 0x364 0x000 0x10 0x000
+#define MX25_PAD_CSPI1_RDY__GPIO_2_22		0x16c 0x364 0x000 0x15 0x000
+
+#define MX25_PAD_UART1_RXD__UART1_RXD		0x170 0x368 0x000 0x10 0x000
+#define MX25_PAD_UART1_RXD__GPIO_4_22		0x170 0x368 0x000 0x15 0x000
+
+#define MX25_PAD_UART1_TXD__UART1_TXD		0x174 0x36c 0x000 0x10 0x000
+#define MX25_PAD_UART1_TXD__GPIO_4_23		0x174 0x36c 0x000 0x15 0x000
+
+#define MX25_PAD_UART1_RTS__UART1_RTS		0x178 0x370 0x000 0x10 0x000
+#define MX25_PAD_UART1_RTS__CSI_D0		0x178 0x370 0x488 0x11 0x001
+#define MX25_PAD_UART1_RTS__GPIO_4_24		0x178 0x370 0x000 0x15 0x000
+
+#define MX25_PAD_UART1_CTS__UART1_CTS		0x17c 0x374 0x000 0x10 0x000
+#define MX25_PAD_UART1_CTS__CSI_D1		0x17c 0x374 0x48c 0x11 0x001
+#define MX25_PAD_UART1_CTS__GPIO_4_25		0x17c 0x374 0x000 0x15 0x000
+
+#define MX25_PAD_UART2_RXD__UART2_RXD		0x180 0x378 0x000 0x10 0x000
+#define MX25_PAD_UART2_RXD__GPIO_4_26		0x180 0x378 0x000 0x15 0x000
+
+#define MX25_PAD_UART2_TXD__UART2_TXD		0x184 0x37c 0x000 0x10 0x000
+#define MX25_PAD_UART2_TXD__GPIO_4_27		0x184 0x37c 0x000 0x15 0x000
+
+#define MX25_PAD_UART2_RTS__UART2_RTS		0x188 0x380 0x000 0x10 0x000
+#define MX25_PAD_UART2_RTS__FEC_COL		0x188 0x380 0x504 0x12 0x002
+#define MX25_PAD_UART2_RTS__GPIO_4_28		0x188 0x380 0x000 0x15 0x000
+
+#define MX25_PAD_UART2_CTS__FEC_RX_ER		0x18c 0x384 0x518 0x12 0x002
+#define MX25_PAD_UART2_CTS__UART2_CTS		0x18c 0x384 0x000 0x10 0x000
+#define MX25_PAD_UART2_CTS__GPIO_4_29		0x18c 0x384 0x000 0x15 0x000
+
+#define MX25_PAD_SD1_CMD__SD1_CMD		0x190 0x388 0x000 0x10 0x000
+#define MX25_PAD_SD1_CMD__FEC_RDATA2		0x190 0x388 0x50c 0x12 0x002
+#define MX25_PAD_SD1_CMD__GPIO_2_23		0x190 0x388 0x000 0x15 0x000
+
+#define MX25_PAD_SD1_CLK__SD1_CLK		0x194 0x38c 0x000 0x10 0x000
+#define MX25_PAD_SD1_CLK__FEC_RDATA3		0x194 0x38c 0x510 0x12 0x002
+#define MX25_PAD_SD1_CLK__GPIO_2_24		0x194 0x38c 0x000 0x15 0x000
+
+#define MX25_PAD_SD1_DATA0__SD1_DATA0		0x198 0x390 0x000 0x10 0x000
+#define MX25_PAD_SD1_DATA0__GPIO_2_25		0x198 0x390 0x000 0x15 0x000
+
+#define MX25_PAD_SD1_DATA1__SD1_DATA1		0x19c 0x394 0x000 0x10 0x000
+#define MX25_PAD_SD1_DATA1__AUD7_RXD		0x19c 0x394 0x478 0x13 0x000
+#define MX25_PAD_SD1_DATA1__GPIO_2_26		0x19c 0x394 0x000 0x15 0x000
+
+#define MX25_PAD_SD1_DATA2__SD1_DATA2		0x1a0 0x398 0x000 0x10 0x000
+#define MX25_PAD_SD1_DATA2__FEC_RX_CLK		0x1a0 0x398 0x514 0x15 0x002
+#define MX25_PAD_SD1_DATA2__GPIO_2_27		0x1a0 0x398 0x000 0x15 0x000
+
+#define MX25_PAD_SD1_DATA3__SD1_DATA3		0x1a4 0x39c 0x000 0x10 0x000
+#define MX25_PAD_SD1_DATA3__FEC_CRS		0x1a4 0x39c 0x508 0x10 0x002
+#define MX25_PAD_SD1_DATA3__GPIO_2_28		0x1a4 0x39c 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_ROW0__KPP_ROW0		0x1a8 0x3a0 0x000 0x10 0x000
+#define MX25_PAD_KPP_ROW0__GPIO_2_29		0x1a8 0x3a0 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_ROW1__KPP_ROW1		0x1ac 0x3a4 0x000 0x10 0x000
+#define MX25_PAD_KPP_ROW1__GPIO_2_30		0x1ac 0x3a4 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_ROW2__KPP_ROW2		0x1b0 0x3a8 0x000 0x10 0x000
+#define MX25_PAD_KPP_ROW2__CSI_D0		0x1b0 0x3a8 0x488 0x13 0x002
+#define MX25_PAD_KPP_ROW2__GPIO_2_31		0x1b0 0x3a8 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_ROW3__KPP_ROW3		0x1b4 0x3ac 0x000 0x10 0x000
+#define MX25_PAD_KPP_ROW3__CSI_LD1		0x1b4 0x3ac 0x48c 0x13 0x002
+#define MX25_PAD_KPP_ROW3__GPIO_3_0		0x1b4 0x3ac 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_COL0__KPP_COL0		0x1b8 0x3b0 0x000 0x10 0x000
+#define MX25_PAD_KPP_COL0__UART4_RXD_MUX	0x1b8 0x3b0 0x570 0x11 0x001
+#define MX25_PAD_KPP_COL0__AUD5_TXD		0x1b8 0x3b0 0x000 0x12 0x000
+#define MX25_PAD_KPP_COL0__GPIO_3_1		0x1b8 0x3b0 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_COL1__KPP_COL1		0x1bc 0x3b4 0x000 0x10 0x000
+#define MX25_PAD_KPP_COL1__UART4_TXD_MUX	0x1bc 0x3b4 0x000 0x11 0x000
+#define MX25_PAD_KPP_COL1__AUD5_RXD		0x1bc 0x3b4 0x000 0x12 0x000
+#define MX25_PAD_KPP_COL1__GPIO_3_2		0x1bc 0x3b4 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_COL2__KPP_COL2		0x1c0 0x3b8 0x000 0x10 0x000
+#define MX25_PAD_KPP_COL2__UART4_RTS		0x1c0 0x3b8 0x000 0x11 0x000
+#define MX25_PAD_KPP_COL2__AUD5_TXC		0x1c0 0x3b8 0x000 0x12 0x000
+#define MX25_PAD_KPP_COL2__GPIO_3_3		0x1c0 0x3b8 0x000 0x15 0x000
+
+#define MX25_PAD_KPP_COL3__KPP_COL3		0x1c4 0x3bc 0x000 0x10 0x000
+#define MX25_PAD_KPP_COL3__UART4_CTS		0x1c4 0x3bc 0x000 0x11 0x000
+#define MX25_PAD_KPP_COL3__AUD5_TXFS		0x1c4 0x3bc 0x000 0x12 0x000
+#define MX25_PAD_KPP_COL3__GPIO_3_4		0x1c4 0x3bc 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_MDC__FEC_MDC		0x1c8 0x3c0 0x000 0x10 0x000
+#define MX25_PAD_FEC_MDC__AUD4_TXD		0x1c8 0x3c0 0x464 0x12 0x001
+#define MX25_PAD_FEC_MDC__GPIO_3_5		0x1c8 0x3c0 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_MDIO__FEC_MDIO		0x1cc 0x3c4 0x000 0x10 0x000
+#define MX25_PAD_FEC_MDIO__AUD4_RXD		0x1cc 0x3c4 0x460 0x12 0x001
+#define MX25_PAD_FEC_MDIO__GPIO_3_6		0x1cc 0x3c4 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x1d0 0x3c8 0x000 0x10 0x000
+#define MX25_PAD_FEC_TDATA0__GPIO_3_7		0x1d0 0x3c8 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x1d4 0x3cc 0x000 0x10 0x000
+#define MX25_PAD_FEC_TDATA1__AUD4_TXFS		0x1d4 0x3cc 0x474 0x12 0x001
+#define MX25_PAD_FEC_TDATA1__GPIO_3_8		0x1d4 0x3cc 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x1d8 0x3d0 0x000 0x10 0x000
+#define MX25_PAD_FEC_TX_EN__GPIO_3_9		0x1d8 0x3d0 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x1dc 0x3d4 0x000 0x10 0x000
+#define MX25_PAD_FEC_RDATA0__GPIO_3_10		0x1dc 0x3d4 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x1e0 0x3d8 0x000 0x10 0x000
+#define MX25_PAD_FEC_RDATA1__GPIO_3_11		0x1e0 0x3d8 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x1e4 0x3dc 0x000 0x10 0x000
+#define MX25_PAD_FEC_RX_DV__CAN2_RX		0x1e4 0x3dc 0x484 0x14 0x000
+#define MX25_PAD_FEC_RX_DV__GPIO_3_12		0x1e4 0x3dc 0x000 0x15 0x000
+
+#define MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x1e8 0x3e0 0x000 0x10 0x000
+#define MX25_PAD_FEC_TX_CLK__GPIO_3_13		0x1e8 0x3e0 0x000 0x15 0x000
+
+#define MX25_PAD_RTCK__RTCK			0x1ec 0x3e4 0x000 0x10 0x000
+#define MX25_PAD_RTCK__OWIRE			0x1ec 0x3e4 0x000 0x11 0x000
+#define MX25_PAD_RTCK__GPIO_3_14		0x1ec 0x3e4 0x000 0x15 0x000
+
+#define MX25_PAD_DE_B__DE_B			0x1f0 0x3ec 0x000 0x10 0x000
+#define MX25_PAD_DE_B__GPIO_2_20		0x1f0 0x3ec 0x000 0x15 0x000
+
+#define MX25_PAD_TDO__TDO			0x000 0x3e8 0x000 0x00 0x000
+
+#define MX25_PAD_GPIO_A__GPIO_A			0x1f4 0x3f0 0x000 0x10 0x000
+#define MX25_PAD_GPIO_A__CAN1_TX		0x1f4 0x3f0 0x000 0x16 0x000
+#define MX25_PAD_GPIO_A__USBOTG_PWR		0x1f4 0x3f0 0x000 0x12 0x000
+
+#define MX25_PAD_GPIO_B__GPIO_B			0x1f8 0x3f4 0x000 0x10 0x000
+#define MX25_PAD_GPIO_B__CAN1_RX		0x1f8 0x3f4 0x480 0x16 0x001
+#define MX25_PAD_GPIO_B__USBOTG_OC		0x1f8 0x3f4 0x57c 0x12 0x001
+
+#define MX25_PAD_GPIO_C__GPIO_C			0x1fc 0x3f8 0x000 0x10 0x000
+#define MX25_PAD_GPIO_C__CAN2_TX		0x1fc 0x3f8 0x000 0x16 0x000
+
+#define MX25_PAD_GPIO_D__GPIO_D			0x200 0x3fc 0x000 0x10 0x000
+#define MX25_PAD_GPIO_E__LD16			0x204 0x400 0x000 0x02 0x000
+#define MX25_PAD_GPIO_D__CAN2_RX		0x200 0x3fc 0x484 0x16 0x001
+
+#define MX25_PAD_GPIO_E__GPIO_E			0x204 0x400 0x000 0x10 0x000
+#define MX25_PAD_GPIO_F__LD17			0x208 0x404 0x000 0x02 0x000
+#define MX25_PAD_GPIO_E__AUD7_TXD		0x204 0x400 0x000 0x14 0x000
+
+#define MX25_PAD_GPIO_F__GPIO_F			0x208 0x404 0x000 0x10 0x000
+#define MX25_PAD_GPIO_F__AUD7_TXC		0x208 0x404 0x000 0x14 0x000
+
+#define MX25_PAD_EXT_ARMCLK__EXT_ARMCLK		0x20c 0x000 0x000 0x10 0x000
+#define MX25_PAD_EXT_ARMCLK__GPIO_3_15		0x20c 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_UPLL_BYPCLK__UPLL_BYPCLK	0x210 0x000 0x000 0x10 0x000
+#define MX25_PAD_UPLL_BYPCLK__GPIO_3_16		0x210 0x000 0x000 0x15 0x000
+
+#define MX25_PAD_VSTBY_REQ__VSTBY_REQ		0x214 0x408 0x000 0x10 0x000
+#define MX25_PAD_VSTBY_REQ__AUD7_TXFS		0x214 0x408 0x000 0x14 0x000
+#define MX25_PAD_VSTBY_REQ__GPIO_3_17		0x214 0x408 0x000 0x15 0x000
+#define MX25_PAD_VSTBY_ACK__VSTBY_ACK		0x218 0x40c 0x000 0x10 0x000
+#define MX25_PAD_VSTBY_ACK__GPIO_3_18		0x218 0x40c 0x000 0x15 0x000
+
+#define MX25_PAD_POWER_FAIL__POWER_FAIL		0x21c 0x410 0x000 0x10 0x000
+#define MX25_PAD_POWER_FAIL__AUD7_RXD		0x21c 0x410 0x478 0x14 0x001
+#define MX25_PAD_POWER_FAIL__GPIO_3_19		0x21c 0x410 0x000 0x15 0x000
+
+#define MX25_PAD_CLKO__CLKO			0x220 0x414 0x000 0x10 0x000
+#define MX25_PAD_CLKO__GPIO_2_21		0x220 0x414 0x000 0x15 0x000
+
+#define MX25_PAD_BOOT_MODE0__BOOT_MODE0		0x224 0x000 0x000 0x00 0x000
+#define MX25_PAD_BOOT_MODE0__GPIO_4_30		0x224 0x000 0x000 0x05 0x000
+#define MX25_PAD_BOOT_MODE1__BOOT_MODE1		0x228 0x000 0x000 0x00 0x000
+#define MX25_PAD_BOOT_MODE1__GPIO_4_31		0x228 0x000 0x000 0x05 0x000
+
+#define MX25_PAD_CTL_GRP_DVS_MISC		0x000 0x418 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_FEC		0x000 0x41c 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DVS_JTAG		0x000 0x420 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_NFC		0x000 0x424 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_CSI		0x000 0x428 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_WEIM		0x000 0x42c 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_DDR		0x000 0x430 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DVS_CRM		0x000 0x434 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_KPP		0x000 0x438 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_SDHC1		0x000 0x43c 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_LCD		0x000 0x440 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_UART		0x000 0x444 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DVS_NFC		0x000 0x448 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DVS_CSI		0x000 0x44c 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DSE_CSPI1		0x000 0x450 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DDRTYPE		0x000 0x454 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DVS_SDHC1		0x000 0x458 0x000 0x00 0x000
+#define MX25_PAD_CTL_GRP_DVS_LCD		0x000 0x45c 0x000 0x00 0x000
+
+#endif /* __DTS_IMX25_PINFUNC_H */
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 623ed55..1c19ad3 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "skeleton.dtsi"
+#include "imx25-pinfunc.h"
 
 / {
 	aliases {
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7a6e6f7..9d19b3f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -109,6 +109,8 @@ config SOC_IMX25
 	select ARCH_MXC_IOMUX_V3
 	select CPU_ARM926T
 	select MXC_AVIC
+	select PINCTRL
+	select PINCTRL_IMX25
 
 config SOC_IMX27
 	bool
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index db1ddca..6fefb10 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -114,6 +114,14 @@ config PINCTRL_IMX1_CORE
 	select PINMUX
 	select PINCONF
 
+config PINCTRL_IMX25
+        bool "IMX25 pinctrl driver"
+        depends on OF
+        depends on SOC_IMX25
+        select PINCTRL_IMX
+        help
+          Say Y here to enable the imx25 pinctrl driver
+
 config PINCTRL_IMX27
 	bool "IMX27 pinctrl driver"
 	depends on OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 915d19c..663b793 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PINCTRL_IMX6SL)	+= pinctrl-imx6sl.o
 obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
 obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_IMX23)	+= pinctrl-imx23.o
+obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
 obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
 obj-$(CONFIG_PINCTRL_NOMADIK)	+= pinctrl-nomadik.o
 obj-$(CONFIG_PINCTRL_STN8815)	+= pinctrl-nomadik-stn8815.o
diff --git a/drivers/pinctrl/pinctrl-imx25.c b/drivers/pinctrl/pinctrl-imx25.c
new file mode 100644
index 0000000..8994b43
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-imx25.c
@@ -0,0 +1,351 @@
+/*
+ * imx25 pinctrl driver.
+ *
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This driver was mostly copied from the imx51 pinctrl driver which has:
+ *
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ * Copyright (C) 2012 Linaro, Inc.
+ *
+ * Author: Dong Aisheng <dong.aisheng@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-imx.h"
+
+enum imx25_pads {
+	MX25_PAD_RESERVE0 = 1,
+	MX25_PAD_RESERVE1 = 2,
+	MX25_PAD_A10 = 3,
+	MX25_PAD_A13 = 4,
+	MX25_PAD_A14 = 5,
+	MX25_PAD_A15 = 6,
+	MX25_PAD_A16 = 7,
+	MX25_PAD_A17 = 8,
+	MX25_PAD_A18 = 9,
+	MX25_PAD_A19 = 10,
+	MX25_PAD_A20 = 11,
+	MX25_PAD_A21 = 12,
+	MX25_PAD_A22 = 13,
+	MX25_PAD_A23 = 14,
+	MX25_PAD_A24 = 15,
+	MX25_PAD_A25 = 16,
+	MX25_PAD_EB0 = 17,
+	MX25_PAD_EB1 = 18,
+	MX25_PAD_OE = 19,
+	MX25_PAD_CS0 = 20,
+	MX25_PAD_CS1 = 21,
+	MX25_PAD_CS4 = 22,
+	MX25_PAD_CS5 = 23,
+	MX25_PAD_NF_CE0 = 24,
+	MX25_PAD_ECB = 25,
+	MX25_PAD_LBA = 26,
+	MX25_PAD_BCLK = 27,
+	MX25_PAD_RW = 28,
+	MX25_PAD_NFWE_B = 29,
+	MX25_PAD_NFRE_B = 30,
+	MX25_PAD_NFALE = 31,
+	MX25_PAD_NFCLE = 32,
+	MX25_PAD_NFWP_B = 33,
+	MX25_PAD_NFRB = 34,
+	MX25_PAD_D15 = 35,
+	MX25_PAD_D14 = 36,
+	MX25_PAD_D13 = 37,
+	MX25_PAD_D12 = 38,
+	MX25_PAD_D11 = 39,
+	MX25_PAD_D10 = 40,
+	MX25_PAD_D9 = 41,
+	MX25_PAD_D8 = 42,
+	MX25_PAD_D7 = 43,
+	MX25_PAD_D6 = 44,
+	MX25_PAD_D5 = 45,
+	MX25_PAD_D4 = 46,
+	MX25_PAD_D3 = 47,
+	MX25_PAD_D2 = 48,
+	MX25_PAD_D1 = 49,
+	MX25_PAD_D0 = 50,
+	MX25_PAD_LD0 = 51,
+	MX25_PAD_LD1 = 52,
+	MX25_PAD_LD2 = 53,
+	MX25_PAD_LD3 = 54,
+	MX25_PAD_LD4 = 55,
+	MX25_PAD_LD5 = 56,
+	MX25_PAD_LD6 = 57,
+	MX25_PAD_LD7 = 58,
+	MX25_PAD_LD8 = 59,
+	MX25_PAD_LD9 = 60,
+	MX25_PAD_LD10 = 61,
+	MX25_PAD_LD11 = 62,
+	MX25_PAD_LD12 = 63,
+	MX25_PAD_LD13 = 64,
+	MX25_PAD_LD14 = 65,
+	MX25_PAD_LD15 = 66,
+	MX25_PAD_HSYNC = 67,
+	MX25_PAD_VSYNC = 68,
+	MX25_PAD_LSCLK = 69,
+	MX25_PAD_OE_ACD = 70,
+	MX25_PAD_CONTRAST = 71,
+	MX25_PAD_PWM = 72,
+	MX25_PAD_CSI_D2 = 73,
+	MX25_PAD_CSI_D3 = 74,
+	MX25_PAD_CSI_D4 = 75,
+	MX25_PAD_CSI_D5 = 76,
+	MX25_PAD_CSI_D6 = 77,
+	MX25_PAD_CSI_D7 = 78,
+	MX25_PAD_CSI_D8 = 79,
+	MX25_PAD_CSI_D9 = 80,
+	MX25_PAD_CSI_MCLK = 81,
+	MX25_PAD_CSI_VSYNC = 82,
+	MX25_PAD_CSI_HSYNC = 83,
+	MX25_PAD_CSI_PIXCLK = 84,
+	MX25_PAD_I2C1_CLK = 85,
+	MX25_PAD_I2C1_DAT = 86,
+	MX25_PAD_CSPI1_MOSI = 87,
+	MX25_PAD_CSPI1_MISO = 88,
+	MX25_PAD_CSPI1_SS0 = 89,
+	MX25_PAD_CSPI1_SS1 = 90,
+	MX25_PAD_CSPI1_SCLK = 91,
+	MX25_PAD_CSPI1_RDY = 92,
+	MX25_PAD_UART1_RXD = 93,
+	MX25_PAD_UART1_TXD = 94,
+	MX25_PAD_UART1_RTS = 95,
+	MX25_PAD_UART1_CTS = 96,
+	MX25_PAD_UART2_RXD = 97,
+	MX25_PAD_UART2_TXD = 98,
+	MX25_PAD_UART2_RTS = 99,
+	MX25_PAD_UART2_CTS = 100,
+	MX25_PAD_SD1_CMD = 101,
+	MX25_PAD_SD1_CLK = 102,
+	MX25_PAD_SD1_DATA0 = 103,
+	MX25_PAD_SD1_DATA1 = 104,
+	MX25_PAD_SD1_DATA2 = 105,
+	MX25_PAD_SD1_DATA3 = 106,
+	MX25_PAD_KPP_ROW0 = 107,
+	MX25_PAD_KPP_ROW1 = 108,
+	MX25_PAD_KPP_ROW2 = 109,
+	MX25_PAD_KPP_ROW3 = 110,
+	MX25_PAD_KPP_COL0 = 111,
+	MX25_PAD_KPP_COL1 = 112,
+	MX25_PAD_KPP_COL2 = 113,
+	MX25_PAD_KPP_COL3 = 114,
+	MX25_PAD_FEC_MDC = 115,
+	MX25_PAD_FEC_MDIO = 116,
+	MX25_PAD_FEC_TDATA0 = 117,
+	MX25_PAD_FEC_TDATA1 = 118,
+	MX25_PAD_FEC_TX_EN = 119,
+	MX25_PAD_FEC_RDATA0 = 120,
+	MX25_PAD_FEC_RDATA1 = 121,
+	MX25_PAD_FEC_RX_DV = 122,
+	MX25_PAD_FEC_TX_CLK = 123,
+	MX25_PAD_RTCK = 124,
+	MX25_PAD_DE_B = 125,
+	MX25_PAD_GPIO_A = 126,
+	MX25_PAD_GPIO_B = 127,
+	MX25_PAD_GPIO_C = 128,
+	MX25_PAD_GPIO_D = 129,
+	MX25_PAD_GPIO_E = 130,
+	MX25_PAD_GPIO_F = 131,
+	MX25_PAD_EXT_ARMCLK = 132,
+	MX25_PAD_UPLL_BYPCLK = 133,
+	MX25_PAD_VSTBY_REQ = 134,
+	MX25_PAD_VSTBY_ACK = 135,
+	MX25_PAD_POWER_FAIL  = 136,
+	MX25_PAD_CLKO = 137,
+	MX25_PAD_BOOT_MODE0 = 138,
+	MX25_PAD_BOOT_MODE1 = 139,
+};
+
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc imx25_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(MX25_PAD_RESERVE0),
+	IMX_PINCTRL_PIN(MX25_PAD_RESERVE1),
+	IMX_PINCTRL_PIN(MX25_PAD_A10),
+	IMX_PINCTRL_PIN(MX25_PAD_A13),
+	IMX_PINCTRL_PIN(MX25_PAD_A14),
+	IMX_PINCTRL_PIN(MX25_PAD_A15),
+	IMX_PINCTRL_PIN(MX25_PAD_A16),
+	IMX_PINCTRL_PIN(MX25_PAD_A17),
+	IMX_PINCTRL_PIN(MX25_PAD_A18),
+	IMX_PINCTRL_PIN(MX25_PAD_A19),
+	IMX_PINCTRL_PIN(MX25_PAD_A20),
+	IMX_PINCTRL_PIN(MX25_PAD_A21),
+	IMX_PINCTRL_PIN(MX25_PAD_A22),
+	IMX_PINCTRL_PIN(MX25_PAD_A23),
+	IMX_PINCTRL_PIN(MX25_PAD_A24),
+	IMX_PINCTRL_PIN(MX25_PAD_A25),
+	IMX_PINCTRL_PIN(MX25_PAD_EB0),
+	IMX_PINCTRL_PIN(MX25_PAD_EB1),
+	IMX_PINCTRL_PIN(MX25_PAD_OE),
+	IMX_PINCTRL_PIN(MX25_PAD_CS0),
+	IMX_PINCTRL_PIN(MX25_PAD_CS1),
+	IMX_PINCTRL_PIN(MX25_PAD_CS4),
+	IMX_PINCTRL_PIN(MX25_PAD_CS5),
+	IMX_PINCTRL_PIN(MX25_PAD_NF_CE0),
+	IMX_PINCTRL_PIN(MX25_PAD_ECB),
+	IMX_PINCTRL_PIN(MX25_PAD_LBA),
+	IMX_PINCTRL_PIN(MX25_PAD_BCLK),
+	IMX_PINCTRL_PIN(MX25_PAD_RW),
+	IMX_PINCTRL_PIN(MX25_PAD_NFWE_B),
+	IMX_PINCTRL_PIN(MX25_PAD_NFRE_B),
+	IMX_PINCTRL_PIN(MX25_PAD_NFALE),
+	IMX_PINCTRL_PIN(MX25_PAD_NFCLE),
+	IMX_PINCTRL_PIN(MX25_PAD_NFWP_B),
+	IMX_PINCTRL_PIN(MX25_PAD_NFRB),
+	IMX_PINCTRL_PIN(MX25_PAD_D15),
+	IMX_PINCTRL_PIN(MX25_PAD_D14),
+	IMX_PINCTRL_PIN(MX25_PAD_D13),
+	IMX_PINCTRL_PIN(MX25_PAD_D12),
+	IMX_PINCTRL_PIN(MX25_PAD_D11),
+	IMX_PINCTRL_PIN(MX25_PAD_D10),
+	IMX_PINCTRL_PIN(MX25_PAD_D9),
+	IMX_PINCTRL_PIN(MX25_PAD_D8),
+	IMX_PINCTRL_PIN(MX25_PAD_D7),
+	IMX_PINCTRL_PIN(MX25_PAD_D6),
+	IMX_PINCTRL_PIN(MX25_PAD_D5),
+	IMX_PINCTRL_PIN(MX25_PAD_D4),
+	IMX_PINCTRL_PIN(MX25_PAD_D3),
+	IMX_PINCTRL_PIN(MX25_PAD_D2),
+	IMX_PINCTRL_PIN(MX25_PAD_D1),
+	IMX_PINCTRL_PIN(MX25_PAD_D0),
+	IMX_PINCTRL_PIN(MX25_PAD_LD0),
+	IMX_PINCTRL_PIN(MX25_PAD_LD1),
+	IMX_PINCTRL_PIN(MX25_PAD_LD2),
+	IMX_PINCTRL_PIN(MX25_PAD_LD3),
+	IMX_PINCTRL_PIN(MX25_PAD_LD4),
+	IMX_PINCTRL_PIN(MX25_PAD_LD5),
+	IMX_PINCTRL_PIN(MX25_PAD_LD6),
+	IMX_PINCTRL_PIN(MX25_PAD_LD7),
+	IMX_PINCTRL_PIN(MX25_PAD_LD8),
+	IMX_PINCTRL_PIN(MX25_PAD_LD9),
+	IMX_PINCTRL_PIN(MX25_PAD_LD10),
+	IMX_PINCTRL_PIN(MX25_PAD_LD11),
+	IMX_PINCTRL_PIN(MX25_PAD_LD12),
+	IMX_PINCTRL_PIN(MX25_PAD_LD13),
+	IMX_PINCTRL_PIN(MX25_PAD_LD14),
+	IMX_PINCTRL_PIN(MX25_PAD_LD15),
+	IMX_PINCTRL_PIN(MX25_PAD_HSYNC),
+	IMX_PINCTRL_PIN(MX25_PAD_VSYNC),
+	IMX_PINCTRL_PIN(MX25_PAD_LSCLK),
+	IMX_PINCTRL_PIN(MX25_PAD_OE_ACD),
+	IMX_PINCTRL_PIN(MX25_PAD_CONTRAST),
+	IMX_PINCTRL_PIN(MX25_PAD_PWM),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D2),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D3),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D4),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D5),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D6),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D7),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D8),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_D9),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_MCLK),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_VSYNC),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_HSYNC),
+	IMX_PINCTRL_PIN(MX25_PAD_CSI_PIXCLK),
+	IMX_PINCTRL_PIN(MX25_PAD_I2C1_CLK),
+	IMX_PINCTRL_PIN(MX25_PAD_I2C1_DAT),
+	IMX_PINCTRL_PIN(MX25_PAD_CSPI1_MOSI),
+	IMX_PINCTRL_PIN(MX25_PAD_CSPI1_MISO),
+	IMX_PINCTRL_PIN(MX25_PAD_CSPI1_SS0),
+	IMX_PINCTRL_PIN(MX25_PAD_CSPI1_SS1),
+	IMX_PINCTRL_PIN(MX25_PAD_CSPI1_SCLK),
+	IMX_PINCTRL_PIN(MX25_PAD_CSPI1_RDY),
+	IMX_PINCTRL_PIN(MX25_PAD_UART1_RXD),
+	IMX_PINCTRL_PIN(MX25_PAD_UART1_TXD),
+	IMX_PINCTRL_PIN(MX25_PAD_UART1_RTS),
+	IMX_PINCTRL_PIN(MX25_PAD_UART1_CTS),
+	IMX_PINCTRL_PIN(MX25_PAD_UART2_RXD),
+	IMX_PINCTRL_PIN(MX25_PAD_UART2_TXD),
+	IMX_PINCTRL_PIN(MX25_PAD_UART2_RTS),
+	IMX_PINCTRL_PIN(MX25_PAD_UART2_CTS),
+	IMX_PINCTRL_PIN(MX25_PAD_SD1_CMD),
+	IMX_PINCTRL_PIN(MX25_PAD_SD1_CLK),
+	IMX_PINCTRL_PIN(MX25_PAD_SD1_DATA0),
+	IMX_PINCTRL_PIN(MX25_PAD_SD1_DATA1),
+	IMX_PINCTRL_PIN(MX25_PAD_SD1_DATA2),
+	IMX_PINCTRL_PIN(MX25_PAD_SD1_DATA3),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_ROW0),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_ROW1),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_ROW2),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_ROW3),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_COL0),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_COL1),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_COL2),
+	IMX_PINCTRL_PIN(MX25_PAD_KPP_COL3),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_MDC),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_MDIO),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_TDATA0),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_TDATA1),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_TX_EN),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_RDATA0),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_RDATA1),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_RX_DV),
+	IMX_PINCTRL_PIN(MX25_PAD_FEC_TX_CLK),
+	IMX_PINCTRL_PIN(MX25_PAD_RTCK),
+	IMX_PINCTRL_PIN(MX25_PAD_DE_B),
+	IMX_PINCTRL_PIN(MX25_PAD_GPIO_A),
+	IMX_PINCTRL_PIN(MX25_PAD_GPIO_B),
+	IMX_PINCTRL_PIN(MX25_PAD_GPIO_C),
+	IMX_PINCTRL_PIN(MX25_PAD_GPIO_D),
+	IMX_PINCTRL_PIN(MX25_PAD_GPIO_E),
+	IMX_PINCTRL_PIN(MX25_PAD_GPIO_F),
+	IMX_PINCTRL_PIN(MX25_PAD_EXT_ARMCLK),
+	IMX_PINCTRL_PIN(MX25_PAD_UPLL_BYPCLK),
+	IMX_PINCTRL_PIN(MX25_PAD_VSTBY_REQ),
+	IMX_PINCTRL_PIN(MX25_PAD_VSTBY_ACK),
+	IMX_PINCTRL_PIN(MX25_PAD_POWER_FAIL),
+	IMX_PINCTRL_PIN(MX25_PAD_CLKO),
+	IMX_PINCTRL_PIN(MX25_PAD_BOOT_MODE0),
+	IMX_PINCTRL_PIN(MX25_PAD_BOOT_MODE1),
+};
+
+static struct imx_pinctrl_soc_info imx25_pinctrl_info = {
+	.pins = imx25_pinctrl_pads,
+	.npins = ARRAY_SIZE(imx25_pinctrl_pads),
+};
+
+static struct of_device_id imx25_pinctrl_of_match[] = {
+	{ .compatible = "fsl,imx25-iomuxc", },
+	{ /* sentinel */ }
+};
+
+static int imx25_pinctrl_probe(struct platform_device *pdev)
+{
+	return imx_pinctrl_probe(pdev, &imx25_pinctrl_info);
+}
+
+static struct platform_driver imx25_pinctrl_driver = {
+	.driver = {
+		.name = "imx25-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(imx25_pinctrl_of_match),
+	},
+	.probe = imx25_pinctrl_probe,
+	.remove = imx_pinctrl_remove,
+};
+
+static int __init imx25_pinctrl_init(void)
+{
+	return platform_driver_register(&imx25_pinctrl_driver);
+}
+arch_initcall(imx25_pinctrl_init);
+
+static void __exit imx25_pinctrl_exit(void)
+{
+	platform_driver_unregister(&imx25_pinctrl_driver);
+}
+module_exit(imx25_pinctrl_exit);
+MODULE_AUTHOR("Denis Carikli <denis@eukrea.com>");
+MODULE_DESCRIPTION("Freescale IMX25 pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
