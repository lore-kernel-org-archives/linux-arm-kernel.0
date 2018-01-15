From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Jan 2018 09:41:25 +0100
Subject: [PATCH 3/3] arm64: dts: renesas: draak: Remove renesas,
 no-ether-link property
In-Reply-To: <20180115084125.8112-1-horms+renesas@verge.net.au>
References: <20180115084125.8112-1-horms+renesas@verge.net.au>
Message-ID: <20180115084125.8112-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regarding Salvator-X and ULCB boards, Bogdan Mirea says:

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

On examination of the documentation for the Draak board this change seems
necessary as AVB0_LINK is documented as being connected.

Fixes: 4503b50eac08 ("arm64: dts: renesas: r8a77995: draak: enable EthernetAVB")
Cc: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 09de73b11db8..ee82ec26428a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -78,7 +78,6 @@
 &avb {
 	pinctrl-0 = <&avb0_pins>;
 	pinctrl-names = "default";
-	renesas,no-ether-link;
 	phy-handle = <&phy0>;
 	status = "okay";
 
-- 
2.11.0
