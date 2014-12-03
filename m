From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Dec 2014 11:11:08 +0000
Subject: [PATCH 2/4] iommu: add ARM LPAE page table allocator
In-Reply-To: <vnkw8uipznbj.fsf@mitchelh-linux.qualcomm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-3-git-send-email-will.deacon@arm.com>
 <vnkw8uipznbj.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <20141203111108.GH7915@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 10:41:52PM +0000, Mitchel Humpherys wrote:
> On Thu, Nov 27 2014 at 03:51:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> > A number of IOMMUs found in ARM SoCs can walk architecture-compatible
> > page tables.
> >
> > This patch adds a generic allocator for Stage-1 and Stage-2 v7/v8
> > long-descriptor page tables. 4k, 16k and 64k pages are supported, with
> > up to 4-levels of walk to cover a 48-bit address space.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> 
> [...]
> 
> > +static struct io_pgtable *arm_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg,
> > +						    void *cookie)
> > +{
> > +	u64 reg;
> > +	struct arm_lpae_io_pgtable *data = arm_lpae_alloc_pgtable(cfg);
> > +
> > +	if (!data)
> > +		return NULL;
> > +
> > +	/* TCR */
> > +	reg = ARM_LPAE_TCR_EAE |
> > +	     (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > +	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > +	     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> 
> TCR has different definitions depending on whether we're using v7l or
> v8l.  For example, bit 31 is TG1[1] (not EAE) when CBA2R.VA64=1.  Are we
> expecting to have an io-pgtable-arm64.c or something?  Seems like that
> would be mostly redundant with this file...  (We have this problem in
> the current arm-smmu driver today).

I guess we can add an ARM_LPAE_V7_S1 format or something for this, although
we don't actually use TTBR1, so the current code shouldn't cause any issues.

Will
