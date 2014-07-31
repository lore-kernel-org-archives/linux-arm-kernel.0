From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Jul 2014 12:18:08 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140731092241.GA21850@leverpostej>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730152646.GC20162@leverpostej> <20140731083923.GA31218@ulmo>
 <20140731092241.GA21850@leverpostej>
Message-ID: <20140731101807.GB7458@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 10:22:41AM +0100, Mark Rutland wrote:
> [...]
> 
> > > > +Examples:
> > > > +=========
> > > > +
> > > > +Single-master IOMMU:
> > > > +--------------------
> > > > +
> > > > +	iommu {
> > > > +		#iommu-cells = <0>;
> > > > +	};
> > > > +
> > > > +	master {
> > > > +		iommus = <&/iommu>;
> > > 
> > > Nit: this should be iommus = <&{/iommu}>, or it's not valid dts syntax.
> > 
> > Done.
> 
> Cheers. I take it that was done for the other occurrences too?

Of course. =)

> > > > +	};
> > > > +
> > > > +Multiple-master IOMMU with fixed associations:
> > > > +----------------------------------------------
> > > > +
> > > > +	/* multiple-master IOMMU */
> > > > +	iommu {
> > > > +		/*
> > > > +		 * Masters are statically associated with this IOMMU and
> > > > +		 * address translation is always enabled.
> > > > +		 */
> > > > +		#iommu-cells = <0>;
> > > 
> > > I don't follow why translation being always enabled is relevant to the
> > > example; that would seem to be independent from the binding.
> > > 
> > > Surely the key point is that with no way to distinguish devices, they
> > > presumably share the same translations?
> > 
> > Both aspects are important I think. For #iommu-cells = <0> there is no
> > way for the IOMMU driver to know how to enable translation for a given
> > device. So it must be either always on or always off.
> 
> Sure. But "always on or off" is not the same as "always enabled", which
> was what confused me.

Yes, this was indeed awkwardly formulated. I think the point that I was
trying to get across was that there could be IOMMUs that are always on,
with no means to disable translations at all. But since that's now
mentioned in the "Notes:" section that Olof commented on I think we have
that covered as well.

> 
> > I guess one could say that this is implicit if all masters share the
> > same translations. And I guess translations don't always have to be on
> > or off technically. Let me try to rephrase this:
> > 
> > 		/*
> > 		 * Masters are statically associated with this IOMMU and share
> > 		 * the same address translations because the IOMMU does not
> > 		 * have sufficient information to distinguish between masters.
> > 		 *
> > 		 * Consequently address translation is always on or off for
> > 		 * all masters at any given point in time.
> > 		 */
> > 
> > Does that sound better?
> 
> That addresses my concern, so yes.
> 
> Given these are minor and everyone wants this in now, I'm happy for
> these to go through in a fixup patch later.

It looks like this hasn't been applied yet, so I can send out a v5
shortly with the requested changes addressed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/bb8aa5a3/attachment.sig>
