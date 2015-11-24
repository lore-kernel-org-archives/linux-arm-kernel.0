From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Nov 2015 11:16:05 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: alt: Correct ether pfc
In-Reply-To: <1448331365-21388-1-git-send-email-horms+renesas@verge.net.au>
References: <1448331365-21388-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1448331365-21388-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

22b160713cb6 ("ARM: shmobile: alt: Add pfc pins to DT") introduced pfc pins
to the alt device tree but did not reference them. This patch fixes ether
pfc by:

* Referencing ether pins
* Adding and referencing phy1 pins
* Removing ether b pins. These are not used in the configuration
  of the alt board used for testing and empirically their presence
  prevents ethernet from functioning correctly in that environment.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Corrected commit referenced in changelog
---
 arch/arm/boot/dts/r8a7794-alt.dts | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 412eb7ad86db..7c72494f51b0 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -111,9 +111,9 @@
 		renesas,function = "eth";
 	};
 
-	ether_b_pins: ether {
-		renesas,groups = "eth_link_b", "eth_mdio_b", "eth_rmii_b";
-		renesas,function = "eth";
+	phy1_pins: phy1 {
+		renesas,groups = "intc_irq8";
+		renesas,function = "intc";
 	};
 
 	i2c1_pins: i2c1 {
@@ -132,6 +132,9 @@
 };
 
 &ether {
+	pinctrl-0 = <&ether_pins &phy1_pins>;
+	pinctrl-names = "default";
+
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
 	status = "okay";
-- 
2.1.4
