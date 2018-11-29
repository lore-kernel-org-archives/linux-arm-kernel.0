From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 29 Nov 2018 12:15:17 +0100
Subject: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
In-Reply-To: <VI1PR04MB5533595EE55A724C7E69F297EED10@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com>
 <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
 <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
 <1543313169.2507.39.camel@pengutronix.de>
 <VI1PR04MB5533DE497786CD80D4FE0941EED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <CAHQ1cqEGABcH3EG9yGo7Ns2fPR1s_u1YPtFoKRjUh50=aa=J2Q@mail.gmail.com>
 <VI1PR04MB5533595EE55A724C7E69F297EED10@VI1PR04MB5533.eurprd04.prod.outlook.com>
Message-ID: <1543490117.2507.61.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 28.11.2018, 10:55 +0000 schrieb Leonard Crestez:
> On 11/27/18 11:15 PM, Andrey Smirnov wrote:
> > On Tue, Nov 27, 2018 at 2:46 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > On 11/27/18 12:06 PM, Lucas Stach wrote:
> > > > Am Montag, den 26.11.2018, 10:24 -0800 schrieb Andrey Smirnov:
> > > > > On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > > > > On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> > > > > > > @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > > > > > -?????case IMX7D:
> > > > > > > +?????case IMX8MQ:
> > > > > > > +?????????????if (of_property_read_u32(node, "fsl,iomux-gpr1x",
> > > > > > > +??????????????????????????????????????&imx6_pcie->gpr1x)) {
> > > > > > > +?????????????????????dev_err(dev, "Failed to get GPR1x address\n");
> > > > > > > +?????????????????????return -EINVAL;
> > > > > > > +?????????????}
> > > > > > 
> > > > > > This is for distinguishing multiple controllers on the SOC but other
> > > > > > registers and bits might differ. Isn't it preferable to have a property
> > > > > > for controller id instead of adding many registers to DT?
> > > > > 
> > > > > I liked encoding necessary info in DT directly slightly better than
> > > > > encoding abstract ID and then decoding it further in the driver code.
> > > > > OTOH, I am not really attached to that path. Lucas, can you comment on
> > > > > this please?
> > > > Yes, after rereading the patch with this in mind I agree that having
> > > > the GPR offset on DT directly is IMO the better approach than an
> > > > abstract ID.
> > > 
> > > But it's not a single offset, for example the device_type (EP/RC) has
> > > bits for the two controllers side-by-side in GPR12.
> > > 
> > 
> > Playing devil's advocate for a bit:
> > 
> > More specifically, currently the following per-controller bits need to
> > be configured:
> > 
> > - Location of the "device type" field within GPR12
> > - GPR register to use to control PCIn_CLKREQ_B_OVERRIDE_EN and
> > PCIn_CLKREQ_B_OVERRIDE_EN (GPR14 vs GPR16)
> > - Now that Philip spoke against PCIE_CTRL_APPS_CLK_REQ being exposed
> > via reset controller driver, we need to know which SRC register to use
> > to control that bit (SRC_PCIEPHY_RCR vs. SRC_PCIE2_RCR)
> 
> I looked a bit through bindings and there some instances of syscon-$BLH?
> properties which include detailed offsets or bitmasks for $BLAH relative?
> to the target syscon node.
> 
> If you're going the route of adding properties points to IOMUXC/SRC bits?
> it would sense to ensure that they're also usable on other SOCs,?
> otherwise you're just making 8mq more complicated. But that's hard.
> 
> But I think it's easier to deal with such SOC-specific details behind a?
> compat string. Maybe the DT list has some opinion on this?

I agree with this. The number of bits and offsets is too large to keep
it in DT properties, without running into backwards compat issues later
on.

> I wonder if of_alias_get_id would be a reasonable way to distinguish?
> between pcie0 and pcie1 instead of adding an ctrl-id property?

No, the alias is a arbitrary number that can change from board to
board. It can, but doesn't need to, correspond to any real hardware ID.
If we need a hardware controller ID, then there is no way around adding
a property to the PCIe controller node for this.

Regards,
Lucas
