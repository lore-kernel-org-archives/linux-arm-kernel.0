From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 9 Dec 2009 19:57:26 -0800
Subject: [PATCH v2 08/09] input: enable touch on 88pm860x
In-Reply-To: <20091210032149.GH10138@core.coreip.homeip.net>
References: <771cded00912090517l5665e02fj35e90d02932e545a@mail.gmail.com>
	<20091210032149.GH10138@core.coreip.homeip.net>
Message-ID: <200912091957.26793.dmitry.torokhov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 December 2009 07:21:49 pm Dmitry Torokhov wrote:
> > +
> > +static int __devinit pm860x_touch_probe(struct platform_device *pdev)
> > +{
> > +	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct pm860x_platform_data *pm860x_pdata;
> > +	struct pm860x_touch_pdata *pdata;
> > +	struct pm860x_touch *touch;
> > +	int irq, ret;
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "No IRQ resource!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (pdev->dev.parent->platform_data) {
> > +		pm860x_pdata = pdev->dev.parent->platform_data;
> > +		pdata = pm860x_pdata->touch;
> > +	} else
> > +		pdata = NULL;
> > +
> > +	if (pdata == NULL) {
> > +		dev_err(&pdev->dev, "platform data isn't assigned to "
> > +			"touch\n");
> > +		return -EINVAL;
> > +	}
> 
> This should be written as:
> 
> ...
> 	struct pm860x_platform_data *pm860x_pdata =
>  pdev->dev.parent->platform_data; ...
> 
> 	if (pm860x_pdata) {
> 		pdata = pm860x_pdata->touch;
> 		if (!pdata) {
> 			dev_err(&pdev->dev,
> 				"touchscreen platform data is missing\n");
> 			return -EINVAL;
> 		}
> 	}

Ugh, sorry, it was pure garbage... long day for me...

	if (!pm860x_pdata) {
		dev_err(&pdev->dev, "platform data is missing\n");
		return -EINVAL;
	}

	pdata = pm860x_pdata->touch;
	if (!pdata) {
		dev_err(&pdev->dev, "touchscreen data is missing\n");
		return -EINVAL;
	}
 
should be better.

Sorry for the confusion.

-- 
Dmitry
