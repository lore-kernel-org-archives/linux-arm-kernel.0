From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 27 Nov 2018 11:06:09 +0100
Subject: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
In-Reply-To: <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com>
 <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
 <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
Message-ID: <1543313169.2507.39.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Am Montag, den 26.11.2018, 10:24 -0800 schrieb Andrey Smirnov:
> On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > 
> > On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> > > @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > -?????case IMX7D:
> > > +?????case IMX8MQ:
> > > +?????????????if (of_property_read_u32(node, "fsl,iomux-gpr1x",
> > > +??????????????????????????????????????&imx6_pcie->gpr1x)) {
> > > +?????????????????????dev_err(dev, "Failed to get GPR1x address\n");
> > > +?????????????????????return -EINVAL;
> > > +?????????????}
> > 
> > This is for distinguishing multiple controllers on the SOC but other
> > registers and bits might differ. Isn't it preferable to have a property
> > for controller id instead of adding many registers to DT?
> > 
> 
> I liked encoding necessary info in DT directly slightly better than
> encoding abstract ID and then decoding it further in the driver code.
> OTOH, I am not really attached to that path. Lucas, can you comment on
> this please?

Yes, after rereading the patch with this in mind I agree that having
the GPR offset on DT directly is IMO the better approach than an
abstract ID.

One other thing I noticed is that we probably need some property to
encode if the clock is supplied by an external clkgen, or if the clock
is provided by the i.MX. Hardcoding this in the driver will lead to DT
backward compatibility headaches later on if someone decides to build a
board with the clock provided from the i.MX.

Regards,
Lucas
