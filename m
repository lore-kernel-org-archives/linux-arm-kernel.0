From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 20 Dec 2017 15:22:12 +0200
Subject: [PATCH 2/2] arm64: dts: renesas: ulcb: Remove renesas,
 no-ether-link property
In-Reply-To: <1513776132-22700-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1513776132-22700-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1513776132-22700-3-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>

The present change is a bug fix for AVB link iteratively up/down.

Steps to reproduce:
- start AVB TX stream (Using aplay via MSE),
- disconnect+reconnect the eth cable,
- after a reconnection the eth connection goes iteratively up/down
  without user interaction,
- this may heal after some seconds or even stay for minutes.

As the documentation specifies, the "renesas,no-ether-link" option
should be used when a board does not provide a proper AVB_LINK signal.
There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
and ULCB starter kits since the AVB_LINK is correctly handled by HW.

Choosing to keep or remove the "renesas,no-ether-link" option will
have impact on the code flow in the following ways:
- keeping this option enabled may lead to unexpected behavior since
  the RX & TX are enabled/disabled directly from adjust_link function
  without any HW interrogation,
- removing this option, the RX & TX will only be enabled/disabled after
  HW interrogation. The HW check is made through the LMON pin in PSR
  register which specifies AVB_LINK signal value (0 - at low level;
  1 - at high level).

In conclusion, the present change is also a safety improvement because
it removes the "renesas,no-ether-link" option leading to a proper way
of detecting the link state based on HW interrogation and not on
software heuristic.

Signed-off-by: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index be91016e0b48..3e7a6b94e9f8 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -145,7 +145,6 @@
 &avb {
 	pinctrl-0 = <&avb_pins>;
 	pinctrl-names = "default";
-	renesas,no-ether-link;
 	phy-handle = <&phy0>;
 	status = "okay";
 
-- 
2.8.1
