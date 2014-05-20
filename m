From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 20 May 2014 15:17:43 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <8663464.40PHEumOar@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <10711669.TTjp9L4tTG@wuerfel> <20140520120242.GA20995@ulmo>
 <8663464.40PHEumOar@wuerfel>
Message-ID: <20140520131741.GB6240@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
[...]
> > Couldn't a single-master IOMMU be windowed?
> 
> Ah, yes. That would actually be like an IBM pSeries, which has a windowed
> IOMMU but uses one window per virtual machine. In that case, the window could
> be a property of the iommu node though, rather than part of the address
> in the link.

Does that mean that the IOMMU has one statically configured window which
is the same for each virtual machine? That would require some other
mechanism to assign separate address spaces to each virtual machine,
wouldn't it? But I suspect that if the IOMMU allows that it could be
allocated dynamically at runtime.

> > Multiple-master IOMMU with fixed associations:
> > ----------------------------------------------
> > 
> > 	/* multiple-master IOMMU */
> > 	iommu {
> > 		/*
> > 		 * Masters are statically associated with this IOMMU and
> > 		 * address translation is always enabled.
> > 		 */
> > 		#iommu-cells = <0>;
> > 	};
> 
> copied wrong? I guess you mean #address-cells=<0>/#size-cells=<0> here.

Yes, I obviously wasn't careful when I copied this over.

> > Multiple-master device:
> > -----------------------
> > 
> > 	/* single-master IOMMU */
> > 	iommu at 1 {
> > 		reg = <1>;
> > 		#address-cells = <0>;
> > 		#size-cells = <0>;
> > 	};
> > 
> > 	/* multiple-master IOMMU */
> > 	iommu at 2 {
> > 		reg = <2>;
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> > 	};
> > 
> > 	/* device with two master interfaces */
> > 	master {
> > 		iommus = <&/iommu@1>,    /* master of the single-master IOMMU */
> > 			 <&/iommu@2 42>; /* ID 42 in multiple-master IOMMU */
> > 	};
[...]
> > Does that sound about right?
> 
> Yes, sounds great. I would probably leave out the Multiple-master device
> from the examples, since that seems to be a rather obscure case.

Agreed. We can easily add such examples if/when such device start to
appear.

> I would like to add an explanation about dma-ranges to the binding:
> 
> 8<--------
> The parent bus of the iommu must have a valid "dma-ranges" property
> describing how the physical address space of the IOMMU maps into
> memory.

With physical address space you mean the addresses after translation,
not the I/O virtual addresses, right? But even so, how will this work
when there are multiple IOMMU devices? What determines which IOMMU is
mapped via which entry?

Perhaps having multiple IOMMUs implies that there will have to be some
partitioning of the parent address space to make sure two IOMMUs don't
translate to the same ranges?

> A device with an "iommus" property will ignore the "dma-ranges" property
> of the parent node and rely on the IOMMU for translation instead.

Do we need to consider the case where an IOMMU listed in iommus isn't
enabled (status = "disabled")? In that case presumably the device would
either not function or may optionally continue to master onto the parent
untranslated.

> Using an "iommus" property in bus device nodes with "dma-ranges"
> specifying how child devices relate to the IOMMU is a possible extension
> but is not recommended until this binding gets extended.

Just for my understanding, bus device nodes with iommus and dma-ranges
properties could be equivalently written by explicitly moving the iommus
properties into the child device nodes, right? In which case they should
be the same as the other examples. So that concept is a convenience
notation to reduce duplication, but doesn't fundamentally introduce any
new concept.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/37014a7c/attachment.sig>
