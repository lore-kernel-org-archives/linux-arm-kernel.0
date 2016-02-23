From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Feb 2016 10:45:13 -0800
Subject: [PATCH 10/11] arm64: dts: add Allwinner A64 SoC .dtsi
In-Reply-To: <56B8630B.8060608@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-11-git-send-email-andre.przywara@arm.com>
 <20160205085026.GA1139@lukather> <56B8630B.8060608@arm.com>
Message-ID: <20160223184513.GI19169@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the late reply,

On Mon, Feb 08, 2016 at 09:42:35AM +0000, Andre Przywara wrote:
> >> +	memory {
> >> +		device_type = "memory";
> >> +		reg = <0x40000000 0>;
> >> +	};
> > 
> > I'm guessing u-boot fixes that, can we just remove it entirely?
> 
> Don't know, can we? I found it nice to have it in here to give people at
> the least the idea of where DRAM starts and also making it clear that a
> bootloader is expected to patch this (and having a node already makes
> patching easier).

Well, U-Boot seems to deal with it just fine. The only SoCs where we
do it are SoCs where had to use the Allwinner bootloader.

I guess I don't really care, but if it's to indicate where the RAM is
mapped, we'd be better off by putting the max memory size there
instead of 0, and a comment saying that the bootloader is supposed to
patch this node.

> >> +	timer {
> >> +		compatible = "arm,armv8-timer";
> >> +		interrupts = <GIC_PPI 13
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> >> +			     <GIC_PPI 14
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> >> +			     <GIC_PPI 11
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> >> +			     <GIC_PPI 10
> >> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> >> +	};
> >> +
> >> +	clocks {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <1>;
> >> +		ranges;
> >> +
> >> +		osc24M: osc24M_clk {
> >> +			#clock-cells = <0>;
> >> +			compatible = "fixed-clock";
> >> +			clock-frequency = <24000000>;
> >> +			clock-output-names = "osc24M";
> >> +		};
> >> +
> >> +		osc32k: osc32k_clk {
> >> +			#clock-cells = <0>;
> >> +			compatible = "fixed-clock";
> >> +			clock-frequency = <32768>;
> >> +			clock-output-names = "osc32k";
> >> +		};
> >> +
> >> +		pll1: clk at 01c20000 {
> >> +			#clock-cells = <0>;
> >> +			compatible = "allwinner,sun8i-a23-pll1-clk";
> >> +			reg = <0x01c20000 0x4>;
> >> +			clocks = <&osc24M>;
> >> +			clock-output-names = "pll1";
> >> +		};
> >> +
> >> +		pll6: clk at 01c20028 {
> >> +			#clock-cells = <1>;
> >> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> >> +			reg = <0x01c20028 0x4>;
> >> +			clocks = <&osc24M>;
> >> +			clock-output-names = "pll6", "pll6x2";
> > 
> > The output names have changed, and it doesn't take an argument
> > anymore.
> 
> Would be happy to adapt to this, but we should sort this approach out
> (see the other mail).

Yeah.

> 
> >> +		};
> >> +
> >> +		pll6d2: pll6d2_clk {
> >> +			#clock-cells = <0>;
> >> +			compatible = "fixed-factor-clock";
> >> +			clock-div = <2>;
> >> +			clock-mult = <1>;
> >> +			clocks = <&pll6 0>;
> >> +			clock-output-names = "pll6d2";
> >> +		};
> >> +
> >> +		/* dummy clock until pll6 can be reused */
> >> +		pll8: pll8_clk {
> >> +			#clock-cells = <0>;
> >> +			compatible = "fixed-clock";
> >> +			clock-frequency = <1>;
> >> +			clock-output-names = "pll8";
> >> +		};
> >> +
> >> +		cpu: cpu_clk at 01c20050 {
> >> +			#clock-cells = <0>;
> >> +			compatible = "allwinner,sun4i-a10-cpu-clk";
> >> +			reg = <0x01c20050 0x4>;
> >> +			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
> >> +			clock-output-names = "cpu";
> >> +			critical-clocks = <0>;
> >> +		};
> >> +
> >> +		axi: axi_clk at 01c20050 {
> >> +			#clock-cells = <0>;
> >> +			compatible = "allwinner,sun4i-a10-axi-clk";
> >> +			reg = <0x01c20050 0x4>;
> >> +			clocks = <&cpu>;
> >> +			clock-output-names = "axi";
> >> +		};
> >> +
> >> +		ahb1: ahb1_clk at 01c20054 {
> >> +			#clock-cells = <0>;
> >> +			compatible = "allwinner,sun6i-a31-ahb1-clk";
> >> +			reg = <0x01c20054 0x4>;
> >> +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
> >> +			clock-output-names = "ahb1";
> >> +		};
> >> +
> >> +		ahb2: ahb2_clk at 01c2005c {
> >> +			#clock-cells = <0>;
> >> +			compatible = "allwinner,sun8i-h3-ahb2-clk";
> >> +			reg = <0x01c2005c 0x4>;
> >> +			clocks = <&ahb1>, <&pll6d2>;
> >> +			clock-output-names = "ahb2";
> >> +		};
> >> +
> >> +		apb1: apb1_clk at 01c20054 {
> >> +			#clock-cells = <0>;
> >> +			compatible = "allwinner,sun4i-a10-apb0-clk";
> >> +			reg = <0x01c20054 0x4>;
> >> +			clocks = <&ahb1>;
> >> +			clock-output-names = "apb1";
> >> +		};
> >> +
> >> +		apb2: apb2_clk at 01c20058 {
> >> +			#clock-cells = <0>;
> >> +			compatible = "allwinner,sun4i-a10-apb1-clk";
> >> +			reg = <0x01c20058 0x4>;
> >> +			clocks = <&osc32k>, <&osc24M>, <&pll6 1>, <&pll6 1>;
> >> +			clock-output-names = "apb2";
> >> +		};
> >> +
> >> +		bus_gates: clk at 01c20060 {
> >> +			#clock-cells = <1>;
> >> +			compatible = "allwinner,a64-bus-gates-clk",
> >> +				     "allwinner,sunxi-multi-bus-gates-clk";
> >> +			reg = <0x01c20060 0x14>;
> >> +			ahb1_parent {
> >> +				clocks = <&ahb1>;
> >> +				clock-indices = <1>, <5>,
> >> +						<6>, <8>,
> >> +						<9>, <10>,
> >> +						<13>, <14>,
> >> +						<18>, <19>,
> >> +						<20>, <21>,
> >> +						<23>, <24>,
> >> +						<25>, <28>,
> >> +						<32>, <35>,
> >> +						<36>, <37>,
> >> +						<40>, <43>,
> >> +						<44>, <52>,
> >> +						<53>, <54>,
> >> +						<135>;
> >> +				clock-output-names = "bus_mipidsi", "bus_ce",
> >> +						"bus_dma", "bus_mmc0",
> >> +						"bus_mmc1", "bus_mmc2",
> >> +						"bus_nand", "bus_sdram",
> >> +						"bus_ts", "bus_hstimer",
> >> +						"bus_spi0", "bus_spi1",
> >> +						"bus_otg", "bus_otg_ehci0",
> >> +						"bus_ehci0", "bus_otg_ohci0",
> >> +						"bus_ve", "bus_lcd0",
> >> +						"bus_lcd1", "bus_deint",
> >> +						"bus_csi", "bus_hdmi",
> >> +						"bus_de", "bus_gpu",
> >> +						"bus_msgbox", "bus_spinlock",
> >> +						"bus_dbg";
> >> +			};
> >> +			ahb2_parent {
> >> +				clocks = <&ahb2>;
> >> +				clock-indices = <17>, <29>;
> >> +				clock-output-names = "bus_gmac", "bus_ohci0";
> >> +			};
> >> +			apb1_parent {
> >> +				clocks = <&apb1>;
> >> +				clock-indices = <64>, <65>,
> >> +						<69>, <72>,
> >> +						<76>, <77>,
> >> +						<78>;
> >> +				clock-output-names = "bus_codec", "bus_spdif",
> >> +						"bus_pio", "bus_ths",
> >> +						"bus_i2s0", "bus_i2s1",
> >> +						"bus_i2s2";
> >> +			};
> >> +			abp2_parent {
> >> +				clocks = <&apb2>;
> >> +				clock-indices = <96>, <97>,
> >> +						<98>, <101>,
> >> +						<112>, <113>,
> >> +						<114>, <115>,
> >> +						<116>;
> >> +				clock-output-names = "bus_i2c0", "bus_i2c1",
> >> +						"bus_i2c2", "bus_scr",
> >> +						"bus_uart0", "bus_uart1",
> >> +						"bus_uart2", "bus_uart3",
> >> +						"bus_uart4";
> >> +			};
> >> +		};
> > 
> > As I've already told you I'm not really fond of this one, for two main
> > topics.
> > 
> > The first one is about the DT bindings itself which is quite exotic,
> > especially the fact that you define clocks using clocks, clock-indices
> > and clock-output-names in nodes that are not the one referred to by
> > consumer, which goes against both the clock bindings documentation and
> > the usage.
> 
> You are right in one point: it is not documented. I just see that I
> forgot to update the bindings doc and describe this behaviour there.
> 
> But I don't see an issue with abstracting the clock provider's internal
> details by referring to the parent node and use the DT's natural tree
> structure to properly represent these clock gates. I cannot read
> anything in clock-bindings.txt that would prevent this.
> 
> Happy to hear from DT maintainers about it.
> 
> > The second one is pretty much the same one than for the discussion we
> > had about pinctrl. There is SoCs where we simply don't have that
> > information, or at least are not really sure about what to put where
> > (namely, the A83t). In such a case, we would knowingly put invalid
> > information in the DT, which is already quite bad in itself.
> 
> And in your case we would put knowingly invalid information into the kernel?
> So what is wrong with just _not_ putting this information until we know
> it? With my patch you would just enumerate the gates we know the parents
> of so far.

And what happens when you simply don't have that information?

> Once we learn about the other gates, we add them. If we don't
> know the parent, we probably can't use it anyway, I guess.
> So we do as we do with other new features: updated DTs provide new
> functionality.

The issue is broader than that. It basically boils down to that: What
is your fixing strategy in case one of the clocks you put there
doesn't belong to the right parent?

> And also: this is about A64, not A83t.

If the driver is generic, it should not be just about the A64,
otherwise it's simply not generic.

> > The worst part is, when we will identify issues and fix them
> > (hopefully), there will be no way to fix the current DT users.
> 
> But if we have a broken DT out there where a feature never worked or had
> bugs, we _can_ fix it. Interested users will upgrade their DT and are
> able to use the new feature or run without bugs now. This mimics the
> approach when we add features: users update. However if users are happy
> with the current feature set or are not affected by the bug, they can
> use the older DT.

So basically, you just tell "if you want to be as bug free and
featureful as possible, always keep your DT as up to date as
possible". Isn't that the exact same situation than before that whole
DT ABI debate?

> Also from my point of view it is much harder to provide an updated
> kernel to people, since every distribution would need to pick up the
> changes and provide updates to their users.

Do you know a single linux distribution that doesn't update the kernel
to the latest stable kernel version?

> 
> > And it just became a pain to maintain in the long run.
> 
> How so?
> 
> > On the opposite side, having something like the H3 bus gates driver
> > address all these concerns and is easily extensible, which is why we
> > ended up merging it.
> 
> Speaking of this driver: I really dislike that it hardcodes Soc specific
> information into the kernel. I consider this bad style. The clock gates
> are a rather generic functionality (one bit per gate), and we provide
> the SoC specific part (mapping names and bit numbers) already in the DT.
> So with the parent relation in the code we hide some information from
> the DT which clearly belongs there, also ending up with having something
> in the kernel and something in the DT.

It's true to some extent, but it's also something that is not critical
in any way: a typo'd name or a missing index will not affect the
system in any way. A wrong parent relationship might completely crash
the system if the actual parent is not enabled and you try to access
the device.

> Also this requires to add support for each and every SoC explicitly in
> the kernel.

Which is something that you already have to do for any other drivers.

> Also please keep in mind that the DT is not just for Linux: why should
> other OS developers hard code the same information over and over again
> when we could have it once for everybody in the DT?

Since the "other OS developers" don't care about our bindings anyway and
make up their own, is that really something we should care about?

> I think we should stop with supporting each and every SoC explicitly in
> the kernel and go for more generic drivers, that use DTs to describe
> each SoC.
> That way we can eventually reach the point where we have (at least)
> basic functionality for a new SoC in existing(!) kernels - like from a
> LTS style distribution kernel.

It's an argument that has been used since basically the switch to the
device tree, and it never happened, because there's basically no such
thing as a generic driver.

Let's take the example of the A64: we had a driver that was common to
all the SoCs so far for the MMC and MMC clocks, which was working fine
for all of them, so I guess it would be elligible to your definition
of generic. Comes the A64, with its modified phase behaviour, and a
MMC clock factor. Is it really something you expect to support without
a single change to the MMC driver and clocks driver?

This also goes against the whole policy of the clock framework for the
past couple of years to put less information in the DT. Mike asked
repeatedly to switch to a single clock controller node, and have a
driver that is registering everything, instead of exposing each and
every clock in the DT.

It's something we never took the time to do because we knew that we
could switch to it at any point in time. If you want to really have a
stable DT for the A64, then please use that scheme so that we never
have to switch to it in the future and break the ABI.

> New SoCs would just come with their DTs as part of their firmware, as
> it's the case with many arm64 boards out there at the moment. As long as
> they don't have fundamentally new IP blocks (for the basic
> functionality), that could just work out of the box.

Who would provide that firmware? The vendor? Whose binding were never
ever reviewed?

> >> +		pio: pinctrl at 01c20800 {
> >> +			compatible = "allwinner,a64-pinctrl";
> >> +			reg = <0x01c20800 0x400>;
> >> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> >> +			clocks = <&bus_gates 69>;
> >> +			gpio-controller;
> >> +			#gpio-cells = <3>;
> >> +			interrupt-controller;
> >> +			#interrupt-cells = <2>;
> >> +
> >> +			uart0_pins_a: uart0 at 0 {
> >> +				allwinner,pins = "PB8", "PB9";
> >> +				allwinner,function = "uart0";
> >> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +			};
> >> +
> >> +			uart0_pins_b: uart0 at 1 {
> >> +				allwinner,pins = "PF2", "PF3";
> >> +				allwinner,function = "uart0";
> >> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +			};
> >> +
> >> +			uart1_pins: uart1 at 0 {
> >> +				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
> >> +				allwinner,function = "uart1";
> >> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +			};
> >> +
> >> +			uart2_pins: uart2 at 0 {
> >> +				allwinner,pins = "PB0", "PB1", "PB2", "PB3";
> >> +				allwinner,function = "uart2";
> >> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +			};
> >> +
> >> +			uart3_pins_a: uart3 at 0 {
> >> +				allwinner,pins = "PD0", "PD1";
> >> +				allwinner,function = "uart3";
> >> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +			};
> >> +
> >> +			uart3_pins_b: uart3 at 1 {
> >> +				allwinner,pins = "PH4", "PH5", "PH6", "PH7";
> >> +				allwinner,function = "uart3";
> >> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +			};
> > 
> > You have several options for all these controllers, which is why we
> > have the _a or _b suffices.
> > 
> > Usually, the uart pins we had were only using RX and TX, I guess you
> > could add a separate node for the RTS / CTS pins if some board want to
> > use them.
> 
> Makes sense. Do you want the RTS/CTS pins in a separate child node or
> another variant (like uart3_pins_b_hwhs) with all four pins in addition
> to the two-pin version?

I think we can have RTS/CTS alone in a separate node, just like we
already do for the SPI and its chip select, where each board can then
pick the combination it uses, without duplicating pins definitions.

Thanks (and sorry again for the slow answer),
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160223/8cdfca44/attachment-0001.sig>
