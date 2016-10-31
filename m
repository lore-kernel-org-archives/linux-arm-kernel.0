From: eric@anholt.net (Eric Anholt)
Date: Mon, 31 Oct 2016 11:36:31 -0700
Subject: [PATCH] staging: vc04_services: setup DMA and coherent mask
In-Reply-To: <20161028171159.23973-1-mzoran@crowfest.net>
References: <20161028171159.23973-1-mzoran@crowfest.net>
Message-ID: <87twbsqsb4.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Zoran <mzoran@crowfest.net> writes:

> Setting the DMA mask is optional on 32 bit but
> is mandatory on 64 bit.  Set the DMA mask and coherent
> to force all DMA to be in the 32 bit address space.
>
> This is considered a "good practice" and most drivers
> already do this.
>
> Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> index a5afcc5..6fa2b5a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> @@ -97,6 +97,16 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
>  	int slot_mem_size, frag_mem_size;
>  	int err, irq, i;
>  
> +	/*
> +	 * Setting the DMA mask is necessary in the 64 bit environment.
> +	 * It isn't necessary in a 32 bit environment but is considered
> +	 * a good practice.
> +	 */
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));

I think a better comment here would be simply:

/* VCHI messages between the CPU and firmware use 32-bit bus addresses. */

explaining why the value is chosen (once you know that the 32 bit
restriction exists, reporting it is obviously needed).  I'm curious,
though: what failed when you didn't set it?

> +
> +	if (err < 0)
> +		return err;
> +
>  	(void)of_property_read_u32(dev->of_node, "cache-line-size",
>  				   &g_cache_line_size);
>  	g_fragments_size = 2 * g_cache_line_size;
> -- 
> 2.10.1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161031/9e41b8fa/attachment.sig>
