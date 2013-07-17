From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Jul 2013 09:40:39 +0100
Subject: [PATCH 1/3] ASoC: bt-sco: enable OF support
In-Reply-To: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 07:12:14AM +0100, Barry Song wrote:
> From: Rongjun Ying <Rongjun.Ying@csr.com>
> 
> this makes users be able to add a bt-sco node in dts instead of
> hardcoding a platform device in mach.

I'm slightly confused by this. The driver doesn't seem to pick up any
information out of the dts, and the binding doesn't even describe any
linkage to a piece of hardware. I'm not familiar with bluetooth or ASoC,
could you give an explanation as to why this is needed?

I don't think this should be in the dt as is. Could this not be
registered based on the presence of a bluetooth controller that supports
this?

Thanks,
Mark.

> 
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  sound/soc/codecs/bt-sco.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
> index a081d9f..39e7ebe 100644
> --- a/sound/soc/codecs/bt-sco.c
> +++ b/sound/soc/codecs/bt-sco.c
> @@ -46,6 +46,14 @@ static int bt_sco_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id bt_sco_of_match[] = {
> +	{ .compatible = "bt-sco-codec", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bt_sco_of_match);
> +#endif
> +
>  static struct platform_device_id bt_sco_driver_ids[] = {
>  	{
>  		.name		= "dfbmcs320",
> @@ -58,6 +66,9 @@ static struct platform_driver bt_sco_driver = {
>  	.driver = {
>  		.name = "bt-sco",
>  		.owner = THIS_MODULE,
> +#ifdef CONFIG_OF
> +		.of_match_table = bt_sco_of_match,
> +#endif
>  	},
>  	.probe = bt_sco_probe,
>  	.remove = bt_sco_remove,
> -- 
> 1.8.2.3
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
