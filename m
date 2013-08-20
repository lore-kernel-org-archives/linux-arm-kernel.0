From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 20 Aug 2013 13:57:50 +0530
Subject: [PATCH v2 2/2] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <CAMj5BkixUR2-MnYLVymPLnQ922jEhbKnwUHs__d3hr2d_Qb8fA@mail.gmail.com>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-3-git-send-email-zhangfei.gao@linaro.org>
 <20130813112043.GB32147@intel.com>
 <CAMj5Bki0H+=0wQY39+jDw4nAEq5wEq3V3yri9xpNRxQ2GRwPbA@mail.gmail.com>
 <20130819053511.GU32147@intel.com>
 <CAMj5BkixUR2-MnYLVymPLnQ922jEhbKnwUHs__d3hr2d_Qb8fA@mail.gmail.com>
Message-ID: <20130820082749.GG5810@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 03:55:05PM +0800, zhangfei gao wrote:
> There are many example keep define simple.
and there are others examples which have done the otherway. I would prefer that
way please!


> >> > why do we need the else part here?
> >> Since asynchronous mode is supported.
> >> Desc is submitted to list but may not get physical channel to run.
> > But when you pause you pause the running channel. You dont pause a descriptor.
> > So whatever you are trying to imply doesnt make sense to me.
> 
> Here delete node from chan_pending, which will be quired from tasklet.
> 
> The physical channel is free matched.
> dma_issue_pending will put node to d->k3_dma_issue_pending if no phy allocated.
> Tasklet do two jobs
> 1, check running channel for new request form desc_issued.
> 2, check any new chan_pending and alloc phy if available.
> 
> If no phy, the node will be put in chan_pending.
> If pause does not remove from chan_pending, it may be got from tasklet
> to start a new transaction.
> So it's safe to remove from chan_pending when pause, and add back when resume.
But when you add, where do you start from, from the start of the descriptor or
the previosu position.

The point is pause-resume you dont need to do all that. Channel is paused so
just pause it by stopping exuection, not more. Then you resume by asking
controller to start from where it left off.

~Vinod
