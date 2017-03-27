From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Mar 2017 15:47:19 +0200
Subject: [PATCH v2 1/5] dt-bindings: update device tree binding for
 Allwinner PRCM CCUs
In-Reply-To: <20170327091147.6B24A7C19A5@relay.mailchannels.net>
References: <20170327091147.6B24A7C19A5@relay.mailchannels.net>
Message-ID: <20170327134719.g6l3hzbba6cxkhb7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 05:11:29PM +0800, Icenowy Zheng wrote:
> 
> 2017?3?26? 21:10? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Thu, Mar 23, 2017 at 07:17:03AM +0800, Icenowy Zheng wrote: 
> > > 
> > > 
> > > 23.03.2017, 04:09, "Maxime Ripard" <maxime.ripard@free-electrons.com>: 
> > > > On Wed, Mar 22, 2017 at 02:22:22AM +0800, Icenowy Zheng wrote: 
> > > >> ?21.03.2017, 15:41, "Maxime Ripard" <maxime.ripard@free-electrons.com>: 
> > > >> ?> On Thu, Mar 16, 2017 at 01:28:04AM +0800, Icenowy Zheng wrote: 
> > > >> ?>> ?Many Allwinner SoCs after A31 have a CCU in PRCM block. 
> > > >> ?>> 
> > > >> ?>> ?Give the ones on H3 and A64 compatible strings. 
> > > >> ?>> 
> > > >> ?>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> > > >> ?>> ?--- 
> > > >> ?>> ?Changes in v2: 
> > > >> ?>> ?- Add iosc for R_CCU's on H3/A64. (A31, A23 and A33 seem to have different 
> > > >> ?>> ???clock for mux 3 of ar100 clk. Investgations are needed for them.) 
> > > >> ?>> 
> > > >> ?>> ??Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 18 +++++++++++++++++- 
> > > >> ?>> ??1 file changed, 17 insertions(+), 1 deletion(-) 
> > > >> ?>> 
> > > >> ?>> ?diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt 
> > > >> ?>> ?index 68512aa398a9..4a4addff595d 100644 
> > > >> ?>> ?--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt 
> > > >> ?>> ?+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt 
> > > >> ?>> ?@@ -7,9 +7,11 @@ Required properties : 
> > > >> ?>> ??????????????????- "allwinner,sun8i-a23-ccu" 
> > > >> ?>> ??????????????????- "allwinner,sun8i-a33-ccu" 
> > > >> ?>> ??????????????????- "allwinner,sun8i-h3-ccu" 
> > > >> ?>> ?+ - "allwinner,sun8i-h3-r-ccu" 
> > > >> ?>> ??????????????????- "allwinner,sun8i-v3s-ccu" 
> > > >> ?>> ??????????????????- "allwinner,sun9i-a80-ccu" 
> > > >> ?>> ??????????????????- "allwinner,sun50i-a64-ccu" 
> > > >> ?>> ?+ - "allwinner,sun50i-a64-r-ccu" 
> > > >> ?>> ??????????????????- "allwinner,sun50i-h5-ccu" 
> > > >> ?>> 
> > > >> ?>> ??- reg: Must contain the registers base address and length 
> > > >> ?>> ?@@ -20,7 +22,11 @@ Required properties : 
> > > >> ?>> ??- #clock-cells : must contain 1 
> > > >> ?>> ??- #reset-cells : must contain 1 
> > > >> ?>> 
> > > >> ?>> ?-Example: 
> > > >> ?>> ?+For the PRCM CCUs on H3/A64, one more clock is needed: 
> > > >> ?>> ?+- "iosc": another frequency oscillator used for CPUS (usually at 32000Hz, 
> > > >> ?>> ?+ not the same with losc) 
> > > >> ?> 
> > > >> ?> This is called the internal oscillator in the datasheet, it would 
> > > >> ?> probably make more sense to call it that way in the documentation too. 
> > > >> ?> 
> > > >> ?> This oscillator seems to be clocked at 16MHz, so we should represent 
> > > >> ?> it as such. 
> > > >> ?> 
> > > >> ?> And I'm wondering, are you *sure* that it's fed directly from the 
> > > >> ?> internal oscillator, or goes through the registers in the RTC, with 
> > > >> ?> the 32 divider and 16 prescaler by default that makes it at roughly 
> > > >> ?> the same rate (31.25kHz). 
> > > >> 
> > > >> ?In fact I know nothing about it -- I only represented the code in BSP 
> > > >> ?clock driver. 
> > > >> 
> > > >> ?The mux value 3 varies from SoC to SoC. For A64/H5 it's 32000, 
> > > >> ?for A33 it's 667000 (seems to be directly the internal OSC, as the 
> > > >> ?user manual says the internal OSC is 600~700kHz; but it's named 
> > > >> ?cpuosc rather than iosc in A33 BSP clock driver); for A80 it's even 
> > > >> ?PLL_AUDIO. 
> > > > 
> > > > Where are you getting those info from? 
> > > > 
> > > > As far as I know, the A33 PRCM takes the hosc, losc, pll6 and CPU 
> > > > (internal) oscillator: 
> > > > https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/clk/sunxi/clk-sun8iw5.c#L508 
> > > > 
> > > > The H3 takes the hosc and losc: 
> > > > https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/clk/sunxi/clk-sun8iw7.c#L379 
> > > > 
> > > > The A80 takes the hosc and losc: 
> > > > https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/clk/sunxi/clk-sun9iw1.c#L281 
> > > > 
> > > > The A64 takes the hosc, losc, pll-periph0 and the iosc, which indeed 
> > > > seems to be fed from the internal oscillator with the divider in the 
> > > > RTC: 
> > > > https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65-bsp2.0/arch/arm64/boot/dts/sun50iw1p1-clk.dtsi#L19 
> > > > https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65-bsp2.0/drivers/clk/sunxi/clk-sun50iw1.c#L603 
> > > 
> > > But then in sunxi_init_clocks function, the iosc clock is initialized 
> > > as a fixed clock with 32000Hz. 
> > > 
> > > The clock node in BSP device tree have a compatible of 
> > > allwinner,fixed-clock, but not fixed-clock, which makes it not able 
> > > to be really probed. 
> >
> > That clock is registered: 
> > https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65-bsp2.0/drivers/clk/sunxi/clk-sun50iw1.c#L1193 
> >
> 
> Oh yes, but conflicts exist between the iosc registered in
> clk-sun50iw1.c and described in sun50iw1p1-clk.dtsi . The former is
> 32000, and the latter is 16000000.

No, it is 16MHz / 32 / 16 = 31.25 kHz 

> What should we do then?
> 
> (Maybe it will be better to temporarily ignore this mux, as it's
> difficult to finally find out this correct mux...)

That is not an option, we will not be able to fix it afterwards.

What we should do is getting an actual idea of what's going on, and
not just hacking something together hoping it will work.

You can start by figuring out how the Allwinner clock driver actually
works and / or by trying the various muxing options with something you
can measure the frequency with. The i2c or uart coupled with a scope
or logical analyzer would be a great fit for that.

Using the PRCM timer is another option and you can measure the
frequency it counts at.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/bd44f753/attachment-0001.sig>
