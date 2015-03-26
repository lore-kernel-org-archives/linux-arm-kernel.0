From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 17:05:38 +0000
Subject: [PATCH 3/3] dma: at_xdmac: make all descriptors little endian
In-Reply-To: <1427375191-1467-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427375191-1467-4-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150326170538.GA19688@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 01:06:31PM +0000, Ben Dooks wrote:
> Always write the descriptors for the at_xdmac in little endian when
> the processor is running big endian.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
> CC: Vinod Koul <vinod.koul@intel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: linux-arm-kernel at lists.infradead.org
> CC: dmaengine at vger.kernel.org
> ---
>  drivers/dma/at_xdmac.c | 97 ++++++++++++++++++++++++++------------------------
>  1 file changed, 51 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index d9891d3..65a37be 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -232,10 +232,10 @@ struct at_xdmac {
>  /* Linked List Descriptor */
>  struct at_xdmac_lld {
>  	dma_addr_t	mbr_nda;	/* Next Descriptor Member */
> -	u32		mbr_ubc;	/* Microblock Control Member */
> +	__le32		mbr_ubc;	/* Microblock Control Member */
>  	dma_addr_t	mbr_sa;		/* Source Address Member */
>  	dma_addr_t	mbr_da;		/* Destination Address Member */
> -	u32		mbr_cfg;	/* Configuration Register */
> +	__le32		mbr_cfg;	/* Configuration Register */
>  };

This /really/ is not correct if this structure is describing something
parsed by the hardware - I mean, your patch itself may be correct
but it's showing that there's more problems here.

The reason is those dma_addr_t's.  dma_addr_t can be either 32-bit or
64-bit depending on the kernel configuration, and I really suspect that
the hardware doesn't get to know how the kernel was configured.  That
goes for any structure which is passed to hardware - dma_addr_t should
never appear in it _anywhere_.

As you're converting it to __le32, I suspec those DMA addresses are
also supposed to be __le32 quantities as well.

> +			desc->lld.mbr_sa = cpu_to_le32(atchan->per_src_addr);
> +			desc->lld.mbr_da = cpu_to_le32(mem);

This kind'a confirms it - but what happens to the above if dma_addr_t
is 64-bit and has some high bits set?  Should be silently truncate the
value?

>  		dev_dbg(chan2dev(chan),
>  			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
>  			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
>  
>  		/* Chain lld. */
>  		if (prev) {
> -			prev->lld.mbr_nda = desc->tx_dma_desc.phys;
> +			prev->lld.mbr_nda = cpu_to_le32(desc->tx_dma_desc.phys);

Another point to be raised with the original authors... get rid of this
"phys" notation.  It's not physical.  It's an address which is specific
to the DMA controller, but which _may_ happen to be the same as a
physical address.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
