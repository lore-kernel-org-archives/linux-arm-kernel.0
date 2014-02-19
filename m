From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Feb 2014 08:13:48 -0300
Subject: [PATCH v2] ARM: dts: imx6sl-evk: Keep VGEN1 regulator always enabled
Message-ID: <1392808428-26143-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On imx6sl-evk board the VGEN1 regulator powers up the NVCC_1P2V domain of the
imx6sl SoC, so we need to keep it always powered.

According to imx6sl datasheet the GPIO block has three supplies:
NVCC33_IO, NVCC18_IO and NVCC_1P2V and it states that:
"All digital I/O supplies (NVCC_xxxx) must be powered under normal conditions
whether the associated I/O pins are in use or not"

This problem has been observed by the fact that a GPIO connected to an LED could
not work when the PMIC driver was enabled.

Keeping VGEN1 regulator always enabled fixes the problem.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Explain why VGEN1 disabled impacts the GPIO function
- Remove 'regulator-boot-on' as per Mark Brown's suggestion

 arch/arm/boot/dts/imx6sl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 889422c..864d8df 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -195,6 +195,7 @@
 			vgen1_reg: vgen1 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
 			};
 
 			vgen2_reg: vgen2 {
-- 
1.8.1.2
