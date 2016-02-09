From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 9 Feb 2016 16:53:58 +0000
Subject: [PATCH] of/irq: Fix msi-map calculation for nonzero rid-base
In-Reply-To: <20160209160812.GC9332@leverpostej>
References: <9f6845195d03b0e0b0d187bb510fbf7bd497e836.1455015344.git.robin.murphy@arm.com>
 <56B9D62E.8080003@arm.com>
 <HE1PR04MB1641AF97F637BBCBB86BA4FE8DD60@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <20160209160812.GC9332@leverpostej>
Message-ID: <HE1PR04MB1641792D75BC60CA549F45A98DD60@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Tuesday, February 09, 2016 10:08 AM
> To: Stuart Yoder <stuart.yoder@nxp.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>; Robin Murphy <robin.murphy@arm.com>;
> robh+dt at kernel.org; frowand.list at gmail.com; grant.likely at linaro.org;
> devicetree at vger.kernel.org; david.daney at cavium.com; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; stable at vger.kernel.org
> Subject: Re: [PATCH] of/irq: Fix msi-map calculation for nonzero rid-base
> 
> On Tue, Feb 09, 2016 at 03:56:55PM +0000, Stuart Yoder wrote:
> >
> > > -----Original Message-----
> > > From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> > > Sent: Tuesday, February 09, 2016 6:06 AM
> > > To: Robin Murphy <robin.murphy@arm.com>; robh+dt at kernel.org; frowand.list at gmail.com;
> > > grant.likely at linaro.org; devicetree at vger.kernel.org
> > > Cc: mark.rutland at arm.com; david.daney at cavium.com; Stuart Yoder
> <stuart.yoder@nxp.com>;
> > > linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > > stable at vger.kernel.org
> > > Subject: Re: [PATCH] of/irq: Fix msi-map calculation for nonzero rid-base
> > >
> > > Hi Robin,
> > >
> > > On 09/02/16 11:04, Robin Murphy wrote:
> > > > The existing msi-map code is fine for shifting the entire RID space
> > > > upwards, but attempting finer-grained remapping reveals a bug. It turns
> > > > out that we are mistakenly treating the msi-base part as an offset, not
> > > > as a new base to remap onto, so things get squiffy when rid-base is
> > > > nonzero. Fix this, and at the same time add a sanity check against
> > > > having msi-map-mask clash with a nonzero rid-base, as that's another
> > > > thing one can easily get wrong.
> > > >
> > > > CC: <stable@vger.kernel.org>
> > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > >
> > > Looks like Stuart and you both found the same bug at the same time:
> > > https://lkml.org/lkml/2016/2/8/1066
> > >
> > > but yours seem more correct to me (the rid_base masking in Stuart's
> > > version seems odd).
> > >
> > > > ---
> > > >  drivers/of/irq.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > > > index 7ee21ae..e7bfc17 100644
> > > > --- a/drivers/of/irq.c
> > > > +++ b/drivers/of/irq.c
> > > > @@ -635,6 +635,13 @@ static u32 __of_msi_map_rid(struct device *dev, struct
> > > device_node **np,
> > > >  		msi_base = be32_to_cpup(msi_map + 2);
> > > >  		rid_len = be32_to_cpup(msi_map + 3);
> > > >
> > > > +		if (rid_base & ~map_mask) {
> > > > +			dev_err(parent_dev,
> > > > +				"Invalid msi-map translation - msi-map-mask (0x%x) ignores
> rid-
> > > base (0x%x)\n",
> > > > +				map_mask, rid_base);
> > > > +			return rid_out;
> > > > +		}
> > > > +
> > > >  		msi_controller_node = of_find_node_by_phandle(phandle);
> > > >
> > > >  		matched = (masked_rid >= rid_base &&
> > > > @@ -654,7 +661,7 @@ static u32 __of_msi_map_rid(struct device *dev, struct
> device_node
> > > **np,
> > > >  	if (!matched)
> > > >  		return rid_out;
> > > >
> > > > -	rid_out = masked_rid + msi_base;
> > > > +	rid_out = masked_rid - rid_base + msi_base;
> > > >  	dev_dbg(dev,
> > > >  		"msi-map at: %s, using mask %08x, rid-base: %08x, msi-base: %08x,
> length:
> > > %08x, rid: %08x -> %08x\n",
> > > >  		dev_name(parent_dev), map_mask, rid_base, msi_base,
> > > >
> >
> > This computation:  masked_rid - rid_base
> >
> > ...doesn't seem right to me.  We are taking a rid that
> > has been already masked and subtracting a rid base that has
> > not been masked.
> 
> The binding only mentions that the input RID is masked, not the base, so
> that seems correct to me.
> 
> > I don't see how you can combine masked and unmasked values in the same
> > calculation.
> >
> > Say I have this msi mapping:
> >
> >                    msi-map = <0x0100 &its 0x11 0x1>;
> >                    msi-map-mask = <0xff>;
> >
> 
> I'd say that this is an inconsistent set of properties, and it's
> probably worth warning if we encounter this. There is no possible way
> that rid-base can be encountered.
> 
> > masked_rid = 0x0
> > rid_base = 0x0100
> > msi_base = 0x11
> >
> > masked_rid - rid_base is 0x0 - 0x0100...which does not
> > give the msi index/offset we want.
> >
> > Correct final answer should be 0x11.
> 
> You can unambiguously describe this with:
> 
> 	msi-map = <0x00 &its 0x11 0x1>;
> 	msi-map-mask = <0xff>;
> 
> This is exactly the pattern we follow in example 2 in the binding
> document.
> 
> > In my patch I masked the rid_base so it can be subtracted
> > from the masked_rid.
> >
> > masked_rid_base = 0x00
> >
> >    msi_base + (masked_rid - masked_rid_base) = 0x11
> 
> As above, I think that this is an inconsistent DT, and we should
> warn/fail in that case.

Thanks...understand now.  I'll test Robin's patch and confirm
that it works as is for me.

Thanks,
Stuart
