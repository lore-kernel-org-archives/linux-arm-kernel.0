From: mgr@pengutronix.de (Michael Grzeschik)
Date: Sun, 29 Sep 2013 01:56:03 +0200
Subject: [[PATCH] 0/3] imx-dma: fixes
In-Reply-To: <1380004503.6145.16.camel@mars>
References: <1379426168-31989-1-git-send-email-m.grzeschik@pengutronix.de>
 <20130923041953.GA17188@intel.com> <1380004503.6145.16.camel@mars>
Message-ID: <20130928235603.GB25376@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Tue, Sep 24, 2013 at 08:35:03AM +0200, Christoph Fritz wrote:
> On Mon, 2013-09-23 at 09:49 +0530, Vinod Koul wrote:
> > On Tue, Sep 17, 2013 at 03:56:05PM +0200, Michael Grzeschik wrote:
> > > Hello,
> > > 
> > > this series is solving some lockdep issues in the imx-dma code.
> > > There are some list_head and deadlock issues in the code,
> > > that is running the implementation into unsafe situations.
> > Thanks for this, I have trying to fix this with testing done by Christoph. I had
> > similar set of fixes
> > 
> > Christoph can you pls try runnning this on your setup and check and we can apply
> > these
> 
> Thanks for the update, I added Michaels imx-dma patchset to Kernel
> 3.4.62 and gave it a shot:
> 
> In contrast to DMA-disabled, a 'dd' copy still results in a hung:
> 
>    dd if=/dev/zero of=/mnt/dd-test.bin count=102400 bs=1K
> 
> Please see the full log from boot to hung with DEBUG enabled below.
> With 2.6.31, copying to an SD-Card with DMA enabled works flawlessly,
> this log is also below.
> 
> Michael, any ideas? I suppose you have the same board?

The hardware we tested these patches for/with was custom hardware. But
yes, we have this board you refer. We will need to setup the same
situation first for debugging.

Did you realize that the stalling mem2dev transfer in 3.4.62
is generating this footprint:

> [   60.579646] imx-dma imx-dma: imxdma_xfer_desc channel: 0 sg=c70ff000 sgcount=8 total length=32768 dev_addr=0x10014038 (mem2dev)
> [   60.591192] imx-dma imx-dma:  imxdma_sg_next channel: 0 dst 0x10014038, src 0xa5527000, size 0x00001000
> [   60.600624] imx-dma imx-dma: imxdma_enable_hw channel 0
> [   60.605887] imx-dma imx-dma:  imxdma_sg_next channel: 0 dst 0x10014038, src 0xa5525000, size 0x00001000
> [   60.795424] imx-dma imx-dma: dma_irq_handler called, disr=0x00000001
> [   60.801857] imx-dma imx-dma:  imxdma_sg_next channel: 0 dst 0x10014038, src 0xa5523000, size 0x00001000
> [   61.290221] imx-dma imx-dma: channel 0: watchdog timeout!

Beside on 2.6.31 the same transfer results in no failure.

> [   55.270000] imxdma0: imx_dma_setup_sg sg=c7ae3800 sgcount=9 total length=32768 dev_addr=0x10014038 for write
> [   55.280000] imxdma0: next sg chunk dst 0x10014038, src 0xa73a1c00, size 0x00001000
> [   55.290000] imxdma0: imx_dma_enable
> [   55.290000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.290000] imxdma0: next sg chunk dst 0x10014038, src 0xa73a2c00, size 0x00000400
> [   55.300000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.300000] imxdma0: next sg chunk dst 0x10014038, src 0xa73a5000, size 0x00001000
> [   55.320000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.320000] imxdma0: next sg chunk dst 0x10014038, src 0xa73a7000, size 0x00001000
> [   55.330000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.330000] imxdma0: next sg chunk dst 0x10014038, src 0xa73a9000, size 0x00001000
> [   55.340000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.340000] imxdma0: next sg chunk dst 0x10014038, src 0xa73ab000, size 0x00001000
> [   55.360000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.360000] imxdma0: next sg chunk dst 0x10014038, src 0xa73ad000, size 0x00001000
> [   55.380000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.380000] imxdma0: next sg chunk dst 0x10014038, src 0xa73af000, size 0x00001000
> [   55.390000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.390000] imxdma0: next sg chunk dst 0x10014038, src 0xa73b1000, size 0x00000c00
> [   55.400000] imxdma: dma_irq_handler called, disr=0x00000001
> [   55.410000] imxdma0: imx_dma_disable

It looks suspicious that the same same transfer in the newer kernel should take
less amount of sg (sgcount=8 vs. sgcount=9) with the same amount of payload data.

I don't think this issue is related to the patch series I posted. But
anyway needs to be investigated.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
