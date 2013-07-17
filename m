From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Jul 2013 09:49:10 +0100
Subject: [PATCH 2/3] ASoC: hdmi-codec: enable OF support
In-Reply-To: <1374041536-27643-2-git-send-email-Baohua.Song@csr.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <1374041536-27643-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130717084910.GB15981@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 07:12:15AM +0100, Barry Song wrote:
> From: Rongjun Ying <Rongjun.Ying@csr.com>
> 
> this makes users be able to add a hdmi-codec node in dts instead of
> hardcoding a platform device in mach.

Similarly to my comment on the first patch, I'm not sure this is the
best way to wire this up to devicetree. Can this not be hung off of hdmi
controller drivers?

Thanks,
Mark.

> 
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  sound/soc/codecs/hdmi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
> index 2bcae2b..78c7b15 100644
> --- a/sound/soc/codecs/hdmi.c
> +++ b/sound/soc/codecs/hdmi.c
> @@ -51,10 +51,21 @@ static int hdmi_codec_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id hdmi_audio_codec_ids[] = {
> +	{ .compatible = "hdmi-audio-codec", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, hdmi_audio_codec_ids);
> +#endif
> +
>  static struct platform_driver hdmi_codec_driver = {
>  	.driver		= {
>  		.name	= DRV_NAME,
>  		.owner	= THIS_MODULE,
> +#ifdef CONFIG_OF
> +		.of_match_table = hdmi_audio_codec_ids,
> +#endif
>  	},
>  
>  	.probe		= hdmi_codec_probe,
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
