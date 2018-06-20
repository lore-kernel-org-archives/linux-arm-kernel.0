From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 15:06:19 -0300
Subject: [PATCH] ARM: imx51: Add aipstz nodes
Message-ID: <1529517979-6406-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently when trying to use the 'devmem' tool to read/write
registers the following bus error is observed:

# devmem 0x73fa80c4 32
[   82.689185] Unhandled fault: external abort on non-linefetch (0x1018) at 0xb6ff10c4
[   82.697071] pgd = (ptrval)
[   82.699920] [b6ff10c4] *pgd=a87c5831, *pte=73fa8383, *ppte=73fa8a33
Bus error

Add the aipstz nodes, so that the following function from
imx51_dt_init() can work properly:

	imx_aips_allow_unprivileged_access("fsl,imx51-aipstz");

After adding these nodes, 'devmem' tool can work correctly,
which is very useful for debugging purposes.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fe01b89..55e4174 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -250,6 +250,11 @@
 				};
 			};
 
+			aipstz1: bridge at 73f00000 {
+				compatible = "fsl,imx51-aipstz";
+				reg = <0x73f00000 0x60>;
+			};
+
 			usbotg: usb at 73f80000 {
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80000 0x0200>;
@@ -435,6 +440,11 @@
 			reg = <0x80000000 0x10000000>;
 			ranges;
 
+			aipstz2: bridge at 83f00000 {
+				compatible = "fsl,imx51-aipstz";
+				reg = <0x83f00000 0x60>;
+			};
+
 			iim: iim at 83f98000 {
 				compatible = "fsl,imx51-iim", "fsl,imx27-iim";
 				reg = <0x83f98000 0x4000>;
-- 
2.7.4
