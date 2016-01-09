From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 09 Jan 2016 03:31:33 +0100
Subject: [PATCH v2 03/12] ARM: dts: rockchip: override the clocks in i2s
 for kylin board
In-Reply-To: <1452155155-16232-4-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
 <1452155155-16232-4-git-send-email-wxt@rock-chips.com>
Message-ID: <1878139.nbddSBf70A@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Donnerstag, 7. Januar 2016, 16:25:46 schrieb Caesar Wang:
> The sysclk seems be incorrect since we use the simple card for kylin
> board.
> 
> The simple card call:
> 
> asoc_simple_card_probe ->
>  asoc_simple_card_dai_link_of ->
>   asoc_simple_card_sub_parse_of ->
> ...
> clk = of_clk_get(args.np, 0);
> if (!IS_ERR(clk))
> dai->sysclk = clk_get_rate(clk);
> 
> The sysclk come from the first clock, then first clock is hclk_i2s
> in i2s for rk3036 dtsi.
> So, we can override the clocks to fit the simple card in here.

It's not that effective, doing that change on a per-board level - as it
would possibly need to be repeated for future boards.
The i2s driver doesn't care, as it uses named clocks, so I instead did
the swap in the rk3036.dtsi for all boards. Can you check if that is ok
for you or if I did overlook something?


Thanks
Heiko

------- 8< -------
Subject: [PATCH] ARM: dts: rockchip: swap i2s clock ordering on rk3036

For sound setups using the simple-card mechanism, the main clock
(sysclk) is expected to be the first element. For the i2s-driver
itself it doesn't matter, as it uses named clocks, so we can just
swap them.

Reported-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3036.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 8f1bb0f..ee457a2 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -241,8 +241,8 @@
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clock-names = "i2s_hclk", "i2s_clk";
-		clocks = <&cru HCLK_I2S>, <&cru SCLK_I2S>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		clocks = <&cru SCLK_I2S>, <&cru HCLK_I2S>;
 		dmas = <&pdma 0>, <&pdma 1>;
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
-- 
2.6.4
