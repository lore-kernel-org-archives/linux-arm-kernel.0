From: balbi@ti.com (Felipe Balbi)
Date: Thu, 15 Jan 2015 09:38:03 -0600
Subject: [PATCH] arm: boot: dts: dra7: enable dwc3 suspend PHY quirk
Message-ID: <1421336283-17904-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever Suspend PHY bit is set on DRA7x devices,
USB will not work due to Set EP Configuration command
always failing.

This was only found after a recent commit 2164a47 (usb:
dwc3: set SUSPHY bit for all cores, which will be merged
for v3.19) added a missing *required* step to dwc3
initialization. Synopsys Databook requires that we enable
Suspend PHY bit after initialization but that, unfortunately,
breaks DRA7x.

Note that the same regression was already patched for AM437x.

Reported-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Tony, this fixes a regression with v3.19

 arch/arm/boot/dts/dra7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 22771bc1643a..63f8b007bdc5 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1257,6 +1257,8 @@
 				tx-fifo-resize;
 				maximum-speed = "super-speed";
 				dr_mode = "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
@@ -1278,6 +1280,8 @@
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
@@ -1299,6 +1303,8 @@
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
-- 
2.2.0
