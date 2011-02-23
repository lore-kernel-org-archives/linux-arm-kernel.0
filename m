From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 23 Feb 2011 11:25:16 +0530
Subject: [PATCH v3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110223055709.GC20346@S2100-06.ap.freescale.net>
References: <1298283699-14635-1-git-send-email-shawn.guo@freescale.com>
	<1298433701.23371.236.camel@vkoul-udesk3>
	<20110223055709.GC20346@S2100-06.ap.freescale.net>
Message-ID: <1298440516.23371.258.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-02-23 at 11:27 +0530, Shawn Guo wrote:
> Hi Vinod,
> 
> Thanks for the review.
> 
> On Wed, Feb 23, 2011 at 09:31:41AM +0530, Koul, Vinod wrote:
> > On Mon, 2011-02-21 at 15:51 +0530, Shawn Guo wrote:
> > > This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> > > including apbh-dma and apbx-dma.
> > >
> > > * apbh-dma and apbx-dma are supported in the driver as two mxs-dma
> > >   instances.
> > >
> > > * apbh-dma is different between mx23 and mx28, hardware version
> > >   register is used to differentiate.
> > >
> > > * mxs-dma supports pio function besides data transfer.  The driver
> > >   uses dma_data_direction DMA_NONE to identify the pio mode, and
> > >   steals sgl and sg_len to get pio words and numbers from clients.
> > >
> > > * mxs dmaengine has some very specific features, like sense function
> > >   and the special NAND support (nand_lock, nand_wait4ready).  These
> > >   are too specific to implemented in generic dmaengine driver.
> > >
> > > * The driver refers to imx-sdma and only a single descriptor is
> > >   statically assigned to each channel.
> > >
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > ---
> > >  arch/arm/mach-mxs/include/mach/dma.h |   26 ++
> > >  drivers/dma/Kconfig                  |    8 +
> > >  drivers/dma/Makefile                 |    1 +
> > >  drivers/dma/mxs-dma.c                |  719 ++++++++++++++++++++++++++++++++++
> > >  4 files changed, 754 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
> > >  create mode 100644 drivers/dma/mxs-dma.c
> > [snip]
> >
> > > +#define MXS_DMA_APBH           0
> > > +#define MXS_DMA_APBX           1
> > > +#define dma_is_apbh()          (mxs_dma->dev_id == MXS_DMA_APBH)
> > > +
> > > +#define APBH_VERSION_LATEST    3
> > > +#define apbh_is_old()          (mxs_dma->version < APBH_VERSION_LATEST)
> > > +
> > > +#define HW_APBHX_CTRL0                         0x000
> > > +#define  BM_APBH_CTRL0_APB_BURST8_EN           (1 << 29)
> > > +#define  BM_APBH_CTRL0_APB_BURST_EN            (1 << 28)
> > > +#define  BP_APBH_CTRL0_CLKGATE_CHANNEL         (8)
> > > +#define  BP_APBH_CTRL0_RESET_CHANNEL           (16)
> > can you please use consistent spacing here...
> >
> I thought it's a little bit easier to read these BM/BP defined
> against the register HW_......
> 
> > > +#define HW_APBHX_CTRL1                         0x010
> > > +#define HW_APBHX_CTRL2                         0x020
> > > +#define HW_APBHX_CHANNEL_CTRL                  0x030
> > > +#define  BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL   (16)
> > > +#define HW_APBH_VERSION                                (cpu_is_mx23() ? 0x3f0 : 0x800)
> > > +#define HW_APBX_VERSION                                0x800
> > > +#define  BP_APBHX_VERSION_MAJOR                        (24)
> > same here, with alignment as well please
> 
> ditto
Typically you can split the sections for HW_xxx and BP_xx with a space
line. This is more of a cosmetic change, I am not going to hold the
patch for this.

> > > +static void mxs_dma_tasklet(unsigned long data)
> > > +{
> > > +       struct mxs_dma_chan *mxs_chan = (struct mxs_dma_chan *) data;
> > > +
> > > +        if (mxs_chan->desc.callback)
> > > +                mxs_chan->desc.callback(mxs_chan->desc.callback_param);
> > > +}
> > any reason why you are using tasklet? Since these kind of DMA operations
> > need very fast and efficient interrupt handling, I feel the threaded irq
> > are the best approach?
> 
> There was some discussion on this.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041251.html
Well in that case you are calling the callback from irq handler which is
not so good. The tasklet is other extreme (slow). Given that this is
also intended for audio I am not sure if calling period elapsed from
tasklet callback will not cause any audio over/underruns, last I tried
it used to break quite often in stressed situations.
A threaded irq gives you a kernel thread for processing and calling the
callback but doesnt block your irq handler.
> 
> > > +
> > > +static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
> > > +{
> > > +       struct mxs_dma_engine *mxs_dma = dev_id;
> > > +       u32 stat1, stat2;
> > > +
> > > +       /* completion status */
> > > +       stat1 = readl(mxs_dma->base + HW_APBHX_CTRL1);
> > > +       stat1 &= 0xffff;
> > Magic number?
> >
> Define macro instead?
Sound reasonable

> 
> > > +       writel(stat1, mxs_dma->base + HW_APBHX_CTRL1 + MXS_CLR_ADDR);
> > > +
> > > +       /* error status */
> > > +       stat2 = readl(mxs_dma->base + HW_APBHX_CTRL2);
> > > +       writel(stat2, mxs_dma->base + HW_APBHX_CTRL2 + MXS_CLR_ADDR);
> > > +
> > > +       /*
> > > +        * When both completion and error of termination bits set at the
> > > +        * same time, we do not take it as an error.  IOW, it only becomes
> > > +        * an error we need to handler here in case of ether it's an bus
> > > +        * error or a termination error with no completion.
> > > +        */
> > > +       stat2 = ((stat2 >> 16) & stat2) |          /* bus error */
> > > +               (~(stat2 >> 16) & stat2 & ~stat1); /* termination with no completion */
> > > +
> > > +       /* combine error and completion status for checking */
> > > +       stat1 = (stat2 << 16) | stat1;
> > would it be possible for you to avoid these magic number, will help you
> > when you add more controllers...
> >
> I really do not see the possibility to add more controllers into this
> driver, but I can define macro instead if you are uncomfortable with
> them.
Thats today, how about 2-3 years down the line when you have similar
controllers for future rev of this. Writing new driver for next gen in
not a good idea

-- 
~Vinod
