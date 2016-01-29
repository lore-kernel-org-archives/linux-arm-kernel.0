From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 29 Jan 2016 03:42:15 +0000
Subject: [RFC PATCH 5/6] iommu/arm-smmu: Option to treat instruction
 fetch as data read for SMMUv2
In-Reply-To: <56AA4B89.3040400@arm.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-6-git-send-email-anup.patel@broadcom.com>
 <56AA4B89.3040400@arm.com>
Message-ID: <39063E8F96E11742B35A201CC5D095B7BB2252@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: 28 January 2016 22:41
> To: Anup Patel; Catalin Marinas; Joerg Roedel; Will Deacon; Robin Murphy;
> Sricharan R; Linux IOMMU; Linux ARM Kernel
> Cc: Mark Rutland; Device Tree; Scott Branden; Pawel Moll; Ian Campbell; Ray
> Jui; Linux Kernel; Vikram Prakash; Rob Herring; bcm-kernel-feedback-list; Kumar
> Gala
> Subject: Re: [RFC PATCH 5/6] iommu/arm-smmu: Option to treat instruction
> fetch as data read for SMMUv2
> 
> On 27/01/16 05:21, Anup Patel wrote:
> > Currently, the SMMU driver by default provides unprivilege read-write
> > permission in page table entries of stage1 page table. For SMMUv2 with
> > aarch64 long descriptor format, a privilege instruction fetch will
> > generate context fault. To allow privilege instruction fetch from a
> > MMU master we need to treat instruction fetch as data read.
> >
> > This patch adds an optional DT attribute 'smmu-inst-as-data' to treat
> > privilege/unprivilege instruction fetch as data read for SMMUv2.
> 
> What's the use-case for retaining the privilege attribute over the instruction
> attribute? The pagetable code still maps everything with unprivileged
> permissions, and it isn't going to be relevant for the vast majority of devices.
> Conversely, the instruction/data distinction is likely to be useful in a lot more
> cases - there's a veritable class of exploits around tricking a
> DSP/GPU/VPU/whatever into executing malicious firmware/shaders/etc. - and
> the IOMMU API does already have support for that which this change subtly
> undermines: if you override INSTCFG this way, you also need to stop the SMMU
> from claiming to support IOMMU_NOEXEC, because it no longer will.

Currently, there is no provision in IOMMU framework to specify privilege level
of a mapping. I thought in future someone might certainly add such a thing
because theoretically we can have accesses from a microcontroller or
coprocessor going through SMMU and microcontroller or coprocessor can
have two privilege levels.

Now, the list of all possible access types would be:
1. Privileged read
2. Privileged write
3. Privileged instruction fetch
4. Unprivileged read
5. Unprivileged write
6. Unprivileged instruction fetch

If we treat instruction fetch as data read then above would reduce to:
1. Privileged read
2. Privileged write
3. Unprivileged read
4. Unprivileged write

If we treat all privileged access as unprivileged then above would reduce to:
1. Unprivileged read
2. Unprivileged write
3. Unprivileged instruction fetch

The possible access types were reducing more if treated privileged accesses
as unprivileged accesses. This motivated me to prefer "treat instruction
fetch as data read" over "treat privileged access as unprivileged".

I am fine with both approaches. If we envision that IOMMU framework
no use for privileged accesses then we should go with "treat privileged
access as unprivileged" approach. In fact, I was already planning to base
this patchset upon your patchset and remove duplicate changes from
my patchset.

Regards,
Anup
