From: koro.chen@mediatek.com (Koro Chen)
Date: Fri, 12 Jun 2015 09:55:58 +0800
Subject: [alsa-devel] [PATCH 1/3] ASoC: mediatek: Add AFE platform driver
In-Reply-To: <1434006187.24094.40.camel@x220>
References: <1433946276-25969-1-git-send-email-koro.chen@mediatek.com>
 <1433946276-25969-2-git-send-email-koro.chen@mediatek.com>
 <1434006187.24094.40.camel@x220>
Message-ID: <1434074158.10969.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-06-11 at 09:03 +0200, Paul Bolle wrote:
> On Wed, 2015-06-10 at 22:24 +0800, Koro Chen wrote:
> > --- /dev/null
> > +++ b/sound/soc/mediatek/Kconfig
> 
> > +config SND_SOC_MEDIATEK
> > +	bool "ASoC support for Mediatek chip"
> > +	depends on ARCH_MEDIATEK
> > +	help
> > +	  This adds ASoC platform driver support for Mediatek chip
> > +	  that can be used with other codecs.
> > +	  Select Y if you have such device.
> > +	  Ex: MT8173
> 
> > --- /dev/null
> > +++ b/sound/soc/mediatek/Makefile
> 
> > +obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
> 
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mtk-afe-pcm.c
> 
> > +#include <linux/module.h>
> 
> > +static void mtk_afe_set_i2s_enable(struct mtk_afe *afe, bool enable)
> > +{
> > +	unsigned int val;
> > +
> > +	regmap_read(afe->regmap, AFE_I2S_CON2, &val);
> > +	if (!!(val & AFE_I2S_CON2_EN) == !!enable)
> 
> (What does negating a bool twice do?)
> 
Because bool actually can be unsigned char, although actually in this
driver, the caller always passes "true" or "false" to this function.
Do you think if this is the case, should I still need to do !!?

> > +		return; /* must skip soft reset */
> > +
> > +	/* I2S soft reset begin */
> > +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON1, 0x4, 0x4);
> > +
> > +	/* input */
> > +	regmap_update_bits(afe->regmap, AFE_I2S_CON2, 0x1, !!enable);
> 
> Ditto.
> 
> > +
> > +	/* output */
> > +	regmap_update_bits(afe->regmap, AFE_I2S_CON1, 0x1, !!enable);
> 
> Ditto.
> 
> > +
> > +	/* I2S soft reset end */
> > +	udelay(1);
> > +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON1, 0x4, 0);
> > +}
> 
> > +static const struct of_device_id mtk_afe_pcm_dt_match[] = {
> > +	{ .compatible = "mediatek,mt8173-afe-pcm", },
> > +	{ }
> > +}; 
> 
> > +static struct platform_driver mtk_afe_pcm_driver = {
> > +	.driver = {
> > +		   .name = "mtk-afe-pcm",
> > +		   .owner = THIS_MODULE,
> > +		   .of_match_table = mtk_afe_pcm_dt_match,
> > +		   .pm = &mtk_afe_pm_ops,
> > +	},
> > +	.probe = mtk_afe_pcm_dev_probe,
> > +	.remove = mtk_afe_pcm_dev_remove,
> > +};
> 
> > +MODULE_DESCRIPTION("Mediatek ALSA SoC AFE platform driver");
> > +MODULE_AUTHOR("Koro Chen <koro.chen@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DEVICE_TABLE(of, mtk_afe_pcm_dt_match);
> 
> (The common pattern is to have MODULE_DEVICE_TABLE() directly follow
> that table.)
> 
Thank you for mentioning this, I will fix it.
> SND_SOC_MEDIATEK is a bool symbol and mtk-afe-pcm.o is built-in only.
> But the code uses a few module specific constructs. I spotted
> THIS_MODULE, MODULE_DESCRIPTION, MODULE_AUTHOR, MODULE_LICENSE, and
> MODULE_DEVICE_TABLE.
> 
> Is SND_SOC_MEDIATEK perhaps meant to be bool?
> 
> Likewise for SND_SOC_MT8173_MAX98090 (in 2/3) and
> SND_SOC_MT8173_RT5650_RT5676 (in 3/3).
> 
OK, yes, I think I should replace it by tristate, thank you!
> Thanks,
> 
> 
> Paul Bolle
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
