From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Tue, 4 Nov 2014 22:08:27 +0100
Subject: [RFC Patch 1/4] mfd: AXP20x: Add power supply bindings
 documentation
In-Reply-To: <20141104143117.GC26729@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home> <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
 <20141021191905.GR21108@lukather>
 <20141103210244.1425e0c7@neptune.home>
 <20141104143117.GC26729@lukather>
Message-ID: <20141104220827.773c53d0@neptune.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, 04 November 2014 Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> On Mon, Nov 03, 2014 at 09:02:44PM +0100, Bruno Pr?mont wrote: 
> > Doing something like this?:
> > 
> > --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > @@ -126,9 +126,11 @@
> >                                 interrupt-controller;
> >                                 #interrupt-cells = <1>;
> >  
> > -                               backup = <3000000 200>;
> > -                               battery.resistance = <100>;
> > -                               battery.capacity = <2000>;
> > +                               x-powers,backup = <3000000 200>;
> 
> I don't really remember what was that property used for. Would it make
> sense to put it into the battery node?

The backup/rtc battery is completely distinct from main battery.

It's presence is in no way related to that of the main battery,
thus I would not put it into the same node.
As all the information needed is included in the property I see
no reason to move it into a separate node.

> > +                               battery: battery at 0 {
> > +                                       x-powers,resistance = <100>;
> > +                                       x-powers,capacity = <2000>;
> > +                               };
> >                         };
> >                 };
> > 
> > What are the rules to define the label after the colon?
> > Looking at the existing nodes it's either some address or a number...
> 
> It's not called the label, but the node name, and it's defined in the
> ePAPR.
> 
> It's <device-class>[@<address>]
> 
> The address being something to identify the node on a bus, so it can
> be a chip select number, a memory address, an i2c address,
> etc. there's really no absolute answer here.
> 
> I don't think you really need one in this case.

In that case, I better omit it completely.

> > and then the following in driver code (also adjusting the other
> > property names accessed)?:
> > 
> > @@ -678,11 +677,11 @@ static int axp20x_battery_config(struct platform_device *pdev,
> >         if (ret)
> >                 return ret;
> >  
> > -       np = of_node_get(axp20x->dev->of_node);
> > +       np = of_find_node_by_name(axp20x->dev->of_node, "battery");
> >         if (!np)
> >                 return -ENODEV;
> >  
> > -       ret = of_property_read_u32_array(np, "battery.ocv", ocv, 16);
> > +       ret = of_property_read_u32_array(np, "x-powers,ocv", ocv, 16);
> >         for (i = 0; ret == 0 && i < ARRAY_SIZE(ocv); i++)
> >                 if (ocv[i] > 100) {
> >                         dev_warn(&pdev->dev, "OCV[%d] %u > 100\n", i, ocv[i]);
> 
> Yep, it looks sensible.

Thanks,
Bruno
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 648 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141104/f588a7ca/attachment-0001.sig>
