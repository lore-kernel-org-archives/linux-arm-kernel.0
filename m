From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 30 Oct 2015 13:17:54 -0700
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Point rk3288 dwc2 usb at the full
 PHY reset
In-Reply-To: <1446236275-12698-1-git-send-email-dianders@chromium.org>
References: <1446236275-12698-1-git-send-email-dianders@chromium.org>
Message-ID: <1446236275-12698-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

The "host1" port (AKA the dwc2 port that isn't the OTG port) on rk3288
has a hardware errata that causes everything to get confused when we get
a remote wakeup.  We'll use the reset that's in the CRU to reset the
port when it's in a bad state.

Note that we add the reset to both dwc2 controllers even though only one
has the errata in case we find some other use for this reset that's
unrelated to the current hardware errata.  Only the host port gets the
quirk property, though.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- Use a full PHY reset for safety; no PHY changes needed for that.

 arch/arm/boot/dts/rk3288.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 906e938fb6bf..58773beb283f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -496,6 +496,9 @@
 		dr_mode = "host";
 		phys = <&usbphy2>;
 		phy-names = "usb2-phy";
+		resets = <&cru SRST_USBHOST1_PHY>;
+		reset-names = "phy-full-reset";
+		snps,need-phy-full-reset-on-wake;
 		status = "disabled";
 	};
 
@@ -513,6 +516,8 @@
 		g-use-dma;
 		phys = <&usbphy0>;
 		phy-names = "usb2-phy";
+		resets = <&cru SRST_USBOTG_PHY>;
+		reset-names = "phy-full-reset";
 		status = "disabled";
 	};
 
-- 
2.6.0.rc2.230.g3dd15c0
