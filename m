From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  7 Jan 2016 16:25:46 +0800
Subject: [PATCH v2 03/12] ARM: dts: rockchip: override the clocks in i2s for
 kylin board
In-Reply-To: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452155155-16232-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysclk seems be incorrect since we use the simple card for kylin
board.

The simple card call:

asoc_simple_card_probe ->
 asoc_simple_card_dai_link_of ->
  asoc_simple_card_sub_parse_of ->
...
clk = of_clk_get(args.np, 0);
if (!IS_ERR(clk))
dai->sysclk = clk_get_rate(clk);

The sysclk come from the first clock, then first clock is hclk_i2s
in i2s for rk3036 dtsi.
So, we can override the clocks to fit the simple card in here.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rk3036-kylin.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 27b6326..b642369 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -288,6 +288,13 @@
 };
 
 &i2s {
+	/**
+	 * We should override the clocks since sysclk from the first clock
+	 * in simple card.
+	 */
+	clock-names = "i2s_clk", "i2s_hclk";
+	clocks = <&cru SCLK_I2S>, <&cru HCLK_I2S>;
+
 	#sound-dai-cells = <0>;
 	status = "okay";
 };
-- 
1.9.1
