From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Nov 2016 15:23:24 +0530
Subject: [PATCH v8 1/3] ARM: dts: da850: Add cfgchip syscon node
In-Reply-To: <1477946841-16126-2-git-send-email-david@lechnology.com>
References: <1477946841-16126-1-git-send-email-david@lechnology.com>
 <1477946841-16126-2-git-send-email-david@lechnology.com>
Message-ID: <b3617c00-1f1d-5ab8-23e9-a96307a53558@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tuesday 01 November 2016 02:17 AM, David Lechner wrote:
> Add a syscon node for the SoC CFGCHIPn registers. It includes a child node
> for the USB PHY that is part of this range of registers.
> 
> Also have to add OF_DEV_AUXDATA() entry so that clock lookup will work for
> the the USB PHY driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

For future, please do not combine device-tree addition and other C code into a 
single patch. I have applied this patch while splitting it into two as 
attached.

Thanks,
Sekhar

---8<---
From: David Lechner <david@lechnology.com>
Date: Mon, 31 Oct 2016 15:47:19 -0500
Subject: [PATCH] ARM: dts: da850: Add cfgchip syscon node

Add a syscon node for the SoC CFGCHIPn registers. It includes a child node
for the USB PHY that is part of this range of registers.

Signed-off-by: David Lechner <david@lechnology.com>
[nsekhar at ti.com: drop OF_DEV_AUXDATA() addition]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 4c836133a183..2534aab851e1 100644
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
-- 
2.9.0

---8<---
From: David Lechner <david@lechnology.com>
Date: Mon, 31 Oct 2016 15:47:19 -0500
Subject: [PATCH] ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for USB phy

Add OF_DEV_AUXDATA() entry for USB phy. This is required for
so that clock lookup will work for the USB PHY driver.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 0e45cbd57273..5e67618180a7 100644
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
2.9.0
