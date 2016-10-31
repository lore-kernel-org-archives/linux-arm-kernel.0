From: david@lechnology.com (David Lechner)
Date: Mon, 31 Oct 2016 15:47:19 -0500
Subject: [PATCH v8 1/3] ARM: dts: da850: Add cfgchip syscon node
In-Reply-To: <1477946841-16126-1-git-send-email-david@lechnology.com>
References: <1477946841-16126-1-git-send-email-david@lechnology.com>
Message-ID: <1477946841-16126-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a syscon node for the SoC CFGCHIPn registers. It includes a child node
for the USB PHY that is part of this range of registers.

Also have to add OF_DEV_AUXDATA() entry so that clock lookup will work for
the the USB PHY driver.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi     | 10 ++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 4c83613..2534aab 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -209,6 +209,16 @@
 			};
 
 		};
+		cfgchip: chip-controller at 1417c {
+			compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
+			reg = <0x1417c 0x14>;
+
+			usb_phy: usb-phy {
+				compatible = "ti,da830-usb-phy";
+				#phy-cells = <1>;
+				status = "disabled";
+			};
+		};
 		edma0: edma at 0 {
 			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index aec569f9..20fa842 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -41,6 +41,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da850-tilcdc", 0x01e13000, "da8xx_lcdc.0", NULL),
 	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci", NULL),
 	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
+	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
 	{}
 };
 
-- 
2.7.4
