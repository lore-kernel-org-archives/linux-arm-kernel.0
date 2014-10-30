From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 13:10:37 +0100
Subject: [RFT v3 06/14] regulator: max77802: Remove support for board files
In-Reply-To: <54522615.7040002@collabora.co.uk>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-7-git-send-email-k.kozlowski@samsung.com>
 <54522615.7040002@collabora.co.uk>
Message-ID: <1414671037.23399.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-10-30 at 12:50 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/30/2014 12:20 PM, Krzysztof Kozlowski wrote:
> >  static int max77802_pmic_probe(struct platform_device *pdev)
> >  {
> >  	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
> > -	struct max77686_platform_data *pdata = dev_get_platdata(iodev->dev);
> >  	struct max77802_regulator_prv *max77802;
> > -	int i, ret = 0, val;
> > +	int i, val;
> >  	struct regulator_config config = { };
> >  
> > -	/* This is allocated by the MFD driver */
> > -	if (!pdata) {
> > -		dev_err(&pdev->dev, "no platform data found for regulator\n");
> > -		return -ENODEV;
> > -	}
> > -
> >  	max77802 = devm_kzalloc(&pdev->dev,
> >  				sizeof(struct max77802_regulator_prv),
> >  				GFP_KERNEL);
> >  	if (!max77802)
> >  		return -ENOMEM;
> >  
> > -	if (iodev->dev->of_node) {
> > -		ret = max77802_pmic_dt_parse_pdata(pdev, pdata);
> > -		if (ret)
> > -			return ret;
> > +	if (!pdev->dev.of_node) {
> > +		/*
> > +		 * Backward DTS compatiblity where regulator driver had not
> > +		 * a compatible property for itself.
> > +		 */
> > +		if (!iodev->dev->of_node) {
> > +			dev_err(&pdev->dev, "No OF node for driver and its parent\n");
> > +			return -EINVAL;
> > +		}
> > +		pdev->dev.of_node = of_get_child_by_name(iodev->dev->of_node,
> > +								"regulators");
> > +		max77802->missing_of_node = true;
> >  	}
> 
> I may be missing something but I don't understand why a compatible string
> for the regulators sub-node is needed. Isn't enough to just fill the
> .regulators_node field in the struct regulator_desc? e.g:
> 
>     .regulators_node = of_match_ptr("regulators") for max77802
>     .regulators_node = of_match_ptr("voltage-regulators") for max77686
> 
> AFAIU this should be enough for the core to extract the init_data and will
> make your change much more simpler and you can drop patches 1-3 and 13-14.
> 
> Or maybe I misread the regulator_of_get_init_data() function?

The regulator_of_get_init_data() searches from dev->of_node or its child
node.

But dev->of_node is NULL.

That's why of_compatible is needed.

Best regards,
Krzysztof
