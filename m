From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Aug 2018 14:00:47 +0100
Subject: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
In-Reply-To: <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
Message-ID: <20180815130046.GA19402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2018 at 01:26:31PM +0100, Robin Murphy wrote:
> On 15/08/18 11:23, Zhen Lei wrote:
> >The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
> >__arm_smmu_sync_poll_msi requires that sync_idx must be increased
> >monotonously according to the sequence of the CMDs in the cmdq.
> >
> >But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
> >by spinlock, so the following scenarios may appear:
> >cpu0			cpu1
> >msidata=0
> >			msidata=1
> >			insert cmd1
> >insert cmd0
> >			smmu execute cmd1
> >smmu execute cmd0
> >			poll timeout, because msidata=1 is overridden by
> >			cmd0, that means VAL=0, sync_idx=1.
> >
> >This is not a functional problem, just make the caller wait for a long
> >time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
> >during the waiting period will break it.
> >
> >Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >---
> >  drivers/iommu/arm-smmu-v3.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >index 1d64710..3f5c236 100644
> >--- a/drivers/iommu/arm-smmu-v3.c
> >+++ b/drivers/iommu/arm-smmu-v3.c
> >@@ -566,7 +566,7 @@ struct arm_smmu_device {
> >
> >  	int				gerr_irq;
> >  	int				combined_irq;
> >-	atomic_t			sync_nr;
> >+	u32				sync_nr;
> >
> >  	unsigned long			ias; /* IPA */
> >  	unsigned long			oas; /* PA */
> >@@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
> >  	return 0;
> >  }
> >
> >+static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
> 
> If we *are* going to go down this route then I think it would make sense to
> move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e.
> arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync
> command, then calling this guy would convert it to an MSI-based one. As-is,
> having bits of mutually-dependent data handled across two separate places
> just seems too messy and error-prone.

Yeah, but I'd first like to see some number showing that doing all of this
under the lock actually has an impact.

Will
