From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Nov 2013 18:58:06 +0000
Subject: [PATCH 2/2] ARM: SMMU: return NULL on error in
 arm_smmu_iova_to_phys
In-Reply-To: <20131014170948.GS10491@mudshark.cambridge.arm.com>
References: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
 <1381497887-14586-2-git-send-email-a.motakis@virtualopensystems.com>
 <20131014124837.GD10491@mudshark.cambridge.arm.com>
 <CAG8rG2yE=xWmYP_bOy7=jzWEQKNkbgk-9_Jecnx_XXx=jC9i_Q@mail.gmail.com>
 <20131014170948.GS10491@mudshark.cambridge.arm.com>
Message-ID: <20131107185806.GN13139@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 06:09:48PM +0100, Will Deacon wrote:
> On Mon, Oct 14, 2013 at 04:17:51PM +0100, Antonios Motakis wrote:
> > On Mon, Oct 14, 2013 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Oct 11, 2013 at 02:24:47PM +0100, Antonios Motakis wrote:
> > VFIO will exercise this code path every time when mapping DMA memory.
> > This is normal and VFIO *expects* the function to fail - it is only if
> > the function succeeds that VFIO needs to back down from the DMA
> > mapping and fail.
> > 
> > This means that there would be a warning every time a VFIO user maps
> > some memory for DMA use, even though nothing went wrong.
> 
> Ok, in which case it might be worth reworking arm_smmu_iova_to_phys to treat
> {pgd,pud,pmd,pte}_none different from {pgd,pud,pmd,pte}_bad.

Just an FYI, but I realised the page table locking is broken in my driver
(hold a spinlock over a non-atomic allocation; looks like the exynos guys do
this too), so I've just reworked a bunch of iova_to_phys and incorporated this
change as part of that.

Cheers,

Will
