From: herrmann.der.user@googlemail.com (Andreas Herrmann)
Date: Thu, 23 Jan 2014 22:17:49 +0100
Subject: [PATCH 05/11] iommu/arm-smmu: Check for duplicate stream IDs
 when registering master devices
In-Reply-To: <20140122155302.GF14108@mudshark.cambridge.arm.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-6-git-send-email-andreas.herrmann@calxeda.com>
 <20140122155302.GF14108@mudshark.cambridge.arm.com>
Message-ID: <20140123211749.GE26399@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 03:53:02PM +0000, Will Deacon wrote:
> On Thu, Jan 16, 2014 at 12:44:17PM +0000, Andreas Herrmann wrote:
> > Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |   25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 02a871e..a4e0c93 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -56,6 +56,9 @@
> >  /* Maximum number of stream IDs assigned to a single device */
> >  #define MAX_MASTER_STREAMIDS		8
> >  
> > +/* Maximum stream ID */
> > +#define ARM_SMMU_MAX_STREAMID		(SZ_64K - 1)
> > +
> >  /* Maximum number of context banks per SMMU */
> >  #define ARM_SMMU_MAX_CBS		128
> >  
> > @@ -386,6 +389,8 @@ struct arm_smmu_device {
> >  	u32				smr_mask_mask;
> >  	u32				smr_id_mask;
> >  
> > +	unsigned long			*sids;
> 
> DECLARE_BITMAP instead?

I wanted to allocate the bitmap which btw allows us to ... [? see end
of mail]

> However, that's an 8k bitmap just for sanity checking, which I'm not
> too fond of.

Yes, I thought the same. But finally I thought it's worth it.

> Given that the motivation for the checking was your smr allocator,
> perhaps it's sufficient just to do the checking on a per-master
> basis, which we can do with the exhaustive search each time.

A per-master basis is not sufficient. If you argue that someone could
have specified the same stream ID twice for one master in DT how are
chances that the same stream ID shows up twice but for different
master devices?

I think we have to check this (independent of my smr allocator).
If two masters accidentially share the/an ID:

* Stream ID matching (w/o a mask, just use one SMR to map one stream
  ID): It proably will cause a multi match with undifined behaviour.

* Stream ID indexing: You would overwrite an already used S2CR (if
  there are no further precautions).

That is why I think a check to reject duplicate stream IDs among all
masters for one SMMU is required.

If this is needed, exhaustive search doesn't seem to be a good idea,
because if you have a distributed SMMU -- one TCU (I think that's
where the SMRs are), and many TBUs -- you might have several master
devices attached (many more than in current systems). Each master
potentially has several stream IDs ...  Esp. in this case 8k for doing
the check isn't an issue.

Maybe a compromise is to 

... free the bitmap after the check is done.


Andreas
