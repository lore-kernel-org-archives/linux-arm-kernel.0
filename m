From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 12 Apr 2017 15:04:35 -0300
Subject: [PATCH] ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin
Message-ID: <1492020275-29654-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the following errors are seeing:

[   14.015056] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.321093] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.411681] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.456281] mc13xxx 0-0008: Failed to read IRQ status: -6
[   30.527106] mc13xxx 0-0008: Failed to read IRQ status: -6
[   36.596900] mc13xxx 0-0008: Failed to read IRQ status: -6

Also when reading the interrupts via 'cat /proc/interrupts' the
PMIC GPIO interrupt counter does not stop increasing.

The reason for the storm of interrupts is that the PUS field of
register IOMUXC_SW_PAD_CTL_PAD_CSI0_DAT5 is currently configured as:
10 : 100k pullup

and the PMIC interrupt is being registered as IRQ_TYPE_LEVEL_HIGH type,
which is the correct type as per the MC34708 datasheet.

Use the default power on value for the IOMUX, which sets PUS field as:
00: 360k pull down

This prevents the spurious PMIC interrupts from happening.

Commit e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
correctly described the irq type as IRQ_TYPE_LEVEL_HIGH, but
missed to update the IOMUX of the PMIC GPIO to pull down.

Fixes: e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-qsrb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsrb.dts
index de22158..4e103a9 100644
--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -23,7 +23,7 @@
 	imx53-qsrb {
 		pinctrl_pmic: pmicgrp {
 			fsl,pins = <
-				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1e4 /* IRQ */
+				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1c4 /* IRQ */
 			>;
 		};
 	};
-- 
2.7.4
