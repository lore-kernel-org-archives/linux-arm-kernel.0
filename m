From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 02 Sep 2014 13:23:43 +0300
Subject: [RFC PATCH 4/7] iommu: provide helper function to configure an
 IOMMU for an of master
In-Reply-To: <3729116.F0gWrQGFZl@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <20140901082939.GC24430@ulmo> <3729116.F0gWrQGFZl@wuerfel>
Message-ID: <2453590.E42S9qWAZh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 16:46:18 Arnd Bergmann wrote:
> On Monday 01 September 2014 10:29:40 Thierry Reding wrote:
> > I think this could use a bit more formalization. As I said in another
> > reply earlier, there's very little standardization in the IOMMU API.
> > That certainly gives us a lot of flexibility but it also has the
> > downside that it's difficult to handle these abstractions in the core,
> > which is really what the core is all about, isn't it?
> > 
> > One method that worked really well for this in the past for other
> > subsystems is to allow drivers to specify an .of_xlate() function that
> > takes the controller device and a struct of_phandle_args. It is that
> > function's responsibility to take the information in an of_phandle_args
> > structure and use that to create some subsystem specific handle that
> > represents this information in a way that it can readily be used.
> 
> Yes, good idea.
> 
> > So I think it would really be helpful if IOMMU gained support for
> > something similar. We could create a struct iommu to represent an
> > instance of an IOMMU. IOMMU drivers can embed this structure and add
> > device-specific fields that they need. That way we can easily pass
> > around instances and upcast in the driver in a type-safe way.
> 
> Right.
> 
> > At the same time, a struct iommu_master could provide the basis to
> > represent a single master interface on an IOMMU. Drivers can again embed
> > that in driver-specific structures with additional fields required for
> > the particular IOMMU implementation. .of_xlate() could return such an
> > IOMMU master for the core to use.
> 
> I'm not convinced it's necessary. Could this just be a 'struct device'
> instead of 'struct iommu_master'?

As master drivers should in general be unaware of the IOMMU that serves them, 
embedding a struct iommu_master inside driver-specific structures is a no-go.

Let's also not forget that a device can be connected to multiple IOMMU ports. 
The only cases I've seen had multiple connections between a bus master device 
and a single IOMMU, all of them potentially sharing a TLB, so a simple 
implementation was possible.

I'm not sure how we could handle connections from one device to different 
IOMMUs, or to multiple ports of the same IOMMU with different TLBs. Splitting 
the device in multiple children struct device might be required.

> > With such structures in place we should be able to eliminate many of the
> > loops in IOMMU drivers that serve no other purpose than to find the
> > master context from a struct device * and some parameters. It will also
> > allow us to keep a central registry of IOMMUs and masters rather than
> > duplicating that in every driver.
> 
> Yes, we should be able to identify an iommu context in a generic way,
> but why do you want to break it down to individual masters within
> one context?

-- 
Regards,

Laurent Pinchart
