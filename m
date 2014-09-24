From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Sep 2014 17:37:12 +0100
Subject: [PATCH 2/2] iommu/arm-smmu: add support for iova_to_phys through
 ATS1PR
In-Reply-To: <vnkwiokdx1nj.fsf@mitchelh-linux.qualcomm.com>
References: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
 <1410460244-18943-3-git-send-email-mitchelh@codeaurora.org>
 <20140922152614.GP25809@arm.com>
 <vnkwiokdx1nj.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <20140924163712.GG16244@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 02:12:00AM +0100, Mitchel Humpherys wrote:
> On Mon, Sep 22 2014 at 08:26:14 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Sep 11, 2014 at 07:30:44PM +0100, Mitchel Humpherys wrote:
> >> +		return arm_smmu_iova_to_phys_soft(domain, iova);
> >> +	}
> >> +
> >> +	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
> >> +	phys |= ((u64) readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;
> >> +
> >> +	if (phys & CB_PAR_F) {
> >> +		dev_err(dev, "translation fault on %s!\n", dev_name(dev));
> >> +		dev_err(dev, "PAR = 0x%llx\n", phys);
> >> +	}
> >> +	phys = (phys & 0xFFFFFFF000ULL) | (iova & 0x00000FFF);
> >
> > How does this work for 64k pages?
> 
> So at the moment we're always assuming that we're using v7/v8 long
> descriptor format, right?  All I see in the spec (14.5.15 SMMU_CBn_PAR)
> is that bits[47:12]=>PA[47:12]...  Or am I missing something completely?

I think you've got 64k pages confused with the short-descriptor format.

When we use 64k pages with long descriptors, you're masked off bits 15-12 of
the iova above, so you'll have a hole in the physical address afaict.

Will
