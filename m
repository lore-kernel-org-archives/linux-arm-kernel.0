From: balbi@ti.com (Felipe Balbi)
Date: Wed, 4 Nov 2015 10:33:27 -0600
Subject: [PATCH] dmaengine: edma: Add dummy driver skeleton for edma3-tptc
In-Reply-To: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
References: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <87egg54td4.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> The eDMA3 TPTC does not need any software configuration, but it is a
> separate IP block in the SoC. In order the omap hwmod core to be able to
> handle the TPTC resources correctly in regards of PM we need to have a
> driver loaded for it.
> This patch will add a dummy driver skeleton without probe or remove
> callbacks provided.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reported-by: Olof Johansson <olof@lixom.net>

This fixes the problem I also reported on linux-omap [1]

Tested-by: Felipe Balbi <balbi@ti.com>

[1] http://marc.info/?l=linux-omap&m=144665429032014&w=2

> ---
> Hi,
>
> while it would have been possible to add the edma3-tptc compatible to be handled
> by the edma-tpcc driver (and when the device is tptc, do nothing) it would
> make the driver code a bit harder to follow.
> I think having separate structure for the tptc looks better and if we ever need
> to have separate driver for the tptc it will be cleaner for us the separate it.
>
> This patch alone w/o any hwmod flag changes will make sure that the edma-tptc is
> not powered down after the kernel is finished it's booting.
>
> Regards,
> Peter
>
>  drivers/dma/edma.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 31722d436a42..6b03e4e84e6b 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -269,6 +269,11 @@ static const struct of_device_id edma_of_ids[] = {
>  	{}
>  };
>  
> +static const struct of_device_id edma_tptc_of_ids[] = {
> +	{ .compatible = "ti,edma3-tptc", },
> +	{}
> +};
> +
>  static inline unsigned int edma_read(struct edma_cc *ecc, int offset)
>  {
>  	return (unsigned int)__raw_readl(ecc->base + offset);
> @@ -2399,6 +2404,13 @@ static struct platform_driver edma_driver = {
>  	},
>  };
>  
> +static struct platform_driver edma_tptc_driver = {
> +	.driver = {
> +		.name	= "edma3-tptc",
> +		.of_match_table = edma_tptc_of_ids,
> +	},
> +};
> +
>  bool edma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	bool match = false;
> @@ -2418,6 +2430,12 @@ EXPORT_SYMBOL(edma_filter_fn);
>  
>  static int edma_init(void)
>  {
> +	int ret;
> +
> +	ret = platform_driver_register(&edma_tptc_driver);
> +	if (ret)
> +		return ret;
> +
>  	return platform_driver_register(&edma_driver);
>  }
>  subsys_initcall(edma_init);
> @@ -2425,6 +2443,7 @@ subsys_initcall(edma_init);
>  static void __exit edma_exit(void)
>  {
>  	platform_driver_unregister(&edma_driver);
> +	platform_driver_unregister(&edma_tptc_driver);
>  }
>  module_exit(edma_exit);
>  
> -- 
> 2.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/ae4493ee/attachment.sig>
