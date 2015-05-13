From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 May 2015 10:33:28 +0200
Subject: [PATCH 8/8] ARM: mvebu: a38x: Enable A38x XOR engine features
In-Reply-To: <14c9a6d3ba4c46f89880e4c1b4494dbb@IL-EXCH02.marvell.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-9-git-send-email-maxime.ripard@free-electrons.com>
 <20150512161314.GL19927@lunn.ch>
 <14c9a6d3ba4c46f89880e4c1b4494dbb@IL-EXCH02.marvell.com>
Message-ID: <20150513083328.GU10961@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 07:16:34AM +0000, Lior Amsalem wrote:
> > From: Andrew Lunn [mailto:andrew at lunn.ch]
> > Sent: Tuesday, May 12, 2015 7:13 PM
> > 
> > On Tue, May 12, 2015 at 05:37:43PM +0200, Maxime Ripard wrote:
> > > From: Lior Amsalem <alior@marvell.com>
> > >
> > > The new XOR engine has a new compatible of its own, together with new
> > > channel capabilities.
> > >
> > > Use that new compatible now that we have a driver that can handle it.
> > >
> > > Signed-off-by: Lior Amsalem <alior@marvell.com>
> > > Reviewed-by: Ofer Heifetz <oferh@marvell.com>
> > > Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> > > Tested-by: Nadav Haklai <nadavh@marvell.com>
> > > ---
> > >  arch/arm/boot/dts/armada-38x.dtsi | 20 ++++++--------------
> > >  1 file changed, 6 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/armada-38x.dtsi
> > > b/arch/arm/boot/dts/armada-38x.dtsi
> > > index ed2dd8ba4080..6d07b7389415 100644
> > > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > > @@ -448,7 +448,7 @@
> > >  			};
> > >
> > >  			xor at 60800 {
> > > -				compatible = "marvell,orion-xor";
> > > +				compatible = "marvell,a38x-xor";
> > >  				reg = <0x60800 0x100
> > >  				       0x60a00 0x100>;
> > >  				clocks = <&gateclk 22>;
> > > @@ -458,17 +458,13 @@
> > >  					interrupts = <GIC_SPI 22
> > IRQ_TYPE_LEVEL_HIGH>;
> > >  					dmacap,memcpy;
> > >  					dmacap,xor;
> > > -				};
> > > -				xor01 {
> > > -					interrupts = <GIC_SPI 23
> > IRQ_TYPE_LEVEL_HIGH>;
> > > -					dmacap,memcpy;
> > > -					dmacap,xor;
> > > -					dmacap,memset;
> > > +					dmacap,pq;
> > > +					dmacap,interrupt;
> > 
> > Does this mean the hardware only has one channel?
> > And memset is no longer supported?
> > 
> 
> The hardware has two channels per engine and two engines.
> However, both on HW side (both channels are on the same "bus port")
> and SW (the dma subsystem will assign one channel per CPU).
> we found it's better (performance wise) to use only one channel on each engine
> and let the framework assign one per CPU.
> This way, descriptors chaining was better (cause of the depended descriptors
> problem) and overall interrupt number reduced.
> 
> Yes, since memset is a problematic one. It can only be done via registers
> (and not on descriptors level) plus no one really needs it...

And memset support has been removed from dmaengine since 3.11, so it
doesn't look like anyone really needs it :)

We're talking about reintroducing it for some platforms that actually
need it, but it wasn't really used on marvell anyway...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/d4fddb50/attachment-0001.sig>
