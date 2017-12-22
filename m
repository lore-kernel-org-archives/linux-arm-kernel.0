From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:29 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: ulcb: Remove renesas,
 no-ether-link property
In-Reply-To: <cover.1513938447.git.horms+renesas@verge.net.au>
References: <cover.1513938447.git.horms+renesas@verge.net.au>
Message-ID: <7d2901f809c110bd9a261e879d59efe62e3bc758.1513938447.git.horms+renesas@verge.net.au>
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

Fixes: dc36965a8905 ("arm64: dts: r8a7796: salvator-x: Enable EthernetAVB")
Fixes: 6fa501c549aa ("arm64: dts: r8a7795: enable EthernetAVB on Salvator-X")
Signed-off-by: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 0d85b315ce71..73439cf48659 100644
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
2.11.0
