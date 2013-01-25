From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Jan 2013 13:11:21 +0200
Subject: [PATCH v4 1/4] drivers: usb: phy: add a new driver for usb part
 of control module
In-Reply-To: <20130125110141.GK3075@e106331-lin.cambridge.arm.com>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-2-git-send-email-kishon@ti.com>
 <20130125110141.GK3075@e106331-lin.cambridge.arm.com>
Message-ID: <20130125111120.GP15886@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 11:01:41AM +0000, Mark Rutland wrote:
> On Fri, Jan 25, 2013 at 10:23:57AM +0000, Kishon Vijay Abraham I wrote:
> > Added a new driver for the usb part of control module. This has an API
> > to power on the USB2 phy and an API to write to the mailbox depending on
> > whether MUSB has to act in host mode or in device mode.
> > 
> > Writing to control module registers for doing the above task which was
> > previously done in omap glue and in omap-usb2 phy will be removed.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  Documentation/devicetree/bindings/usb/omap-usb.txt |   30 +-
> >  Documentation/devicetree/bindings/usb/usb-phy.txt  |    5 +
> >  drivers/usb/phy/Kconfig                            |   10 +
> >  drivers/usb/phy/Makefile                           |    1 +
> >  drivers/usb/phy/omap-control-usb.c                 |  295 ++++++++++++++++++++
> >  include/linux/usb/omap_control_usb.h               |   92 ++++++
> >  6 files changed, 432 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/usb/phy/omap-control-usb.c
> >  create mode 100644 include/linux/usb/omap_control_usb.h
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> > index 29a043e..2d8c6c4 100644
> > --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> > +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> > @@ -1,4 +1,4 @@
> > -OMAP GLUE
> > +OMAP GLUE AND OTHER OMAP SPECIFIC COMPONENTS
> > 
> >  OMAP MUSB GLUE
> >   - compatible : Should be "ti,omap4-musb" or "ti,omap3-musb"
> > @@ -16,6 +16,10 @@ OMAP MUSB GLUE
> >   - power : Should be "50". This signifies the controller can supply upto
> >     100mA when operating in host mode.
> > 
> > +Optional properties:
> > + - ctrl-module : phandle of the control module this glue uses to write to
> > +   mailbox
> > +
> >  SOC specific device node entry
> >  usb_otg_hs: usb_otg_hs at 4a0ab000 {
> >         compatible = "ti,omap4-musb";
> > @@ -23,6 +27,7 @@ usb_otg_hs: usb_otg_hs at 4a0ab000 {
> >         multipoint = <1>;
> >         num_eps = <16>;
> >         ram_bits = <12>;
> > +       ctrl-module = <&omap_control_usb>;
> >  };
> > 
> >  Board specific device node entry
> > @@ -31,3 +36,26 @@ Board specific device node entry
> >         mode = <3>;
> >         power = <50>;
> >  };
> > +
> > +OMAP CONTROL USB
> > +
> > +Required properties:
> > + - compatible: Should be "ti,omap-control-usb"
> > + - reg : Address and length of the register set for the device. It contains
> > +   the address of "control_dev_conf" and "otghs_control" or "phy_power_usb"
> 
> Could you not use '-' over '_' here?

that's part of omap hwmod.

> > +   depending upon omap4 or omap5.
> > + - reg-names: The names of the register addresses corresponding to the registers
> > +   filled in "reg".
> > + - ti,type: This is used to differentiate whether the control module has
> > +   usb mailbox or usb3 phy power. omap4 has usb mailbox in control module to
> > +   notify events to the musb core and omap5 has usb3 phy power register to
> > +   power on usb3 phy. Should be "1" if it has mailbox and "2" if it has usb3
> > +   phy power.
> 
> Why not make this a string property, perhaps values "mailbox" or "register"?

NAK.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130125/801829f3/attachment.sig>
