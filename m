From: robherring2@gmail.com (Rob Herring)
Date: Tue, 05 Mar 2013 03:43:52 -0600
Subject: [PATCH] dma: of-dma: return error when 'dma-cells' not found
In-Reply-To: <1362475531-32260-1-git-send-email-padma.v@samsung.com>
References: <1362475531-32260-1-git-send-email-padma.v@samsung.com>
Message-ID: <5135BE58.4040105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2013 03:25 AM, Padmavathi Venna wrote:
> This patch returns error when 'dma-cells' property not found
> in the corresponding device node. With out this change there
> is a crash in the generic dma incompatible platforms.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

NAK.

#dma-cells should be optional. It is not needed for platforms supporting
memory to memory transfers only and should therefore be optional. You
cannot assume the dtb can be updated and kernel changes need to work
with old dtbs. I've submitted patches to address this and fix the crash:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-February/028769.html

Rob
> ---
> 
> Based on Vinod Koul next branch.
> 
>  drivers/dma/of-dma.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index 69d04d2..46aca0d 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -92,6 +92,7 @@ int of_dma_controller_register(struct device_node *np,
>  				void *data)
>  {
>  	struct of_dma	*ofdma;
> +	const	 __be32 *ip;
>  	int		nbcells;
>  
>  	if (!np || !of_dma_xlate) {
> @@ -103,7 +104,12 @@ int of_dma_controller_register(struct device_node *np,
>  	if (!ofdma)
>  		return -ENOMEM;
>  
> -	nbcells = be32_to_cpup(of_get_property(np, "#dma-cells", NULL));
> +	ip = of_get_property(np, "#dma-cells", NULL);
> +	if (!ip)
> +		return -ENXIO;
> +
> +	nbcells = be32_to_cpup(ip);
> +
>  	if (!nbcells) {
>  		pr_err("%s: #dma-cells property is missing or invalid\n",
>  		       __func__);
> 
