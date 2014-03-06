From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 15:41:55 +0100
Subject: [PATCH] ARM: mvebu: use the correct phy connection mode on Armada 385
 DB
Message-ID: <1394116915-14424-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 385 DB, while the "rgmii" PHY connection mode works fine
with the generic PHY driver, it fails to work when the Marvell PHY
driver is enabled in the kernel configuration, due to a finer handling
of the PHY configuration. This is due to the fact that the phy
connection mode should instead be "rgmii-id", i.e with the TX/RX delay
mechanisms enabled.

This fixes the network operation on Armada 385 DB with
CONFIG_MARVELL_PHY=y. Without this patch and this option enabled, one
would only get messages such as:

  mvneta f1070000.ethernet eth1: bad rx status 0cc10000 (crc error), size=70

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Jason, this commit is based on mvebu/dt-3xx

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 01b6cc7..9a13642 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -62,13 +62,13 @@
 			ethernet at 30000 {
 				status = "okay";
 				phy = <&phy1>;
-				phy-mode = "rgmii";
+				phy-mode = "rgmii-id";
 			};
 
 			ethernet at 70000 {
 				status = "okay";
 				phy = <&phy0>;
-				phy-mode = "rgmii";
+				phy-mode = "rgmii-id";
 			};
 
 			mdio {
-- 
1.8.3.2
