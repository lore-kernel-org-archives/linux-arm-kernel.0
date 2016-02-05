From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Fri, 5 Feb 2016 20:29:19 +0000
Subject: [PATCH] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
In-Reply-To: <20160205201532.GA10389@leverpostej>
References: <1454698027-20911-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160205200142.GA8647@leverpostej> <20160205201532.GA10389@leverpostej>
Message-ID: <9A2E9B16-A69C-456B-8DBD-75F0A2C3FA02@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org






On 2/5/16, 12:15 PM, "Mark Rutland" <mark.rutland@arm.com> wrote:

>On Fri, Feb 05, 2016 at 08:02:09PM +0000, Mark Rutland wrote:
>> On Fri, Feb 05, 2016 at 10:47:07AM -0800, tchalamarla at caviumnetworks.com wrote:
>> > From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>> > 
>> > An issue exists whereby the Linux kernel requires that ASIDs are a
>> > unique namespace per SMMU.  
>> 
>> The SMMU architecture requires this, and Linux relies on hardware
>> following the architecture.
>> 
>> Please describe the problem correctly. i.e. that the hardware
>> erroneously shares TLBs between SMMU instances.
>> 
>> > That ASID-local choice conflicts with the
>> > CN88xx SMMU, where only shared ASID namespaces are supported;
>> > specifically within a given node SMMU0 and SMMU1 share, as does SMMU2
>> > and SMMU3. CN88xx SMMU also requires global VMIDs.
>> > 
>> > This patch tries to address these issuee by supplying asid and vmid
>> > transformations from devicetree.
>> > 
>> > Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula@caviumnetworks.com>
>> > Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>> > ---
>> >  .../devicetree/bindings/iommu/arm,smmu.txt         | 16 ++++++
>> >  drivers/iommu/arm-smmu.c                           | 59 ++++++++++++++++++----
>> >  2 files changed, 65 insertions(+), 10 deletions(-)
>> > 
>> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> > index 7180745..eef06d0 100644
>> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> > @@ -55,6 +55,22 @@ conditions.
>> >                    aliases of secure registers have to be used during
>> >                    SMMU configuration.
>> >  
>> > +- thunderx,smmu-asid-transform	: Enable proper handling for buggy
>> > +		  implementations that require special transformations
>> > +		  for smmu asid. if this property exists asid-transform
>> > +		  property must be present.
>> > +
>> > +- thunderx,smmu-vmid-transform	: Enable proper handling for buggy
>> > +		  implementations that require special transformations
>> > +		  for smmu vmid. if this property exists vmid-transform
>> > +		  property must be present.
>> > +
>> > +- asid-transform 	: Transform mask that needs to be applied to asid.
>> > +			This property has to be specified as '/bits/ 8' value.
>> > +
>> > +- vmid-transform 	: Transform mask that needs to be applied to vmid.
>> > +			This property has to be specified as '/bits/ 8' value.
>> 
>> Don't bother with /bits/ 8. It saves no space in the DTB and only adds
>> to confusion. Use a full cell, and of_property_read_u32, and validate
>> that the value is in range.
>> 
>> Having two properties for each seems redundant. The presence of a mask
>> should be sufficient to make it clear that the use of the mask is
>> required.
>> 
>> These properties aren't sufficiently described. How is the mask
>> "applied", and what is it applied to? What constraints does it impose
>> on the OS's selection of ASIDs/VMIDs?
>> 
>> From the looks of the patch, it's ANDed into the value Linux has
>> selected, so it sounds like an OS must avoid using any bits set in any
>> mask on any SMMU instance. That sounds very difficult to ensure in
>> general, and very fragile.
>
>A much better approach would be to have something like:
>
>valid-asid-range : two u32 cells describing the minimum and maximum
>                   ASIDs that may be used on this SMMU instance. The OS
>		   must allocate ASIDs in the interval [minimum,
>		   maximum].
>
>That way the OS can prevent itself from allocating conflicting ASIDs,
>which is not possible with a single base value as you have with your
>asid-transform property.

The problem is, Will don?t want this to be part of general change, he want to treat it as Errata. 
>
>Mark.
