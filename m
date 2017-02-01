From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Feb 2017 09:42:00 +0100
Subject: [PATCH 1/5] arm64: dts: r8a7795: Use rgmii-txid phy-mode for
 EthernetAVB
In-Reply-To: <1485938524-9322-1-git-send-email-horms+renesas@verge.net.au>
References: <1485938524-9322-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1485938524-9322-2-git-send-email-horms+renesas@verge.net.au>
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

[v1] Simon Horman
- Rewrote changelog

  N.B. The communications failures have been reported by the BSP team,
       however I did not observe them during testing with a
       salvator-x/M3-W-ES1.0

       I have also exercised this on salvator-x/H3-ES1.0, which
       supports a maximum communication speed of 100Mbit/s. I did
       not observe communications failures during that testing.

       My test-case was to bring up the system using NFS root and
       run: netperf -H <HOST>

[v0] Kazuya Mizuguchi
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
