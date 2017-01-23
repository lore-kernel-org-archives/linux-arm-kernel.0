From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Mon, 23 Jan 2017 16:14:59 +0100
Subject: [RFC] ARM: dts: imx53-qsb-common: fix FEC pinmux config
Message-ID: <20170123151459.29691-1-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

The pinmux configuration in device tree is different from manual
muxing in <u-boot>/board/freescale/mx53loco/mx53loco.c
It seems the device tree configuration is never used by any kernel
driver and the correct setting, preconfigured by u-boot, was never
overwritten. So this issue never showed up anywhere.

---
I stumbled upon this difference, while adding the imx53 based CX9020
Embedded PC to u-boot bootloader. "New" boards are encouraged to use
device tree for pinmuxing in u-boot, so I tried to reuse
imx53-qsb-common.dtsi for that. That failed with a high packet loss on
the fec_mxc device. With the attached patch that device tree based
pinmuxing seems successful in u-boot. My suggestion is to apply it to
imx53-qsb-common.dtsi, too. That will help other "late adopters" and
prevent similar issues, in case any kernel driver starts using this
pinmux configurations.

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
---
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index c05e7cfd0cbc..40b3e31935d0 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -215,16 +215,16 @@
 
 		pinctrl_fec: fecgrp {
 			fsl,pins = <
-				MX53_PAD_FEC_MDC__FEC_MDC		0x80000000
-				MX53_PAD_FEC_MDIO__FEC_MDIO		0x80000000
-				MX53_PAD_FEC_REF_CLK__FEC_TX_CLK	0x80000000
-				MX53_PAD_FEC_RX_ER__FEC_RX_ER		0x80000000
-				MX53_PAD_FEC_CRS_DV__FEC_RX_DV		0x80000000
-				MX53_PAD_FEC_RXD1__FEC_RDATA_1		0x80000000
-				MX53_PAD_FEC_RXD0__FEC_RDATA_0		0x80000000
-				MX53_PAD_FEC_TX_EN__FEC_TX_EN		0x80000000
-				MX53_PAD_FEC_TXD1__FEC_TDATA_1		0x80000000
-				MX53_PAD_FEC_TXD0__FEC_TDATA_0		0x80000000
+				MX53_PAD_FEC_MDC__FEC_MDC		0x4
+				MX53_PAD_FEC_MDIO__FEC_MDIO		0x1fc
+				MX53_PAD_FEC_REF_CLK__FEC_TX_CLK	0x180
+				MX53_PAD_FEC_RX_ER__FEC_RX_ER		0x180
+				MX53_PAD_FEC_CRS_DV__FEC_RX_DV		0x180
+				MX53_PAD_FEC_RXD1__FEC_RDATA_1		0x180
+				MX53_PAD_FEC_RXD0__FEC_RDATA_0		0x180
+				MX53_PAD_FEC_TX_EN__FEC_TX_EN		0x4
+				MX53_PAD_FEC_TXD1__FEC_TDATA_1		0x4
+				MX53_PAD_FEC_TXD0__FEC_TDATA_0		0x4
 			>;
 		};
 
-- 
2.11.0
