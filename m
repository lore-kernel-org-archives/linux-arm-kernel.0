From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 20 Aug 2013 15:55:05 +0800
Subject: [PATCH v2 2/2] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <20130819053511.GU32147@intel.com>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-3-git-send-email-zhangfei.gao@linaro.org>
 <20130813112043.GB32147@intel.com>
 <CAMj5Bki0H+=0wQY39+jDw4nAEq5wEq3V3yri9xpNRxQ2GRwPbA@mail.gmail.com>
 <20130819053511.GU32147@intel.com>
Message-ID: <CAMj5BkixUR2-MnYLVymPLnQ922jEhbKnwUHs__d3hr2d_Qb8fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 1:35 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Aug 15, 2013 at 01:54:28PM +0800, zhangfei gao wrote:
>> On Tue, Aug 13, 2013 at 7:20 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Fri, Jun 28, 2013 at 08:39:13PM +0800, Zhangfei Gao wrote:
>> >> Add dmaengine driver for hisilicon k3 platform based on virt_dma
>> >>
>> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> >> Tested-by: Kai Yang <jean.yangkai@huawei.com>
>> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> >> ---
>> >
>> >> +#define DRIVER_NAME          "k3-dma"
>> >> +#define DMA_ALIGN            3
>> >> +#define DMA_MAX_SIZE         0x1ffc
>> >> +
>> >> +#define INT_STAT             0x00
>> >> +#define INT_TC1                      0x04
>> >> +#define INT_ERR1             0x0c
>> >> +#define INT_ERR2             0x10
>> >> +#define INT_TC1_MASK         0x18
>> >> +#define INT_ERR1_MASK                0x20
>> >> +#define INT_ERR2_MASK                0x24
>> >> +#define INT_TC1_RAW          0x600
>> >> +#define INT_ERR1_RAW         0x608
>> >> +#define INT_ERR2_RAW         0x610
>> >> +#define CH_PRI                       0x688
>> >> +#define CH_STAT                      0x690
>> >> +#define CX_CUR_CNT           0x704
>> >> +#define CX_LLI                       0x800
>> >> +#define CX_CNT                       0x810
>> >> +#define CX_SRC                       0x814
>> >> +#define CX_DST                       0x818
>> >> +#define CX_CONFIG            0x81c
>> >> +#define AXI_CONFIG           0x820
>> >> +#define DEF_AXI_CONFIG               0x201201
>> >> +
>> >> +#define CX_LLI_CHAIN_EN              0x2
>> >> +#define CCFG_EN                      0x1
>> >> +#define CCFG_MEM2PER         (0x1 << 2)
>> >> +#define CCFG_PER2MEM         (0x2 << 2)
>> >> +#define CCFG_SRCINCR         (0x1 << 31)
>> >> +#define CCFG_DSTINCR         (0x1 << 30)
>> > I see these are not namespace aptly and can collide..
>> OK,
>> How about change name to
>> #define CX_CFG                 0x81c
> since you are calling your driver K3_DMA it would be apt to namespace all of the
> above with K3_INT_STAT to K3_CFG_EN and so on...

Sorry, does define of register need add name space?
Is it looks too long?

There are many example keep define simple.
drivers/dma/sa11x0-dma.c
#define DCSR_RUN        (1 << 0)
#define DCSR_IE         (1 << 1)
#define DCSR_ERROR      (1 << 2)

drivers/dma/mxs-dma.c
#define CCW_CHAIN               (1 << 2)
#define CCW_IRQ                 (1 << 3)
#define CCW_DEC_SEM             (1 << 6)

>
>>
>> #define CX_CFG_EN              0x1
>> #define CX_CFG_MEM2PER         (0x1 << 2)
>> ~

>> >
>> >> +     case DMA_PAUSE:
>> >> +             dev_dbg(d->slave.dev, "vchan %p: pause\n", &c->vc);
>> >> +             if (c->status == DMA_IN_PROGRESS) {
>> >> +                     c->status = DMA_PAUSED;
>> >> +                     if (p) {
>> >> +                             k3_dma_pause_dma(p, false);
>> >> +                     } else {
>> >> +                             spin_lock(&d->lock);
>> >> +                             list_del_init(&c->node);
>> >> +                             spin_unlock(&d->lock);
>> >> +                     }
>> > why do we need the else part here?
>> Since asynchronous mode is supported.
>> Desc is submitted to list but may not get physical channel to run.
> But when you pause you pause the running channel. You dont pause a descriptor.
> So whatever you are trying to imply doesnt make sense to me.

Here delete node from chan_pending, which will be quired from tasklet.

The physical channel is free matched.
dma_issue_pending will put node to d->k3_dma_issue_pending if no phy allocated.
Tasklet do two jobs
1, check running channel for new request form desc_issued.
2, check any new chan_pending and alloc phy if available.

If no phy, the node will be put in chan_pending.
If pause does not remove from chan_pending, it may be got from tasklet
to start a new transaction.
So it's safe to remove from chan_pending when pause, and add back when resume.
