From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Oct 2013 18:09:48 +0100
Subject: [PATCH 2/2] ARM: SMMU: return NULL on error in
 arm_smmu_iova_to_phys
In-Reply-To: <CAG8rG2yE=xWmYP_bOy7=jzWEQKNkbgk-9_Jecnx_XXx=jC9i_Q@mail.gmail.com>
References: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
 <1381497887-14586-2-git-send-email-a.motakis@virtualopensystems.com>
 <20131014124837.GD10491@mudshark.cambridge.arm.com>
 <CAG8rG2yE=xWmYP_bOy7=jzWEQKNkbgk-9_Jecnx_XXx=jC9i_Q@mail.gmail.com>
Message-ID: <20131014170948.GS10491@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 04:17:51PM +0100, Antonios Motakis wrote:
> On Mon, Oct 14, 2013 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Oct 11, 2013 at 02:24:47PM +0100, Antonios Motakis wrote:
> >> The return value of arm_smmu_iova_to_phys is directly passed to the
> >> user of the IOMMU API via iommu_iova_to_phys; however the ARM SMMU
> >> driver returns -EINVAL on error, which is not consistent with the
> >> rest of the drivers implementing the IOMMU API. VFIO also relies on
> >> the call returning NULL when a page has not been mapped already.
> >>
> >> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> >> ---
> >>  drivers/iommu/arm-smmu.c | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 8b71332..fe81b20 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -1480,10 +1480,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
> >>
> >>  err_unlock:
> >>       spin_unlock(&smmu_domain->lock);
> >> -     dev_warn(smmu->dev,
> >> -              "invalid (corrupt?) page tables detected for iova 0x%llx\n",
> >> -              (unsigned long long)iova);
> >> -     return -EINVAL;
> >> +     return NULL;
> >
> > Why are you removing the warning message?
> 
> VFIO will exercise this code path every time when mapping DMA memory.
> This is normal and VFIO *expects* the function to fail - it is only if
> the function succeeds that VFIO needs to back down from the DMA
> mapping and fail.
> 
> This means that there would be a warning every time a VFIO user maps
> some memory for DMA use, even though nothing went wrong.

Ok, in which case it might be worth reworking arm_smmu_iova_to_phys to treat
{pgd,pud,pmd,pte}_none different from {pgd,pud,pmd,pte}_bad.

Will
