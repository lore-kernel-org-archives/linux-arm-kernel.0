From: computersforpeace@gmail.com (Brian Norris)
Date: Sat, 9 Jul 2016 17:56:14 -0700
Subject: [PATCH 2/2] mtd: nand: omap2: Add check for old elm binding
In-Reply-To: <1467711150-23356-2-git-send-email-t.remmet@phytec.de>
References: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
 <1467711150-23356-2-git-send-email-t.remmet@phytec.de>
Message-ID: <20160710005614.GB29572@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 11:32:30AM +0200, Teresa Remmet wrote:
> commit c9711ec5250b ("mtd: nand: omap: Clean up device tree support")
> removes the check for the old elm phandle binding.

That seems like a silly breakage of backwards compatibility. Must have
overlooked that one, sorry.

> Add it again to keep backward compatibility.
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>

I think we should probably take this for v4.7, since the breaking commit
was only merged in v4.7-rc1. OMAP folks, any comment?

Brian

> ---
>  drivers/mtd/nand/omap2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 08e1588..d788663 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1658,7 +1658,9 @@ static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
>  	/* detect availability of ELM module. Won't be present pre-OMAP4 */
>  	info->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
>  	if (!info->elm_of_node)
> -		dev_dbg(dev, "ti,elm-id not in DT\n");
> +		info->elm_of_node = of_parse_phandle(child, "elm_id", 0);
> +		if (!info->elm_of_node)
> +			dev_dbg(dev, "ti,elm-id not in DT\n");
>  
>  	/* select ecc-scheme for NAND */
>  	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
> -- 
> 1.9.1
> 
