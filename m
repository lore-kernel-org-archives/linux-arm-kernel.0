From: mirq-linux@rere.qmqm.pl (=?iso-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 4 Oct 2017 23:20:34 +0200
Subject: [PATCH 2/2] arm: AT91: fix DT duplicate node name
In-Reply-To: <e5868359-8708-3d17-df8c-b04ad3624df0@microchip.com>
References: <cover.1504037038.git.mirq-linux@rere.qmqm.pl>
 <910fee2eb99b2d95e59fa6b997645b498f167022.1504037038.git.mirq-linux@rere.qmqm.pl>
 <e5868359-8708-3d17-df8c-b04ad3624df0@microchip.com>
Message-ID: <20171004212034.6znvbdfe2wbd7uvh@qmqm.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 06:53:30PM +0200, Nicolas Ferre wrote:
> On 29/08/2017 at 22:08, Micha? Miros?aw wrote:
> > Fix following warning at bootup:
> > 
> > device-tree: Duplicate name in fb at 0x00500000, renamed to "display#1"
> > 
> > Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  arch/arm/boot/dts/at91sam9m10g45ek.dts | 48 +++++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> > index 9cf1f5163fbd..272af5867403 100644
> > --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> > +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> > @@ -223,30 +223,6 @@
> >  		fb0: fb at 0x00500000 {
> >  			display = <&display0>;
> >  			status = "okay";
> > -
> > -			display0: display {
> 
> Micha?, thanks for your patch.
> 
> Actually the DT binding requires this:
> Documentation/devicetree/bindings/video/atmel,lcdc.txt
> 
> So it's somehow a bigger issue.
> Moreover, several boards have exactly the same arrangement than the
> at91sam9m10g45ek, so you probably need to modify them all at the same time.
> 
> After a brief look at drivers/video/fbdev/atmel_lcdfb.c it seems that
> the name of the node is not so much important, so we can modify it
> (something like display0: lcd-display {}) .
> 
> I suggest that you modify the binding, the board files affected and
> re-submit a patch.

It looks like the binding documentation is wrong. The driver code does

	of_parse_phandle(np, "display", 0);

so it expects a phandle, not a node.

Best Regards,
Micha? Miros?aw
