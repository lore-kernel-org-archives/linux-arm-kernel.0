From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:17 +0100
Subject: [PATCH 06/32] arm64: dts: r8a7795: Use rgmii-txid phy-mode for
 EthernetAVB
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <dda3887907d743385f2599fa18c765bd295ae2da.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Since commit 61fccb2d6274 ("ravb: Add tx and rx clock internal delays mode
of APSR") the EthernetAVB driver enables tx and rx clock internal delay
modes (TDM and RDM) depending on the phy mode as follows:

    phy mode   | ASPR delay mode
    -----------+----------------
    rgmii-id   | TDM and RDM
    rgmii-rxid | RDM
    rgmii-txid | TDM

And prior to the above commit no internal delay mode settings were
implemented for any phy mode.

With this and the above change present tx internal delay mode is enabled
which has been observed to address failures in the case of 1Gbps
communication using the by salvator-x board with the KSZ9031RNX phy. This
has been reported to occur with both the r8a7795 (H3) and r8a7796 (M3-W)
SoCs.

With the above patch present but this patch present tx and rx internal
delay modes are enabled; and with the above patch and this present absent
no internal delay modes are enabled. In both cases failures have been
observed when using 1Gbps communication in the environments described
above.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fe266bb3d913..382a8987bca9 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -564,7 +564,7 @@
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			phy-mode = "rgmii-id";
+			phy-mode = "rgmii-txid";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.7.0.rc3.207.g0ac5344
