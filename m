From: ryan@presslab.us (Ryan Press)
Date: Tue, 26 Mar 2013 16:32:31 -0700
Subject: [PATCH] arm: mvebu: Fix pinctrl for Armada 370 Mirabox SDIO port.
Message-ID: <1364340751-10585-1-git-send-email-ryan@presslab.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous configuration used the wrong "clk" pin.  Without this change mv_sdio worked because the bootloader would set the pin up, but with a bootloader that does not set the pin, mv_sdio fails to detect any card.

I have tested this change using a mwifiex_sdio wireless network adapter over the SDIO interface.

Signed-off-by: Ryan Press <ryan@presslab.us>
---
 arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
 arch/arm/boot/dts/armada-370.dtsi        | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index dd0c57d..3234875 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -54,7 +54,7 @@
 		};
 
 		mvsdio at d00d4000 {
-			pinctrl-0 = <&sdio_pins2>;
+			pinctrl-0 = <&sdio_pins3>;
 			pinctrl-names = "default";
 			status = "okay";
 			/*
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 8188d13..a195deb 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -59,6 +59,12 @@
 					     "mpp50", "mpp51", "mpp52";
 			      marvell,function = "sd0";
 			};
+
+			sdio_pins3: sdio-pins3 {
+			      marvell,pins = "mpp48", "mpp49", "mpp50",
+					     "mpp51", "mpp52", "mpp53";
+			      marvell,function = "sd0";
+			};
 	        };
 
 		gpio0: gpio at d0018100 {
-- 
1.8.1.2
