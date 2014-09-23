From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 23 Sep 2014 17:18:43 +0000
Subject: [PATCH] dmaengine: fsl-edma: fixup reg offset and hw S/G support
 in big-endian model
In-Reply-To: <45444544.Xl4NeUiTm0@wuerfel>
References: <1411463719-7728-1-git-send-email-jingchang.lu@freescale.com>,
 <45444544.Xl4NeUiTm0@wuerfel>
Message-ID: <1411492720444.3205@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

________________________________________
From: Arnd Bergmann <arnd@arndb.de>
Sent: Tuesday, September 23, 2014 8:30 PM
To: linux-arm-kernel at lists.infradead.org
Cc: Lu Jingchang-B35083; vinod.koul at intel.com; dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: fixup reg offset and hw S/G support in big-endian model

On Tuesday 23 September 2014 17:15:19 Jingchang Lu wrote:
> @@ -459,20 +480,27 @@ static void fill_tcd_params(struct fsl_edma_engine *edma,
>         u16 csr = 0;
>
>         /*
> -        * eDMA hardware SGs require the TCD parameters stored in memory
> -        * the same endian as the eDMA module so that they can be loaded
> -        * automatically by the engine
> +        * eDMA hardware SGs requires the TCDs to be auto loaded
> +        * in the same endian as the core whenver the eDAM engine's
> +        * register endian. So we don't swap the value, waitting
> +        * for fsl_set_tcd_params doing the swap.
>          */

This makes no sense: how would the eDMA hardware know what endianess
the CPU is using to write this data? Have you tried this running on
the same hardware with both big-endian and little-endian kernels?

Also, you access this as little-endian data unconditionally rather
than cpu-endian as the comment suggests, maybe that is what you meant
here?

I will rewrite this comment, thanks.

> -       edma_writel(edma, src, &(tcd->saddr));
> -       edma_writel(edma, dst, &(tcd->daddr));
> -       edma_writew(edma, attr, &(tcd->attr));
> -       edma_writew(edma, EDMA_TCD_SOFF_SOFF(soff), &(tcd->soff));
> -       edma_writel(edma, EDMA_TCD_NBYTES_NBYTES(nbytes), &(tcd->nbytes));
> -       edma_writel(edma, EDMA_TCD_SLAST_SLAST(slast), &(tcd->slast));
> -       edma_writew(edma, EDMA_TCD_CITER_CITER(citer), &(tcd->citer));
> -       edma_writew(edma, EDMA_TCD_DOFF_DOFF(doff), &(tcd->doff));
> -       edma_writel(edma, EDMA_TCD_DLAST_SGA_DLAST_SGA(dlast_sga), &(tcd->dlast_sga));
> -       edma_writew(edma, EDMA_TCD_BITER_BITER(biter), &(tcd->biter));
> +       writel(src, &(tcd->saddr));
> +       writel(dst, &(tcd->daddr));
> +
> +       writew(attr, &(tcd->attr));

You seem to have another preexisting bug: The tcd pointer actually does not
point to mmio registers here at all, but instead points to memory that
has been returned from dma_pool_alloc. It is not valid to use writel()
on such memory, that is only meant to work on real MMIO registers.

You should use regular assignments to the registers here, e.g.

        tcd->saddr = cpu_to_le32(src);
        tcd->daddr = cpu_to_le32(dst);
        ...

        Arnd

I will reconsider this setting. BTW, why writel() can't be used for memory location since it's still mapped and registers space is
also memory mapped? Thanks.

Best Regards,
Jingchang
