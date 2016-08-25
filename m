From: zach.brown@ni.com (Zach Brown)
Date: Thu, 25 Aug 2016 18:01:50 -0500
Subject: [PATCH v2 1/2] sdhci-of-arasan: Modify arasan sdhci documentation
 about broken-cd and non-removable properties.
Message-ID: <1472166111-28872-1-git-send-email-zach.brown@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci controller on xilinx zynq devices will not function unless
the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
In cases where it is impossible to provide the CD bit in hardware,
setting the controller to test mode and then setting inserted to true
will get the controller to function without the CD bit.

Additionally in some situations it will make sense to use the
"broken-cd" and "non-removable" property together.
i.e the sd device is non-removable so polling doesn't make sense, but
the CD is broken and the controller will need to be in test mode to
function.

This patch modifies the documentation to reflect those differences
from the standard behaviours.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
v2:
  * improved commit messages
  * removed fake-cd device property
  * removed fake-cd quirk
  * use broken-cd device property
  * documented new usage of broken-cd

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 3404afa..b41c448 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -37,6 +37,14 @@ Optional Properties:
     in place we will export a clock representing the Card Clock.  This clock
     is expected to be consumed by our PHY.  You must also specify
 
+Card detection:
+The arasan controller does not work
+when the CD bit is not supplied unless in test mode.
+- broken-cd: The CD bit is not supplied and the controller will
+  need to be set to test mode to function.
+- non-removable: like normal, except it can now be partnered with
+  broken-cd, which will turn off polling, but keep test mode on.
+
 Example:
 	sdhci at e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -72,4 +80,4 @@ Example:
 		phy-names = "phy_arasan";
 		#clock-cells = <0>;
 		status = "disabled";
-	};
+	} ;
-- 
2.7.4
