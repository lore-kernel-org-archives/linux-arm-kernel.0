From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 17 Dec 2014 14:27:30 +0000
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141217120948.GB870@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <1612493.xCj1Tx0M4k@avalon> <20141215180933.GW20738@arm.com>
 <2447060.c0PHi7y3cP@wuerfel> <20141217120948.GB870@arm.com>
Message-ID: <549192D2.10008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 17/12/14 12:09, Will Deacon wrote:
> On Tue, Dec 16, 2014 at 12:08:15PM +0000, Arnd Bergmann wrote:
>> On Monday 15 December 2014 18:09:33 Will Deacon wrote:
>>>> Using a single domain is a bit of a waste of resources in my case, so an
>>>> evolution would be to create four domains and assign devices to them based on
>>>> a policy. The policy could be fixed (round-robin for instance), or
>>>> configurable (possibly through DT, although it's really a policy, not a
>>>> hardware description).
>>
>> I think in case of the ARM SMMU, we concluded that the grouping is indeed
>> best done in DT, because of there is no good algorithmic way to come
>> up with a set of bitmasks that make up a proper grouping into domains.
>
> I think that's a slightly different case. The `grouping' in the DT, is on a
> per-master basis where a master may have a set of StreamIDs, which can be
> expressed in a more efficient (per-IOMMU) manner that cannot easily be
> determined at runtime.

I'm pretty convinced that automatic SMR allocation is solvable; I was 
planning to take a look at it soon, once I've finished warming up the 
dormant mathematician in me on implementing the OF group allocator. So 
far I'm lucky that stream indexing is sufficient for the bits of our 
hardware that actually work.

> For iommu_group creation, that could be done in the of code by treating the
> master IDs as bus IDs on a per-IOMMU bus; when a new device is probed, we
> can look at the set of devices with intersecting IDs and create a group
> containing those. This is similar to walking a PCI topology to establish DMA
> aliases.

Thanks to the USB EHCI/OHCI device model I have this prototyped already, 
via having the IOMMU driver register an arbitrary ID of its own choosing 
per of_xlate call, such that any devices claiming the same ID must be in 
the same group (i.e. the driver can perform its own 
translation/abstraction between the DT master ID and the "bus ID" for 
grouping). The tricky missing bit for the SMMU driver itself is 
reprogramming the S2CRs dynamically as devices are added to/removed from 
a group - with that solved I don't see much need left for any explicit 
grouping in DT.

> The problem with all of this is how we distinguish the different ID formats
> in the `iommus' device-tree property. For the ARM SMMU, we could have:
>
>    (1) [easy case] A device has a list of StreamIDs
>
>    (2) A device has a list of SMR mask/value pairs
>
>    (3) A (bus) device has a range translation for a downstream bus (e.g.
>        a PCI host controller which needs to convert RequesterID to StreamID).
>
>  From the SMMU driver's perspective, they will all look like of_xlate calls
> unless we augment the generic IOMMU bindings with extra properties to
> identify the format. It also makes it difficult to pick a sensible value for
> #iommu-cells, as it depends on the format.

I thoroughly dislike the idea, but one /could/ simply abuse the generic 
bindings well within the current framework, e.g.

#1: iommus = <&smmu 0 streamID 0 0>, <&smmu 0 streamID 0 0>, ...;
#2: iommus = <&smmu 1 mask value 0>;
#3: iommus = <&smmu 2 start end offset>;

and have a big complicated of_xlate that knows the secret. I don't think 
it would be unreasonable to constrain all masters on the same SMMU to 
use the same format either - that way you can lose the type indicator 
and the padding and the driver simply inspects #iommu-cells in 
of_iommu_init and sets up that instance to take the right path in its 
of_xlate calls later. Having a handful of single-stream-ID masters 
behind the same SMMU as a whacking great bus controller with a massive 
range seems like the kind of system-designer-insanity we should 
emphatically NOT be looking to accommodate if we can possibly help it.

That said, for the time being I see definite use-cases for #1, which 
already works, and #3, for which I really think we should be looking to 
add a parallel generic "iommu-ranges" or "iommu-bus-range" binding for 
bus controllers, rather than trying to overload "iommus" beyond 
describing actual bus masters.

Robin.
