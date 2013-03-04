From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 Mar 2013 10:22:57 +0530
Subject: drivers/dma/dw_dmac.c:1278:48: sparse: incorrect type in
 argument 1 (different base types)
In-Reply-To: <201303032051.28444.arnd@arndb.de>
References: <5133ae8b.eQXjkB7tQEqiUMck%fengguang.wu@intel.com>
 <201303032051.28444.arnd@arndb.de>
Message-ID: <20130304045257.GC22513@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 03, 2013 at 08:51:28PM +0000, Arnd Bergmann wrote:
> On Sunday 03 March 2013, kbuild test robot wrote:
> > >> drivers/dma/dw_dmac.c:1278:48: sparse: incorrect type in argument 1 (different base types)
> >    drivers/dma/dw_dmac.c:1278:48:    expected restricted __be32 const [usertype] *p
> >    drivers/dma/dw_dmac.c:1278:48:    got unsigned int *
> > >> drivers/dma/dw_dmac.c:1279:48: sparse: incorrect type in argument 1 (different base types)
> >    drivers/dma/dw_dmac.c:1279:48:    expected restricted __be32 const [usertype] *p
> >    drivers/dma/dw_dmac.c:1279:48:    got unsigned int *
> > >> drivers/dma/dw_dmac.c:1280:48: sparse: incorrect type in argument 1 (different base types)
> >    drivers/dma/dw_dmac.c:1280:48:    expected restricted __be32 const [usertype] *p
> >    drivers/dma/dw_dmac.c:1280:48:    got unsigned int *
> > 
> 
> Cool, thanks for the notification! That is a real bug, the variables
> are already endian swapped at this point.
> 
> Fortunately, nothing is using that code at this moment, so we can fix
> this with no hurry.
> 
> Vinod, could you apply this patch?
Done, applied to fixes. Will send to Linus before I leave for vacation on Thu.
Updated change log with reported-by & typo fix
> 
> 	Arnd
> 
> 8<-------
> Subject: [PATCH] dmaengine: dw_dma: fix endianess for DT xlate function
> 
> As reported by Wu Fengguang's build robot tracking sparse warnings, the
> dma_spec arguments in the dw_dma_xlate are already byte swapped on
> littl-endian platforms and must not get swapped again. This code is
> currently not used anywhere, but will be used in Linux 3.10 when the
> ARM SPEAr platform starts using the generic DMA DT binding.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index c599558..eb81ec9 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -1276,9 +1276,9 @@ static struct dma_chan *dw_dma_xlate(struct of_phandle_args *dma_spec,
>  	if (dma_spec->args_count != 3)
>  		return NULL;
>  
> -	fargs.req = be32_to_cpup(dma_spec->args+0);
> -	fargs.src = be32_to_cpup(dma_spec->args+1);
> -	fargs.dst = be32_to_cpup(dma_spec->args+2);
> +	fargs.req = dma_spec->args[0];
> +	fargs.src = dma_spec->args[1];
> +	fargs.dst = dma_spec->args[2];
>  
>  	if (WARN_ON(fargs.req >= DW_DMA_MAX_NR_REQUESTS ||
>  		    fargs.src >= dw->nr_masters ||
