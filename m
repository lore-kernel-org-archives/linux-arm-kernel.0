From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Feb 2017 09:07:06 +0100
Subject: [PATCH 5/8] arm64: dts: allwinner: add R_PIO node
In-Reply-To: <39431486552126@web41j.yandex.ru>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
 <20170208100009.29362-5-icenowy@aosc.xyz>
 <20170208101458.du6ybqsw52ypzhzw@lukather>
 <39431486552126@web41j.yandex.ru>
Message-ID: <20170210080706.loofvr3mmctfa2mc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 07:08:46PM +0800, Icenowy Zheng wrote:
> 08.02.2017, 18:15, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Wed, Feb 08, 2017 at 06:00:06PM +0800, Icenowy Zheng wrote:
> >> ?Allwinner A64 SoC has a R_PIO node like the one in H3.
> >>
> >> ?Add the node as well as needed clocks and resets.
> >>
> >> ?As there's no document for apb0_gates, I only added the R_PIO bit here.
> >>
> >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> ?---
> >> ??arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 40 +++++++++++++++++++++++++++
> >> ??1 file changed, 40 insertions(+)
> >>
> >> ?diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> ?index 1c64ea2d23f9..4b0baa79554c 100644
> >> ?--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> ?+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> ?@@ -98,6 +98,15 @@
> >> ??????????????????clock-output-names = "osc32k";
> >> ??????????};
> >>
> >> ?+ apb0: apb0_clk {
> >> ?+ compatible = "fixed-factor-clock";
> >> ?+ #clock-cells = <0>;
> >> ?+ clock-div = <1>;
> >> ?+ clock-mult = <1>;
> >> ?+ clocks = <&osc24M>;
> >> ?+ clock-output-names = "apb0";
> >> ?+ };
> >> ?+
> >> ??????????psci {
> >> ??????????????????compatible = "arm,psci-0.2";
> >> ??????????????????method = "smc";
> >> ?@@ -392,5 +401,36 @@
> >> ??????????????????????????interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> >> ???????????????????????????????????????<GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> >> ??????????????????};
> >> ?+
> >> ?+ apb0_gates: clk at 1f01428 {
> >> ?+ compatible = "allwinner,sun50i-a64-apb0-gates-clk",
> >> ?+ "allwinner,sun4i-a10-gates-clk";
> >> ?+ reg = <0x01f01428 0x4>;
> >> ?+ #clock-cells = <1>;
> >> ?+ clocks = <&apb0>;
> >> ?+ clock-indices = <0>;
> >> ?+ clock-output-names = "apb0_pio";
> >> ?+ };
> >> ?+
> >> ?+ apb0_rst: reset at 1f014b0 {
> >> ?+ reg = <0x01f014b0 0x4>;
> >> ?+ compatible = "allwinner,sun6i-a31-clock-reset";
> >> ?+ #reset-cells = <1>;
> >> ?+ };
> >
> > Please make a sunxi-ng driver for those clocks.
> 
> We have no enough materials to make such a CCU driver.
> 
> Clocks in CPUs are usually undocumented, and difficult to
> be collected -- even the clk-sun50iw1.c in BSP do not have
> all clocks in CPUs.

That's unfortunate, but we can deal with that by simply extending the
clocks we have. Nothing too complicated or unconvenient to deal with.

> We should only make it sunxi-ng until it's fully discovered (all
> functions in CPUs are functional).

No, I expect that by 4.12 we have converted every users to sunxi-ng,
PRCM included.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/28b32f08/attachment.sig>
