From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Apr 2017 09:17:46 +0200
Subject: [linux-sunxi] Re: [PATCH v3 02/12] arm64: allwinner: a64: add
 NMI controller on A64
In-Reply-To: <18ae853e9ce59a83bdeb6b64f96caee0@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-3-icenowy@aosc.io>
 <20170418070016.qsng3qtk76bqxyc5@lukather>
 <FB3B3C68-EB16-4352-B0B9-64857B1A6C03@aosc.io>
 <20170420055802.btibui5pspan4qal@lukather>
 <18ae853e9ce59a83bdeb6b64f96caee0@aosc.io>
Message-ID: <20170424071746.u2lrk43kmvvd7m25@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 03:03:38PM +0800, icenowy at aosc.io wrote:
> ? 2017-04-20 13:58?Maxime Ripard ???
> > On Tue, Apr 18, 2017 at 06:56:43PM +0800, Icenowy Zheng wrote:
> > > 
> > > 
> > > ? 2017?4?18? GMT+08:00 ??3:00:16, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> ??:
> > > >On Mon, Apr 17, 2017 at 07:57:37PM +0800, Icenowy Zheng wrote:
> > > >> Allwinner A64 SoC features a NMI controller, which is usually
> > > >connected
> > > >> to the AXP PMIC.
> > > >>
> > > >> Add support for it.
> > > >>
> > > >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > >> Acked-by: Chen-Yu Tsai <wens@csie.org>
> > > >> ---
> > > >> Changes in v2:
> > > >> - Added Chen-Yu's ACK.
> > > >>
> > > >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
> > > >>  1 file changed, 8 insertions(+)
> > > >>
> > > >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > >b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > >> index 05ec9fc5e81f..53c18ca372ea 100644
> > > >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > >> @@ -403,6 +403,14 @@
> > > >>  				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> > > >>  		};
> > > >>
> > > >> +		nmi_intc: interrupt-controller at 01f00c0c {
> > > >> +			compatible = "allwinner,sun6i-a31-sc-nmi";
> > > >> +			interrupt-controller;
> > > >> +			#interrupt-cells = <2>;
> > > >> +			reg = <0x01f00c0c 0x38>;
> > > >
> > > >The base address is not correct, and there's uncertainty on whether
> > > >this is this particular controller or not. Did you even test this?
> > > 
> > > Tested by axp20x-pek.
> > 
> > Still, the base address is wrong, which is yet another hint that this
> > is not the same interrupt controller, and just works by accident.
> 
> No, it's the same as other post-sun6i device trees.
> See other post-sun6i device trees: (or maybe they're all wrong, but
> as we have no document for it, we should temporarily keep them)
> 
> sun6i-a31.dtsi
> ```
> 		nmi_intc: interrupt-controller at 01f00c0c {
> 			compatible = "allwinner,sun6i-a31-sc-nmi";
> 			interrupt-controller;
> 			#interrupt-cells = <2>;
> 			reg = <0x01f00c0c 0x38>;
> 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> 		};
> ```
> 
> sun8i-a23-a33.dtsi
> ```
> 		nmi_intc: interrupt-controller at 01f00c0c {
> 			compatible = "allwinner,sun6i-a31-sc-nmi";
> 			interrupt-controller;
> 			#interrupt-cells = <2>;
> 			reg = <0x01f00c0c 0x38>;
> 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> 		};
> ```
> 
> But according to the BSP device tree, the base address should be
> 0x01f00c00. Should I send some patch to fix all of them? (but it will
> break device tree compatibility)

I'm really not a big fan of "if we see something that is broken, just
let it rot" to be honest.

We have no idea how this controller works exactly, just like we have
no idea if it is exactly the same controller or not.

The only thing we have today is the memory map, and it tells us that
it has more registers than what you express here.

Because of the DT backward compatibility, you have to think of it the
other way around: what will happen if it turns out we need to setup
any register outside of that region you described in the DT, in
something like a year or so?

We can't, really. While if you have the full memory region from the
beginning, then you just have to add a single writel in your driver.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170424/2744d763/attachment.sig>
