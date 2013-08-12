From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 12 Aug 2013 11:22:36 +0530
Subject: [PATCH v3 07/12] dma: edma: Add function to dump a PaRAM set
 from PaRAM
In-Reply-To: <1375719297-12871-8-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
 <1375719297-12871-8-git-send-email-joelf@ti.com>
Message-ID: <52087824.60002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013 09:44 PM, Joel Fernandes wrote:
> Previously, such a dump function was used but it wasn't reading
> from the PaRAM, rather just from a edmacc_param structure, we
> add a helpful function for debugging that directly reads from
> the PaRAM and gives the current state correctly (including links
> and interrupt information).
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>

You should convert existing instances of PaRAM set dump to use this new
function along with introducing it.

Thanks,
Sekhar

> ---
>  drivers/dma/edma.c |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 080d669..a242269 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -102,6 +102,37 @@ static void edma_desc_free(struct virt_dma_desc *vdesc)
>  	kfree(container_of(vdesc, struct edma_desc, vdesc));
>  }
>  
> +static inline void dump_pset(struct edma_chan *echan, int slot,
> +		     struct edmacc_param *pset_unused, int pset_idx)
> +{
> +	struct edmacc_param pset_local, *pset;
> +	pset = &pset_local;
> +
> +	edma_read_slot(slot, pset);
> +
> +	dev_dbg(echan->vchan.chan.device->dev,
> +		"\n pset[%d]:\n"
> +		"  chnum\t%d\n"
> +		"  slot\t%d\n"
> +		"  opt\t%08x\n"
> +		"  src\t%08x\n"
> +		"  dst\t%08x\n"
> +		"  abcnt\t%08x\n"
> +		"  ccnt\t%08x\n"
> +		"  bidx\t%08x\n"
> +		"  cidx\t%08x\n"
> +		"  lkrld\t%08x\n",
> +		pset_idx, echan->ch_num, slot,
> +		pset[0].opt,
> +		pset[0].src,
> +		pset[0].dst,
> +		pset[0].a_b_cnt,
> +		pset[0].ccnt,
> +		pset[0].src_dst_bidx,
> +		pset[0].src_dst_cidx,
> +		pset[0].link_bcntrld);
> +}
> +
>  /* Dispatch a queued descriptor to the controller (caller holds lock) */
>  static void edma_execute(struct edma_chan *echan)
>  {
> 
