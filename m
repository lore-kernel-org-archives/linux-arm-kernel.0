From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 19 Aug 2013 11:05:11 +0530
Subject: [PATCH v2 2/2] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <CAMj5Bki0H+=0wQY39+jDw4nAEq5wEq3V3yri9xpNRxQ2GRwPbA@mail.gmail.com>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-3-git-send-email-zhangfei.gao@linaro.org>
 <20130813112043.GB32147@intel.com>
 <CAMj5Bki0H+=0wQY39+jDw4nAEq5wEq3V3yri9xpNRxQ2GRwPbA@mail.gmail.com>
Message-ID: <20130819053511.GU32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 01:54:28PM +0800, zhangfei gao wrote:
> On Tue, Aug 13, 2013 at 7:20 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Fri, Jun 28, 2013 at 08:39:13PM +0800, Zhangfei Gao wrote:
> >> Add dmaengine driver for hisilicon k3 platform based on virt_dma
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >> Tested-by: Kai Yang <jean.yangkai@huawei.com>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >
> >> +#define DRIVER_NAME          "k3-dma"
> >> +#define DMA_ALIGN            3
> >> +#define DMA_MAX_SIZE         0x1ffc
> >> +
> >> +#define INT_STAT             0x00
> >> +#define INT_TC1                      0x04
> >> +#define INT_ERR1             0x0c
> >> +#define INT_ERR2             0x10
> >> +#define INT_TC1_MASK         0x18
> >> +#define INT_ERR1_MASK                0x20
> >> +#define INT_ERR2_MASK                0x24
> >> +#define INT_TC1_RAW          0x600
> >> +#define INT_ERR1_RAW         0x608
> >> +#define INT_ERR2_RAW         0x610
> >> +#define CH_PRI                       0x688
> >> +#define CH_STAT                      0x690
> >> +#define CX_CUR_CNT           0x704
> >> +#define CX_LLI                       0x800
> >> +#define CX_CNT                       0x810
> >> +#define CX_SRC                       0x814
> >> +#define CX_DST                       0x818
> >> +#define CX_CONFIG            0x81c
> >> +#define AXI_CONFIG           0x820
> >> +#define DEF_AXI_CONFIG               0x201201
> >> +
> >> +#define CX_LLI_CHAIN_EN              0x2
> >> +#define CCFG_EN                      0x1
> >> +#define CCFG_MEM2PER         (0x1 << 2)
> >> +#define CCFG_PER2MEM         (0x2 << 2)
> >> +#define CCFG_SRCINCR         (0x1 << 31)
> >> +#define CCFG_DSTINCR         (0x1 << 30)
> > I see these are not namespace aptly and can collide..
> OK,
> How about change name to
> #define CX_CFG                 0x81c
since you are calling your driver K3_DMA it would be apt to namespace all of the
above with K3_INT_STAT to K3_CFG_EN and so on...

> 
> #define CX_CFG_EN              0x1
> #define CX_CFG_MEM2PER         (0x1 << 2)
> ~
> 
> >> +             switch (width) {
> >> +             case DMA_SLAVE_BUSWIDTH_1_BYTE:
> >> +                     val = 0;
> >> +                     break;
> >> +             case DMA_SLAVE_BUSWIDTH_2_BYTES:
> >> +                     val = 1;
> >> +                     break;
> >> +             case DMA_SLAVE_BUSWIDTH_4_BYTES:
> >> +                     val = 2;
> >> +                     break;
> >> +             case DMA_SLAVE_BUSWIDTH_8_BYTES:
> >> +                     val = 3;
> > DMA_SLAVE_BUSWIDTHS are 1, 2, 4, 8...
> > so if you can do val = ffs(width) as well?
> 
> Good idea, will use __ffs(width) here.
> 
> >
> >
> >> +     case DMA_PAUSE:
> >> +             dev_dbg(d->slave.dev, "vchan %p: pause\n", &c->vc);
> >> +             if (c->status == DMA_IN_PROGRESS) {
> >> +                     c->status = DMA_PAUSED;
> >> +                     if (p) {
> >> +                             k3_dma_pause_dma(p, false);
> >> +                     } else {
> >> +                             spin_lock(&d->lock);
> >> +                             list_del_init(&c->node);
> >> +                             spin_unlock(&d->lock);
> >> +                     }
> > why do we need the else part here?
> Since asynchronous mode is supported.
> Desc is submitted to list but may not get physical channel to run.
But when you pause you pause the running channel. You dont pause a descriptor.
So whatever you are trying to imply doesnt make sense to me.

~Vinod
