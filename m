From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Jan 2017 17:57:00 +0100
Subject: [PATCH v3 10/13] arm64: allwinner: a64: Increase the MMC max frequency
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Message-ID: <331b186d5caebe91c236e2ef6b8daf3117621d6d.1484585798.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC controller seem to have a maximum frequency of 200MHz, while the
regular MMC controllers are capped at 150MHz.

Since older SoCs cannot go that high, we cannot change the default maximum
frequency, but fortunately for us we have a property for that in the DT.

This also has the side effect of allowing to use the MMC HS200 and SD
SDR104 modes for the boards that support it (with either 1.2v or 1.8v IOs).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

arm64: allwinner: a64: Limit MMC0 and MMC1 rates to 150MHz

Trying to set the bus to 200MHz on MMC1 when doing SDIO is failing.
Allwinner sets the maximum for this bus to 150MHz, so enforce that limit.

This hasn't been tested with MMC0, but the documented limit is the same,
and I expect the behaviour to be the same.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
 1 file changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8e149498e096..b371fccc234b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -332,6 +332,7 @@
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -345,6 +346,7 @@
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -358,6 +360,7 @@
 			resets = <&ccu RST_BUS_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
git-series 0.8.11
