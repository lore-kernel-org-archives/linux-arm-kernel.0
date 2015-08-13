From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Thu, 13 Aug 2015 18:17:41 +0200
Subject: [PATCH v2 3/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <55CCB393.1040909@arm.com>
References: <1439477277-6157-1-git-send-email-rric@kernel.org>
 <1439477277-6157-4-git-send-email-rric@kernel.org>
 <55CCB393.1040909@arm.com>
Message-ID: <20150813161741.GO1820@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

thanks for your quick review.

On 13.08.15 16:11:15, Marc Zyngier wrote:
> On 13/08/15 15:47, Robert Richter wrote:
> > From: Robert Richter <rrichter@cavium.com>

> >  static const struct gic_capabilities gicv3_errata[] = {
> >  	{
> > +		.desc		= "GIC: Cavium erratum 23154",
> > +		.iidr		= 0xa100034c,	/* ThunderX pass 1.x */
> > +		.iidr_mask	= 0xffff0fff,
> > +		.init		= gicv3_enable_cavium_thunderx,
> > +	},
> 
> I'm even more puzzled. You're working around a CPU bug based on the ITS
> ID registers? Or have you swapped the detection methods for the two errata?

:/ Right, I mixed this up... Must have starred on this for too long.
Will fix that.

Wrt midr: Originally this was written to support iidr. I wanted to
keep the version check in the driver of the hw, an implementation
outside of drivers/irqchip looked not appropriate here as it would
rely then on arch arm64 only. This is the main reason. Apart from
that, I think an implmentation based on struct arm64_cpu_capabilities,
etc. would require much rework compared to my current easy
implementation, e.g:

 * binding flags to callbacks and actually run them,

 * handing over private driver data (base addr for iidr detection) to
   a capabilty's match function.

Overall this looked bloated. Now, that the MIDR also needs to be
checked, it looked better to me to keep the gic hw detection at a
single location in the driver. This also allows us to check a
combination of midr and iidr values.

I hope this sounds reasonable?

-Robert
