From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 23 Oct 2015 11:28:11 -0700
Subject: [PATCH 4/4] ARM: dts: rockchip: Point rk3288 dwc2 usb at phy port
 reset
In-Reply-To: <1445624891-31680-1-git-send-email-dianders@chromium.org>
References: <1445624891-31680-1-git-send-email-dianders@chromium.org>
Message-ID: <1445624891-31680-5-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "host1" port (AKA the dwc2 port that isn't the OTG port) on rk3288
has a hardware errata that causes everything to get confused when we get
a remote wakeup.  It appears that the "port reset" bit that's in the USB
phy (located in the rk3288 GRF) fixes things up and appears safe to do.

We recently added code to the PHY to expose this reset and code to dwc2
to use it, so now let's hook things up.

Note that we add the PHY port reset to both dwc2 controllers even though
only one has the errata in case we find some other use for this reset
that's unrelated to the current hardware errata.  Only the host port
gets the quirk property, though.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 4f76805..03de41d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -496,6 +496,9 @@
 		dr_mode = "host";
 		phys = <&usbphy2>;
 		phy-names = "usb2-phy";
+		resets = <&usbphy2>;
+		reset-names = "phy-port-reset";
+		snps,need-phy-port-reset-on-wake;
 		status = "disabled";
 	};
 
@@ -513,6 +516,8 @@
 		g-use-dma;
 		phys = <&usbphy0>;
 		phy-names = "usb2-phy";
+		resets = <&usbphy0>;
+		reset-names = "phy-port-reset";
 		status = "disabled";
 	};
 
-- 
2.6.0.rc2.230.g3dd15c0
