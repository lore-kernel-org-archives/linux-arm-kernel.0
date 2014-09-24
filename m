From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Sep 2014 17:27:26 +0100
Subject: [PATCH 2/2] iommu/arm-smmu: add support for access-protected
 mappings
In-Reply-To: <vnkwtx3zb885.fsf@mitchelh-linux.qualcomm.com>
References: <1410984969-2340-1-git-send-email-mitchelh@codeaurora.org>
 <1410984969-2340-3-git-send-email-mitchelh@codeaurora.org>
 <20140919220535.GM20773@arm.com>
 <vnkwtx3zb885.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <20140924162726.GE16244@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 11:28:42PM +0100, Mitchel Humpherys wrote:
> On Fri, Sep 19 2014 at 03:05:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Sep 17, 2014 at 09:16:09PM +0100, Mitchel Humpherys wrote:
> >> ARM SMMUs support memory access control via some bits in the translation
> >> table descriptor memory attributes. Currently we assume all translations
> >> are "unprivileged". Add support for privileged mappings, controlled by
> >> the IOMMU_PRIV prot flag.
> >> 
> >> Also sneak in a whitespace change for consistency with nearby code.
> >> 
> >> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> >> ---
> >>  drivers/iommu/arm-smmu.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index ca18d6d42a..93999ec22c 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -1256,10 +1256,11 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
> >>  	}
> >>  
> >>  	if (stage == 1) {
> >> -		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
> >> +		pteval |= ARM_SMMU_PTE_nG;
> >> +		if (!(prot & IOMMU_PRIV))
> >> +			pteval |= ARM_SMMU_PTE_AP_UNPRIV;
> >
> > I think this actually makes more sense if we invert the logic, i.e. have
> > IOMMU_USER as a flag which sets the UNPRIV bit in the pte.
> 
> I'm fine either way but the common case seems to be unprivileged
> mappings (at least in our system).  We have one user of this flag out of
> a dozen or so users.

Well, I think the common case in reality (ie. in upstream) is that we don't
care, since there's no page table sharing with the CPU. Given that our DMA
buffers are privilege on the kernel side, it's consistent to copy that as
the default.

> >
> > I don't have the spec to hand, but I guess you can't enforce this at
> > stage-2? If so, do we also need a new IOMMU capability so people don't try
> > to use this for stage-2 only SMMUs?
> 
> Hmm, actually we do have S2AP although it doesn't make a distinction
> between accesses from EL0 and EL1.  But maybe it would make sense to
> make the `IOMMU_PRIV' mean `no access from EL0 or EL1' for stage 2
> mappings?  Something like:

Hmm, that really doesn't match up with what KVM is doing on the CPU side and
would probably break DMA on stage-2 only SMMUs.

A better bet is to add a capability bit to the SMMU, which only advertises
support for IOMMU_USER mappings if stage-1 is supported.

Will
