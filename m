From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 00:40:37 +0200
Subject: [PATCH v6 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <52129BC2.6020804@wwwdotorg.org>
References: <1376924669-28873-1-git-send-email-m.szyprowski@samsung.com>
 <9906612.JEHkvlBKY1@flatron> <52129BC2.6020804@wwwdotorg.org>
Message-ID: <3804224.ROD4LeYdVO@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 of August 2013 16:27:14 Stephen Warren wrote:
> On 08/19/2013 04:24 PM, Tomasz Figa wrote:
> > On Monday 19 of August 2013 16:17:30 Stephen Warren wrote:
> >> On 08/19/2013 04:02 PM, Tomasz Figa wrote:
> >>> Hi Stephen,
> >>> 
> >>> On Monday 19 of August 2013 15:49:20 Stephen Warren wrote:
> >>>> On 08/19/2013 09:04 AM, Marek Szyprowski wrote:
> >>>>> This patch adds device tree support for contiguous and reserved
> >>>>> memory
> >>>>> regions defined in device tree.
> >>>>> 
> >>>>> diff --git a/Documentation/devicetree/bindings/memory.txt
> >>>>> b/Documentation/devicetree/bindings/memory.txt
> >>>>> 
> >>>>> +*** Reserved memory regions ***
> >>>>> +
> >>>>> +In /memory/reserved-memory node one can create additional nodes
> >>>> 
> >>>> s/additional/child/ or s/additional/sub/ would make it clearer
> >>>> where
> >>>> the "additional" nodes should be placed.
> >>>> 
> >>>>> +compatible:	"linux,contiguous-memory-region" - enables binding
> >>> 
> >>> of
> >>> 
> >>>>> this
> >>>>> +		region to Contiguous Memory Allocator (special 
region for
> >>>>> +		contiguous memory allocations, shared with movable 
system
> >>>>> +		memory, Linux kernel-specific), alternatively if
> >>>>> +		"reserved-memory-region" - compatibility is 
defined, given
> >>>>> +		region is assigned for exclusive usage for by the
> >>> 
> >>> respective
> >>> 
> >>>>> +		devices
> >>>> 
> >>>> "alternatively" makes it sound like the two compatible values are
> >>>> mutually-exclusive. Perhaps make this a list, like:
> >>>> 
> >>>> ----------
> >>>> 
> >>>> compatible: One or more of:
> >>>> 	- "linux,contiguous-memory-region" - enables binding of this
> >>>> 	
> >>>> 	  region to Contiguous Memory Allocator (special region for
> >>>> 	  contiguous memory allocations, shared with movable system
> >>>> 	  memory, Linux kernel-specific).
> >>>> 	
> >>>> 	- "reserved-memory-region" - compatibility is defined, given
> >>>> 	
> >>>> 	  region is assigned for exclusive usage for by the respective
> >>>> 	  devices.
> >>>> 
> >>>> ----------
> >>>> 
> >>>> "linux,contiguous-memory-region" is already long enough, but I'd
> >>>> slightly bikeshed towards
> >>>> "linux,contiguous-memory-allocator-region",
> >>>> or perhaps "linux,cma-region" since it's not really describing
> >>>> whether the memory is contiguous (at the level of /memory, each
> >>>> chunk of memory is contiguous...)
> >>> 
> >>> I'm not really sure if we need the "linux" prefix for
> >>> "contiguous-memory- region". The concept of contiguous memory region
> >>> is rather OS independent and tells us that memory allocated from
> >>> this
> >>> region will be contiguous. IMHO any OS is free to implement its own
> >>> contiguous memory allocation method, without being limited to Linux
> >>> CMA.
> >>> 
> >>> Keep in mind that rationale behind those contiguous regions was that
> >>> there are devices that require buffers contiguous in memory to
> >>> operate correctly.
> >>> 
> >>> But this is just nitpicking and I don't really have any strong
> >>> opinion
> >>> on this.
> >>> 
> >>>>> +*** Device node's properties ***
> >>>>> +
> >>>>> +Once regions in the /memory/reserved-memory node have been
> >>>>> defined,
> >>>>> they +can be assigned to device nodes to enable respective device
> >>>>> drivers to +access them. The following properties are defined:
> >>>>> +
> >>>>> +memory-region = <&phandle_to_defined_region>;
> >>>> 
> >>>> I think the naming of that property should more obviously match
> >>>> this
> >>>> binding and/or compatible value; perhaps cma-region or
> >>>> contiguous-memory-region?
> >>> 
> >>> This property is not CMA-specific. Any memory region can be given
> >>> using
> >>> the memory-region property and used to allocate buffers for
> >>> particular
> >>> device.
> >> 
> >> OK, that makes sense.
> >> 
> >> What I'm looking for is some way to make it obvious that when you see
> >> a
> >> "memory-region" property in a node, you go look at the "memory.txt"
> >> rather than the DT binding for the node where that property appears.
> >> Right now, it doesn't seem that obvious to me.
> >> 
> >> I think the real issue here is that my brief reading of memory.txt
> >> implies that arbitrary device nodes can include the memory-region
> >> property without the node's own binding having to document it; the
> >> property name is essentially "forced into" all other bindings.
> >> 
> >> I think instead, memory.txt should say:
> >> 
> >> ----------
> >> ** Device node's properties ***
> >> 
> >> Once regions in the /memory/reserved-memory node have been defined,
> >> they may be referenced by other device nodes. Bindings that wish to
> >> reference memory regions should explicitly document their use of the
> >> following property:
> >> 
> >> memory-region = <&phandle_to_defined_region>;
> >> 
> >> This property indicates that the device driver should use the memory
> >> region pointed by the given phandle.
> >> ----------
> >> 
> >> Also, what if a device needs multiple separate memory regions?
> >> Perhaps a GPU is forced to allocate displayable surfaces from
> >> addresses 0..32M and textures/off-screen-render-targets from
> >> 256M..384M or something whacky like that. In that case, we could
> >> either:
> >> 
> >> a) Adjust memory.txt to allow multiple entries in memory-regions, and
> >> add an associated memory-region-names property.
> >> 
> >> or:
> >> 
> >> b) Adjust memory.txt not to mention any specific property names, but
> >> simply mention that other DT nodes can refer to define memory regions
> >> by phandle, and leave it up to individual bindings to define which
> >> property they use to reference the memory regions, perhaps with
> >> memory.txt providing a recommendation of memory-region for the
> >> simple case, but perhaps also allowing a custom case, e.g.:
> >> 
> >> display-memory-region = <&phandl1e1>;
> >> texture-memory-region = <&phahndle2>;
> > 
> > Well, such setup simply cannot be handled by Linux today, as one
> > device
> > (aka one struct device) can only have one memory region bound to it.
> > So
> > this is not something we can implement today.
> 
> Don't you just create "fake" struct devices to make this work, so that
> the top-level struct device is instantiated from DT, and the others
> created manually in the top-level device's probe routine, and the memory
> regions get attached to those "fake" child devices? Seems pretty
> conceptually easy.

Correct. However you need those fake struct devices to be attached to some 
memory region and often other things like IOMMU. In fact, they aren't 
entirely fake, as they usually represent real bus masters of the IP.

> > I agree that the device tree should be able to describe such
> > configurations,
> 
> good:-)
> 
> > though, but I'm not sure if this should be done from this side.
> 
> I'm not sure what "from this side" means. It seems pretty simple to
> adjust this patch to allow such HW to be represented, so shouldn't we
> just do it and be done with the question?

Well, if it's just about modifying the binding to support such cases, but 
without actually adding support for them in Linux, then I guess it's fine. 
Otherwise a lot of memory management code (mostly the DMA mapping API and 
a lot of its users) would have to be almost completely reworked, which 
wouldn't be an easy task.

Best regards,
Tomasz
