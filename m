From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sat, 1 Apr 2017 10:09:36 +0200
Subject: [PATCH] ARM: dts: armada-38x: label USB and SATA nodes
In-Reply-To: <20170331182111.GJ22609@lunn.ch>
References: <20170331074115.8111-1-ralph.sennhauser@gmail.com>
 <20170331165015.GJ12814@lunn.ch>
 <20170331193920.030d9ca8@gmail.com>
 <20170331182111.GJ22609@lunn.ch>
Message-ID: <20170401100936.57f45dd1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Mar 2017 20:21:11 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Mar 31, 2017 at 07:39:20PM +0200, Ralph Sennhauser wrote:
> > On Fri, 31 Mar 2017 18:50:15 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >   
> > > > -			sata at a8000 {
> > > > +			satac0: sata at a8000 {    
> > > 
> > > Hi Ralph
> > > 
> > > Why the c in satac0?  
> > 
> > For controller and to not conflict with a use case of sata0 for a
> > port, similarly to pciec and pcie1. See
> > armada-385-synology-ds116.dts.  
> 
> :~/linux/arch/arm/boot/dts$ ls *ds116*
> ls: cannot access '*ds116*': No such file or directory

Ah, not in mainline yet, from linux-next

  commit a58d73340b0ec93fc29a826e45fbbfbc3f81b7eb
  Author: Willy Tarreau <w@1wt.eu>
  Date:   Sun Feb 12 10:30:35 2017 +0100

The arch/arm/boot/dts/armada-388-gp.dts from below was
meant as the example for the conflict I mentioned.

> 
> But anyway, a few boards seem to solve this by calling the controller
> node ahci0: and the port sata0:

That's another option I missed.

  $ git grep -n ahci.:
  arch/arm/boot/dts/spear1310.dtsi:59:            ahci0: ahci at b1000000 {
  arch/arm/boot/dts/spear1310.dtsi:68:            ahci1: ahci at b1800000 {
  arch/arm/boot/dts/spear1310.dtsi:77:            ahci2: ahci at b4000000 {
  arch/arm/boot/dts/spear1340.dtsi:42:            ahci0: ahci at b1000000 {

Not a big list which I have here and the nodes themselves are named
ahci at xxxxxxxx.

> 
> > > > -			usb3 at f0000 {
> > > > +			usb3_0: usb3 at f0000 {
> > > >  				compatible =
> > > > "marvell,armada-380-xhci"; reg = <0xf0000 0x4000>,<0xf4000
> > > > 0x4000>; interrupts = <GIC_SPI 16  
> > > > IRQ_TYPE_LEVEL_HIGH>; @@ -598,7 +598,7 @@  
> > > >  				status = "disabled";
> > > >  			};
> > > >  
> > > > -			usb3 at f8000 {
> > > > +			usb3_1: usb3 at f8000 {
> > > >  				compatible =
> > > > "marvell,armada-380-xhci"; reg = <0xf8000 0x4000>,<0xfc000
> > > > 0x4000>; interrupts = <GIC_SPI 17  
> > > > IRQ_TYPE_LEVEL_HIGH>;    
> > > 
> > > I can understand what you are saying. But does anybody else care?
> > > Are there other .dtsi files differentiating between USB 1.1, 2
> > > and 3?  
> > 
> > It's handled differently where ever I looked, some do some don't. A
> > case for distinguishing USB 2.0 and USB 3.0 like this is
> > armada-388-gp.dts.  
> 
> Humm...
> 
>                         /* CON4 */
>                         usb at 58000 {
>                                 vcc-supply = <&reg_usb2_0_vbus>;
>                                 status = "okay";
>                         };
> 
> 
> 			/* CON5 */
>                         usb3 at f0000 {
>                                 usb-phy = <&usb2_1_phy>;
>                                 status = "okay";
>                         };
> 
>                         /* CON7 */
>                         usb3 at f8000 {
>                                 usb-phy = <&usb3_phy>;
>                                 status = "okay";
>                         };
> 
> Is this clear? Is CON5 a USB 3 host, but has a USB 2 PHY connected to
> it? CON7 is the only true USB 3 port? I think some comments written in
> schwiizerd??tsch would be clearre.:-)

Did you just find a bug? :)

*ufm sprung gxi* (about to head out), sorry for the mix-up. The synology
dts would actually have worked for both usb and sata labels :)

  $git grep -hn -A8 usb3_0_phy: arch/arm/boot/dts/armada-385-synology-ds116.dts
  191:    usb3_0_phy: usb3_0_phy {
  192-            compatible = "usb-nop-xceiv";
  193-            vcc-supply = <&reg_usb3_0_vbus>;
  194-    };
  195-
  196-    usb3_1_phy: usb3_1_phy {
  197-            compatible = "usb-nop-xceiv";
  198-            vcc-supply = <&reg_usb3_1_vbus>;
  199-    };


---

Let's add another argument for and against usb3_x type labels:

  $ git grep -hn usb arch/arm/boot/dts/armada-38x.dtsi
  455:                    usb0: usb at 58000 {
  593:                    usb3_0: usb3 at f0000 {
  601:                    usb3_1: usb3 at f8000 {

They might actually be considered different types. usb vs. usb3, though
that feels quite arbitrary.

  $ git grep -hn usb3_0 Documentation/devicetree/bindings/usb/qcom,dwc3.txt
  45:             usb3_0: usb30 at 0 {

usb3_0 could be mistaken for the protocol version. A bit of a stretch as well ...

First thought was using usb0,usb1,usb2. For the individual linksys
boards this meant a potential pit-fall, namely using "usb2:" for the
only USB 3.0 port while "usb0:" for the only USB 2.0 port appears in the
armada-385-linksys.dtsi only, hence the quest for alternatives.

In the end it boils down to I couldn't make out a definitive standard and
made a pick that felt about right.

If there was an obvious choice there wouldn't have been a reason to omit
the labels this patch handles when handling the bulk. Make the bulk a none
discussion item and handle the corner cases later. Guess that's what
happened here.

Thanks
Ralph
