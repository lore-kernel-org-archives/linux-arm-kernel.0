From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 20 Aug 2013 21:36:50 +0800
Subject: [PATCH v2 2/2] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <20130820085037.GH5810@intel.com>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-3-git-send-email-zhangfei.gao@linaro.org>
 <20130813112043.GB32147@intel.com>
 <CAMj5Bki0H+=0wQY39+jDw4nAEq5wEq3V3yri9xpNRxQ2GRwPbA@mail.gmail.com>
 <20130819053511.GU32147@intel.com>
 <CAMj5BkixUR2-MnYLVymPLnQ922jEhbKnwUHs__d3hr2d_Qb8fA@mail.gmail.com>
 <20130820082749.GG5810@intel.com> <5213359B.4070208@linaro.org>
 <20130820085037.GH5810@intel.com>
Message-ID: <CAMj5Bkg_uQUgod0Cf9ZpLgX92Ys-u344BAFeHbrUwysG3pJVgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 4:50 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Aug 20, 2013 at 05:23:39PM +0800, zhangfei wrote:
>> >>>>>why do we need the else part here?
>> >>>>Since asynchronous mode is supported.
>> >>>>Desc is submitted to list but may not get physical channel to run.
>> >>>But when you pause you pause the running channel. You dont pause a descriptor.
>> >>>So whatever you are trying to imply doesnt make sense to me.
>> >>
>> >>Here delete node from chan_pending, which will be quired from tasklet.
>> >>
>> >>The physical channel is free matched.
>> >>dma_issue_pending will put node to d->k3_dma_issue_pending if no phy allocated.
>> >>Tasklet do two jobs
>> >>1, check running channel for new request form desc_issued.
>> >>2, check any new chan_pending and alloc phy if available.
>> >>
>> >>If no phy, the node will be put in chan_pending.
>> >>If pause does not remove from chan_pending, it may be got from tasklet
>> >>to start a new transaction.
>> >>So it's safe to remove from chan_pending when pause, and add back when resume.
>> >But when you add, where do you start from, from the start of the descriptor or
>> >the previosu position.
>> >
>> >The point is pause-resume you dont need to do all that. Channel is paused so
>> >just pause it by stopping exuection, not more. Then you resume by asking
>> >controller to start from where it left off.
>>
>> Since it is async mode, it does not know the physical channel is
>> really started or not.
>>
>> When desc is submitted, it can be
>> a). get phy and run, pause can stop and resume where it stops.
>> b). Dot not start at all since no phy available (16 phys vs 27
>> request line), if pause do nothing it will stay in chan_pending, if
>> tasklet happens again, it will be fetched and started, while upper
>> layer thought it is already paused.
>>
>> Do we need consider case b?
> and how do you handle when the desc is running on a phy.

Currently k3dma is used with uart.

drivers/tty/serial/amba-pl011.c
pl011_dma_rx_irq: dmaengine_pause -> device_tx_status
First pause channel, then get residue.
k3_dma_tx_status:
a) if desc in issue queue, then it still not started, return total size.
b) otherwise get the residue via counting descriptor.
pl011 get the residue and recaculate the pending.

Have pass the stress test with amba-pl011.

Thanks
