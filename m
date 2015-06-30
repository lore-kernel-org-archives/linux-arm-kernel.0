From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Jun 2015 14:49:37 +0200
Subject: [PATCH v2 1/1] dmaengine: at_xdmac: fix transfer data width in
 at_xdmac_prep_slave_sg()
In-Reply-To: <32f90f9820ddf6412a637cdf3fda4e284a7854d1.1435667600.git.cyrille.pitchen@atmel.com>
References: <32f90f9820ddf6412a637cdf3fda4e284a7854d1.1435667600.git.cyrille.pitchen@atmel.com>
Message-ID: <55929061.2090905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/06/2015 14:36, Cyrille Pitchen a ?crit :
> This patch adds the missing update of the transfer data width in
> at_xdmac_prep_slave_sg().
> 
> Indeed, for each item in the scatter-gather list, we check whether the
> transfer length is aligned with the data width provided by
> dmaengine_slave_config(). If so, we directly use this data width for the
> current part of the transfer we are preparing. Otherwise, the data width
> is reduced to 8 bits (1 byte). Of course, the actual number of register
> accesses must also be updated to match the new data width.
> 
> So one chunk was missing in the original patch (see Fixes tag below): the
> number of register accesses was correctly set to (len >> fixed_dwidth) in
> mbr_ubc but the real data width was not updated in mbr_cfg. Since mbr_cfg
> may change for each part of the scatter-gather transfer this also explains
> why the original patch used the Descriptor View 2 instead of the
> Descriptor View 1.
> 
> Let's take the example of a DMA transfer to write 8bit data into an Atmel
> USART with FIFOs. When FIFOs are enabled in the USART, its Transmit
> Holding Register (THR) works in multidata mode, that is to say that up to
> 4 8bit data can be written into the THR in a single 32bit access and it is
> still possible to write only one data with a 8bit access. To take
> advantage of this new feature, the DMA driver was modified to allow
> multiple dwidths when doing slave transfers.
> For instance, when the total length is 22 bytes, the USART driver splits
> the transfer into 2 parts:
> 
> First part: 20 bytes transferred through 5 32bit writes into THR
> Second part: 2 bytes transferred though 2 8bit writes into THR
> 
> For the second part, the data width was first set to 4_BYTES by the USART
> driver thanks to dmaengine_slave_config() then at_xdmac_prep_slave_sg()
> reduces this data width to 1_BYTE because the 2 byte length is not aligned
> with the original 4_BYTES data width. Since the data width is modified,
> the actual number of writes into THR must be set accordingly.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Fixes: 6d3a7d9e3ada ("dmaengine: at_xdmac: allow muliple dwidths when doing slave transfers")
> Cc: stable at vger.kernel.org #4.0 and later

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> ChangeLog
> 
> v2:
> - reword commit message: add Fixes and Cc tags
> 
> v1:
> 
>  drivers/dma/at_xdmac.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index cf1213de7865..931b2183e2a7 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -681,15 +681,16 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  			desc->lld.mbr_sa = mem;
>  			desc->lld.mbr_da = atchan->sconfig.dst_addr;
>  		}
> -		desc->lld.mbr_cfg = atchan->cfg;
> -		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
> +		dwidth = at_xdmac_get_dwidth(atchan->cfg);
>  		fixed_dwidth = IS_ALIGNED(len, 1 << dwidth)
> -			       ? at_xdmac_get_dwidth(desc->lld.mbr_cfg)
> +			       ? dwidth
>  			       : AT_XDMAC_CC_DWIDTH_BYTE;
>  		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV2			/* next descriptor view */
>  			| AT_XDMAC_MBR_UBC_NDEN					/* next descriptor dst parameter update */
>  			| AT_XDMAC_MBR_UBC_NSEN					/* next descriptor src parameter update */
>  			| (len >> fixed_dwidth);				/* microblock length */
> +		desc->lld.mbr_cfg = (atchan->cfg & ~AT_XDMAC_CC_DWIDTH_MASK) |
> +				    AT_XDMAC_CC_DWIDTH(fixed_dwidth);
>  		dev_dbg(chan2dev(chan),
>  			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
>  			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
> 


-- 
Nicolas Ferre
