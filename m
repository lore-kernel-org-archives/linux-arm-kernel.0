From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 12 Aug 2013 11:26:49 +0530
Subject: [PATCH v3 08/12] dma: edma: Add one more required slot to MAX
 slots
In-Reply-To: <1375719297-12871-9-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
 <1375719297-12871-9-git-send-email-joelf@ti.com>
Message-ID: <52087921.8040101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013 09:44 PM, Joel Fernandes wrote:
> We'd now need a separate slot just for the channel and separate
> ones for the 2 linked sets, so we make adjustments to allocate
> an extra channel accordingly.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>

No need for a separate patch for this, just do this in the patch where
you include the two linked sets.

> ---
>  drivers/dma/edma.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index a242269..df50a04 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -48,7 +48,7 @@
>  
>  /* Max of 16 segments per channel to conserve PaRAM slots */
>  #define MAX_NR_SG		16
> -#define EDMA_MAX_SLOTS		MAX_NR_SG
> +#define EDMA_MAX_SLOTS		(MAX_NR_SG+1)
>  #define EDMA_DESCRIPTORS	16
>  
>  struct edma_desc {
> @@ -311,6 +311,9 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>  
>  	num_slots_needed = sg_len > MAX_NR_SG ? MAX_NR_SG : sg_len;
>  
> +	/* Allocate one extra to account for the channel itself */
> +	num_slots_needed++;

You can do:

	nslots = min(MAX_NR_SG, sg_len) + 1;

Thanks,
Sekhar
