From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Jul 2015 17:27:27 +0200
Subject: [PATCH v2 7/7] ARM: berlin: enable flash on the BG2Q DMP
In-Reply-To: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1436282847-21137-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1436282847-21137-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q DMP has a nand controller. Add the corresponding node, but do
not enable it by default because the nand is only available on some BG2Q
DMP.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 4a749e5b3b44..0d0146a773c0 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -140,3 +140,28 @@
 &sata_phy {
 	status = "okay";
 };
+
+&soc_pinctrl {
+	nand_pmux: nand-pmux {
+		groups = "G0", "G1";
+		function = "nand";
+	};
+};
+
+&nand0 {
+	pinctrl-0 = <&nand_pmux>;
+	pinctrl-names = "default";
+
+	marvell,nand-enable-arbiter;
+	nand-ecc-strength = <48>;
+	nand-ecc-step-size = <1024>;
+
+	num-cs = <1>;
+
+	/*
+	 * Two kinds of BG2Q DMP are available: one with emmc and
+	 * one with a nand. The latter is not widespread. Because
+	 * of this, disable the nand by default.
+	 */
+	status = "disabled";
+};
-- 
2.4.5
