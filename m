From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 12:08:32 +0100
Subject: [PATCH 2/9] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu
 register values
In-Reply-To: <20130927110521.GO3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-3-git-send-email-andreas.herrmann@calxeda.com>
 <20130927095157.GA9057@mudshark.cambridge.arm.com>
 <20130927102359.GL3315@alberich>
 <20130927105153.GG9057@mudshark.cambridge.arm.com>
 <20130927110521.GO3315@alberich>
Message-ID: <20130927110832.GC9520@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 12:05:21PM +0100, Andreas Herrmann wrote:
> On Fri, Sep 27, 2013 at 06:51:53AM -0400, Will Deacon wrote:
> > Well, we should already print the "device is 0x%lx bytes but only mapped
> > 0x%lx!" message, which I think is enough to go and figure out what happened.
> 
> No, you can map a larger region and still wrongly calculate cb_base
> w/o this warning.

Gotcha.

> So the required check is something like
> 
>          /* Check for mismatch between SMMU address space size and size of mapped region */
>          size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
>          size *= (smmu->pagesize << 1);
>          if (smmu->size != size)
>                  dev_warn(smmu->dev,
>                           "SMMU_GLOBAL_SIZE (0x%lx) differs from mapped "
> 			  region size (0x%lx)!\n", size, smmu->size);

Sure, tightening up that check sounds like a good idea.
Looking forward to the next version of the patches!

(I need some more time to think about that secure config access patch :).

Will
