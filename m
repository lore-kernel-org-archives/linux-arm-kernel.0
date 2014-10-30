From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 08:49:56 +0100
Subject: [RFT v2 2/8] regulator: max77802: Remove support for board files
In-Reply-To: <54517B37.9010305@collabora.co.uk>
References: <1414595206-1437-1-git-send-email-k.kozlowski@samsung.com>
 <1414595206-1437-3-git-send-email-k.kozlowski@samsung.com>
 <54517B37.9010305@collabora.co.uk>
Message-ID: <1414655396.5114.10.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-10-30 at 00:41 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/29/2014 04:06 PM, Krzysztof Kozlowski wrote:
> >  
> >  static int max77802_pmic_probe(struct platform_device *pdev)
> >  {
> >  	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
> > -	struct max77686_platform_data *pdata = dev_get_platdata(iodev->dev);
> >  	struct max77802_regulator_prv *max77802;
> >  	int i, ret = 0, val;
> >  	struct regulator_config config = { };
> > -
> > -	/* This is allocated by the MFD driver */
> > -	if (!pdata) {
> > -		dev_err(&pdev->dev, "no platform data found for regulator\n");
> > -		return -ENODEV;
> > -	}
> > +	struct of_regulator_match *rdata;
> >  
> >  	max77802 = devm_kzalloc(&pdev->dev,
> >  				sizeof(struct max77802_regulator_prv),
> > @@ -586,24 +558,29 @@ static int max77802_pmic_probe(struct platform_device *pdev)
> >  	if (!max77802)
> >  		return -ENOMEM;
> >  
> > -	if (iodev->dev->of_node) {
> > -		ret = max77802_pmic_dt_parse_pdata(pdev, pdata);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> >  	config.dev = iodev->dev;
> >  	config.regmap = iodev->regmap;
> >  	config.driver_data = max77802;
> >  	platform_set_drvdata(pdev, max77802);
> >  
> > +	rdata = kzalloc(sizeof(*rdata) * MAX77802_REG_MAX, GFP_KERNEL);
> > +	if (!rdata)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < MAX77802_REG_MAX; i++)
> > +		rdata[i].name = regulators[i].name;
> > +
> > +	ret = max77802_pmic_dt_parse(pdev, rdata);
> > +	if (ret)
> > +		goto out;
> > +
> >  	for (i = 0; i < MAX77802_REG_MAX; i++) {
> >  		struct regulator_dev *rdev;
> > -		int id = pdata->regulators[i].id;
> > +		int id = regulators[i].id;
> >  		int shift = max77802_get_opmode_shift(id);
> >  
> > -		config.init_data = pdata->regulators[i].initdata;
> > -		config.of_node = pdata->regulators[i].of_node;
> > +		config.init_data = rdata[i].init_data;
> > +		config.of_node = rdata[i].of_node;
> >  
> >  		ret = regmap_read(iodev->regmap, regulators[i].enable_reg, &val);
> >  		val = val >> shift & MAX77802_OPMODE_MASK;
> > @@ -621,13 +598,17 @@ static int max77802_pmic_probe(struct platform_device *pdev)
> >  		rdev = devm_regulator_register(&pdev->dev,
> >  					       &regulators[i], &config);
> 
> Thanks for your patch. It's indeed an improvement over the old code and I can
> test it tomorrow when I've access to my machine with a max77802 PMIC.
> 
> However, I don't think this is the change that Mark asked. AFAIU what he wanted
> is to fill the struct regulator_desc .of_match and .regulators_node fields so
> the init_data is extracted by the core on regulator registration.
> 
> Look at commits a0c7b164 ("regulator: of: Provide simplified DT parsing method")
> and 93a127b ("regulator: isl9305: Convert to new style DT parsing") to see what
> I'm talking about.

Ooo, I missed these changes. This should simplify the code even more.
I'll re-spin, so don't hurry with testing :)

Best regards,
Krzysztof
