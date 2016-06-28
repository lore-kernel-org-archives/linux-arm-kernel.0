From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 28 Jun 2016 18:10:33 -0400
Subject: [PATCH 2/2] arm: dts: nsp: Add syscon based reboot in DT
In-Reply-To: <1467151833-20767-1-git-send-email-jon.mason@broadcom.com>
References: <1467151833-20767-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1467151833-20767-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mason <jonmason@broadcom.com>

Add the ability to reboot via a reset of the processor.  This is
achieved via a write of 0x2f9 to the CRU Reset Register.  Unfortunately,
this only resets the core and not the other IP blocks.  So if possible,
other methods should be used on the individual boards.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 1759e65..d56166b 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -266,6 +266,18 @@
 			      <0x30028 0x04>,
 			      <0x3f408 0x04>;
 		};
+
+		cru: system-controller at 3f184 {
+			compatible = "brcm,nsp-cru", "syscon";
+			reg = <0x3f184 0x4>;
+		};
+
+		reboot: reboot at 3f184 {
+			compatible ="syscon-reboot";
+			regmap = <&cru>;
+			offset = <0>;
+			mask = <0x2f9>;
+		};
 	};
 
 	pcie0: pcie at 18012000 {
-- 
1.9.1
