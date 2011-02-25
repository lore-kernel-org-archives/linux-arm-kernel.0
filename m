From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 25 Feb 2011 19:11:50 +0800
Subject: [PATCH v4] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110225105530.GA2178@pengutronix.de>
References: <1298619259-14344-1-git-send-email-shawn.guo@freescale.com>
	<20110225105530.GA2178@pengutronix.de>
Message-ID: <20110225111149.GB13684@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 25, 2011 at 11:55:30AM +0100, Wolfram Sang wrote:
> Hi Shawn,
> 
Hi Wolfram,

> On Fri, Feb 25, 2011 at 03:34:19PM +0800, Shawn Guo wrote:
> > This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> > including apbh-dma and apbx-dma.
> > 
> > * apbh-dma and apbx-dma are supported in the driver as two mxs-dma
> >   instances.
> > 
> > * apbh-dma is different between mx23 and mx28, hardware version
> >   register is used to differentiate.
> > 
> > * mxs-dma supports pio function besides data transfer.  The driver
> >   uses dma_data_direction DMA_NONE to identify the pio mode, and
> >   steals sgl and sg_len to get pio words and numbers from clients.
> > 
> > * mxs dmaengine has some very specific features, like sense function
> >   and the special NAND support (nand_lock, nand_wait4ready).  These
> >   are too specific to implemented in generic dmaengine driver.
> > 
> > * The driver refers to imx-sdma and only a single descriptor is
> >   statically assigned to each channel.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> 
> What are (roughly) the changes since last version?
> 
Sorry, I did not give the change log.  Basically, it addressed the
comments below from Vinod and Lothar on v3.

======
> +#define HW_APBHX_CTRL0                         0x000
> +#define  BM_APBH_CTRL0_APB_BURST8_EN           (1 << 29)
> +#define  BM_APBH_CTRL0_APB_BURST_EN            (1 << 28)
> +#define  BP_APBH_CTRL0_CLKGATE_CHANNEL         (8)
> +#define  BP_APBH_CTRL0_RESET_CHANNEL           (16)
can you please use consistent spacing here...

> +static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
> +{
> +       struct mxs_dma_engine *mxs_dma = dev_id;
> +       u32 stat1, stat2;
> +
> +       /* completion status */
> +       stat1 = readl(mxs_dma->base + HW_APBHX_CTRL1);
> +       stat1 &= 0xffff;
Magic number?

> +       writel(stat1, mxs_dma->base + HW_APBHX_CTRL1 + MXS_CLR_ADDR);
> +
> +       /* error status */
> +       stat2 = readl(mxs_dma->base + HW_APBHX_CTRL2);
> +       writel(stat2, mxs_dma->base + HW_APBHX_CTRL2 + MXS_CLR_ADDR);
> +
> +       /*
> +        * When both completion and error of termination bits set at the
> +        * same time, we do not take it as an error.  IOW, it only becomes
> +        * an error we need to handler here in case of ether it's an bus
> +        * error or a termination error with no completion.
> +        */
> +       stat2 = ((stat2 >> 16) & stat2) |          /* bus error */
> +               (~(stat2 >> 16) & stat2 & ~stat1); /* termination with no completion */
> +
> +       /* combine error and completion status for checking */
> +       stat1 = (stat2 << 16) | stat1;
would it be possible for you to avoid these magic number, will help you
when you add more controllers...

> > > +#define HW_APBHX_CTRL0                         0x000
> > > +#define  BM_APBH_CTRL0_APB_BURST8_EN           (1 << 29)
> > > +#define  BM_APBH_CTRL0_APB_BURST_EN            (1 << 28)
> > > +#define  BP_APBH_CTRL0_CLKGATE_CHANNEL         (8)
> > > +#define  BP_APBH_CTRL0_RESET_CHANNEL           (16)
>
There is no need to enclose bare number in macro definitions in
parenthesis.
...
=======

-- 
Regards,
Shawn
