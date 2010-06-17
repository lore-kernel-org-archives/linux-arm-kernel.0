From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 17 Jun 2010 21:59:18 +0200
Subject: mxcmmc driver hangs on sync
In-Reply-To: <45DEC573-1158-477E-A971-03CB4633F442@zepcam.com>
References: <20100615112936.5d03ce92@morgan>
	<20100615063142.GU17833@buzzloop.caiaq.de>
	<20100615152051.26e4589c@morgan>
	<20100615072237.GW17833@buzzloop.caiaq.de>
	<20100617163340.69409a3f@morgan>
	<45DEC573-1158-477E-A971-03CB4633F442@zepcam.com>
Message-ID: <20100617195918.GN17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 08:51:37PM +0200, Erik Oomen wrote:
> > On Tue, 15 Jun 2010 09:22:37 +0200
> > Daniel Mack <daniel@caiaq.de> wrote:
> >> On Tue, Jun 15, 2010 at 03:20:51PM +0800, Morgan Howe wrote:
> >>> On Tue, 15 Jun 2010 08:31:43 +0200
> >>> Daniel Mack <daniel@caiaq.de> wrote:
> >>>> On Tue, Jun 15, 2010 at 11:29:36AM +0800, Morgan Howe wrote:
> >>>>> With the older kernel this would hang on sync after a few
> >>>>> thousand loops, and much sooner if you ran 2 or 3 of these
> >>>>> processes at a time. I tried last night with the newer kernel
> >>>>> and kicking off 3 processes and after ~100-150 loops per
> >>>>> process I get this:
> >>>> 
> >>>> Which 'newer kernel' did you try?
> >>> 
> >>> Hey Daniel,
> >>> 
> >>> Sorry, I said current mainline, but actually it's 2.6.35-rc1.
> >> 
> >> Could you try two things:
> >> 
> >> a) build a kernel without MX2 DMA support
> >> b) try 2.6.34, as there were some updates to the mxcmmc driver after
> >>   2.6.34 which could be related
> 
> We've had the same problems for various kernels and mxcmmc modifications. The following fixed it.  We applied it to the 2.6.28 kernel and have been writing and reading *many* Gigabytes without a problem. 

Interesting. Did you try to push this back to mainline?

Daniel

> 
> diff --git a/arch/arm/plat-mxc/dma-mx1-mx2.c b/arch/arm/plat-mxc/dma-mx1-mx2.c
> index e16014b..f295d68 100644
> --- a/arch/arm/plat-mxc/dma-mx1-mx2.c
> +++ b/arch/arm/plat-mxc/dma-mx1-mx2.c
> @@ -653,7 +653,9 @@ static void dma_irq_handle_channel(int chno)
>  static irqreturn_t dma_irq_handler(int irq, void *dev_id)
>  {
>         int i, disr;
> +       unsigned long flags;
>  
> +       local_irq_save(flags); 
>  #ifdef CONFIG_ARCH_MX2
>         if (cpu_is_mx21() || cpu_is_mx27())
>                 dma_err_handler(irq, dev_id);
> @@ -669,7 +671,7 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
>                 if (disr & (1 << i))
>                         dma_irq_handle_channel(i);
>         }
> -
> +       local_irq_restore(flags);
>         return IRQ_HANDLED;
>  }
>  
> Regards,
>   Erik
> 
> 
