From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:20 +0200
Subject: [PATCH 058/102] arm64: dts: renesas: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <a0b0be30a096a18f050bc53eed6c9b814d84cfac.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The DU1 external dot clock is provided by the fixed frequency clock
generator X21, while the DU0 and DU3 clocks are provided by the
programmable Versaclock5 clock generator.

Enable the clocks, and the HDMI encoder for the M3-N Salvator-X board
and hook it up to the HDMI connector.

Based on patches from Takeshi Kihara <takeshi.kihara.df@renesas.com>

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
index 75d890d91df9..340a3c72b65a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
@@ -19,3 +19,31 @@
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 };
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 721>,
+		 <&versaclock5 1>,
+		 <&x21_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.3",
+		      "dclkin.0", "dclkin.1", "dclkin.3";
+};
+
+&hdmi0 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+			rcar_dw_hdmi0_out: endpoint {
+				remote-endpoint = <&hdmi0_con>;
+			};
+		};
+	};
+};
+
+&hdmi0_con {
+	remote-endpoint = <&rcar_dw_hdmi0_out>;
+};
-- 
2.11.0
