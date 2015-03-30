From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 30 Mar 2015 16:05:19 +0800
Subject: [PATCH v5 3/3] I2C: mediatek: Add driver for MediaTek MT8173
 I2C controller
In-Reply-To: <20150323073905.GF9742@pengutronix.de>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
 <1426917922-61356-4-git-send-email-eddie.huang@mediatek.com>
 <20150323073905.GF9742@pengutronix.de>
Message-ID: <1427702719.26464.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, 2015-03-23 at 08:39 +0100, Sascha Hauer wrote:
> On Sat, Mar 21, 2015 at 02:05:22PM +0800, Eddie Huang wrote:
> > Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> > of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> > also increase message size to 64kb.
> > 
> 
> [...]
> 
> > +static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
> > +	.max_num_msgs = MAX_MSG_NUM_MT8173,
> > +	.max_write_len = MAX_DMA_TRANS_SIZE_MT8173,
> > +	.max_read_len = MAX_DMA_TRANS_SIZE_MT8173,
> > +	.max_comb_1st_msg_len = MAX_DMA_TRANS_SIZE_MT8173,
> > +	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT8173,
> > +};
> > +
> >  static int mtk_i2c_probe(struct platform_device *pdev)
> >  {
> >  	int ret = 0;
> > @@ -587,7 +626,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  
> >  	i2c->platform_compat = mtk_get_device_prop(pdev);
> > -	if (i2c->have_pmic && (i2c->platform_compat & COMPAT_MT6577))
> > +	if (i2c->have_pmic && (i2c->platform_compat &
> > +			(COMPAT_MT6577 | COMPAT_MT8173)))
> >  		return -EINVAL;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -613,7 +653,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
> >  	i2c->adap.dev.parent = &pdev->dev;
> >  	i2c->adap.owner = THIS_MODULE;
> >  	i2c->adap.algo = &mtk_i2c_algorithm;
> > -	i2c->adap.quirks = &mt6577_i2c_quirks;
> > +	if (i2c->platform_compat & COMPAT_MT8173)
> > +		i2c->adap.quirks = &mt8173_i2c_quirks;
> > +	else
> > +		i2c->adap.quirks = &mt6577_i2c_quirks;
> 
> Instead of putting an integer into struct of_device_id you should
> introduce a
> 
> struct mtk_i2c_data {
> 	struct i2c_adapter_quirks quirks;
> 	int compat;
> 	/* Additional SoC specific data */
> };
> 
> and put a pointer to this directly into the of_device_id. This way you
> need less casting and can put newly discovered differences diretly into
> some data struct and don't have to introduce if(socxy) ... else ...
> everytime.
> 

Thanks your suggestion. I will use capability struct like 

struct mtk_i2c_compatible {
	unsigned char pmic_i2c;
	unsigned char dcm;
	unsigned char auto_restart;
	const struct i2c_adapter_quirks *quirks;
};

And pass in of_device_id, then remove all if(socxy).... else ... in
driver.

Eddie
