From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Wed, 24 Feb 2016 15:54:48 +0000
Subject: [PATCH V2] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
In-Reply-To: <20160224113227.GB11579@leverpostej>
References: <1455820158-8529-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160223122616.GE4989@leverpostej> <56CCF03D.3000809@caviumnetworks.com>
 <20160224113227.GB11579@leverpostej>
Message-ID: <1452D0BB-4AF3-4A19-983A-3A54E94A4F2F@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org






On 2/24/16, 3:32 AM, "Mark Rutland" <mark.rutland@arm.com> wrote:

>On Tue, Feb 23, 2016 at 03:50:21PM -0800, Tirumalesh Chalamarla wrote:
>> in Summary,
>> 
>> if i change asid-base to cavium,asid-base and still use DT for
>> supplying base value, is this a solution that will be accepted, 
>
>No. The property is _insufficient_, regardless of its name. This has
>been pointed out more than once.
>
>A base alone does not tell you what set of IDs it is valid to use
>without risking a clash. The OS is well within its rights to allocate
>_any_ ID above that base. It is not a requirement of the hardware nor
>the binding that the OS allocate a contiguous set of IDs starting at the
>base.
>
>Consider:
>
>smmu_a {
>	whatver,*id-base = <128>;
>};
>
>smmu_b {
>	whatever,*id-base = <64>;
>};
>
>In both cases, the *IDs 129+ could be allocated on both SMMUs.

Does adding a check to see if base + number of contexts supported will not overlap with each other
Make it acceptable. 
Or do you want the size be provided from DT also?

Thanks,
Tirumalesh. 
>
>Mark.
>
>> of course i will do range check to see we are not supplying 16bit VMID
>> for 8 bit systems even though the property now indicates Cavium only.
>> 
>> Thanks,
>> Tirumalesh.
>> 
>> On 02/23/2016 04:26 AM, Mark Rutland wrote:
>> >On Thu, Feb 18, 2016 at 10:29:18AM -0800, tchalamarla at caviumnetworks.com wrote:
>> >>From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>> >>
>> >>Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
>> >>namespaces; specifically within a given node SMMU0 and SMMU1 share,
>> >>as does SMMU2 and SMMU3.
>> >>
>> >>This patch tries to address these issuee by supplying asid and vmid
>> >>base from devicetree.
>> >>
>> >>changes from V1:
>> >>	- rebased on top of 16 bit VMID patch
>> >>	- removed redundent options from DT
>> >>	- insted of transform, DT now supplies starting ASID/VMID
>> >>
>> >>Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula@caviumnetworks.com>
>> >>Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>> >>---
>> >>  .../devicetree/bindings/iommu/arm,smmu.txt         |  8 +++++
>> >>  drivers/iommu/arm-smmu.c                           | 37 +++++++++++++++-------
>> >>  2 files changed, 34 insertions(+), 11 deletions(-)
>> >>
>> >>diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> >>index bb7e569..80b8484 100644
>> >>--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> >>+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> >>@@ -57,6 +57,14 @@ conditions.
>> >>
>> >>  - smmu-enable-vmid16 : Enable 16 bit VMID, if allowed.
>> >>
>> >>+- asid-base :	Buggy SMMUv2 implementations which doesn't satisfy the
>> >>+		ASID namespace needs, use this field to specify starting
>> >>+		ASID for the SMMU.
>> >>+
>> >>+- vmid-base :	Buggy SMMUv2 implementations which doesn't satisfy the VMID
>> >>+		namespace needs, use this field to specify starting VMID
>> >>+		for the SMMU.
>> >
>> >As has been pointed out, these are not strictly properties of the
>> >hardware, and are insufficient to aovid the issue in general (adding an
>> >arbitrary base does not enforce IDs fall within a particular range).
>> >
>> >So NAK for *-base properties alone.
>> >
>> >>+	if (of_property_read_u32(dev->of_node, "#asid-base",
>> >>+				 &smmu->asid_base)) {
>> >>+		smmu->asid_base = 0;
>> >>+	}
>> >>+
>> >>+	if (of_property_read_u32(dev->of_node, "#vmid-base",
>> >>+				 &smmu->vmid_base)) {
>> >>+		smmu->vmid_base = 1;
>> >>+	}
>> >
>> >These do not match the documentation above.
>> >
>> >Mark.
>> >
>> 
