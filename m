From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 5 Jan 2012 09:56:10 +0800
Subject: [PATCH v2 2/2] dma/imx-sdma: add wmb before enable a channel
In-Reply-To: <20120104023157.GJ2414@b20223-02.ap.freescale.net>
References: <1325428692-11473-1-git-send-email-richard.zhao@linaro.org>
 <1325428692-11473-3-git-send-email-richard.zhao@linaro.org>
 <20120103174639.GF2914@n2100.arm.linux.org.uk>
 <20120104023157.GJ2414@b20223-02.ap.freescale.net>
Message-ID: <20120105015609.GN2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Jan 04, 2012 at 10:31:58AM +0800, Richard Zhao wrote:
> On Tue, Jan 03, 2012 at 05:46:39PM +0000, Russell King - ARM Linux wrote:
> > On Sun, Jan 01, 2012 at 10:38:12PM +0800, Richard Zhao wrote:
> > > dma_alloc_coherent memory may be bufferable. We need to add
> > > nececcary memory barrier.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > ---
> > >  drivers/dma/imx-sdma.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > index f8e87b5..9301bff 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -394,6 +394,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
> > >  
> > >  static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
> > >  {
> > > +	wmb();
> > >  	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
> > 
> > Use writel().  That's what it's there for:
> > 
> > #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
> > #define __iowmb()               wmb()
> > #endif
> > #define writel_relaxed(v,c)     ((void)__raw_writel((__force u32) \
> >                                         cpu_to_le32(v),__mem_pci(c)))
> > #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
> Why does writel always call wmb? ioremap memory needs mb too?
> Isn't it supposed to be when there's prior touch of dma memory? 
What do you think?

Thanks
Richard
> 
> Thanks
> Richard
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
