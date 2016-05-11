From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 11 May 2016 19:19:10 -0400
Subject: [PATCH v2 3/3] arm: dts: bcm5301x: Add syscon based reboot in DT
In-Reply-To: <1463008750-13902-1-git-send-email-jonmason@broadcom.com>
References: <1463008750-13902-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1463008750-13902-4-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ability to reboot via a reset of the processor.  This is
achieved via a write of 0x39 to the CRU Reset Register.  Unfortunately,
this only resets the core and not the other IP blocks.  So if possible,
other methods should be used on the individual boards.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index ffc4a9b..d4e1672 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -246,6 +246,18 @@
 				     "sata2";
 	};
 
+	cru: cru at 1800c184 {
+		compatible = "syscon";
+		reg = <0x1800c184 0x4>;
+	};
+
+	reboot at 1800c184 {
+		compatible ="syscon-reboot";
+		regmap = <&cru>;
+		offset = <0>;
+		mask = <0x39>;
+	};
+
 	nand: nand at 18028000 {
 		compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1", "brcm,brcmnand";
 		reg = <0x18028000 0x600>, <0x1811a408 0x600>, <0x18028f00 0x20>;
-- 
1.9.1
