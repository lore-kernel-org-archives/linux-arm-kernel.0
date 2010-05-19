From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 19 May 2010 09:30:41 -0700
Subject: [PATCH 03/05] input: enable onkey driver of max8925
In-Reply-To: <AANLkTim0nDQ9oGfKY3ccf7P1bC3pJreInsMrmxRDl4xm@mail.gmail.com>
References: <AANLkTim0nDQ9oGfKY3ccf7P1bC3pJreInsMrmxRDl4xm@mail.gmail.com>
Message-ID: <20100519163041.GA18753@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, May 19, 2010 at 02:58:07PM +0800, Haojian Zhuang wrote:
> +
> +/* MAX8925 gives us an interrupt when ONKEY is held for 3 seconds. */
> +static irqreturn_t max8925_onkey_handler(int irq, void *data)
> +{
> +	struct max8925_onkey_info *info = data;
> +
> +	input_report_key(info->idev, KEY_POWER, 1);
> +	input_sync(info->idev);
> +
> +	/* Enable hardreset to halt if system isn't shutdown on time */

A comment mentioning that max8925_set_bits() may sleep would instantly
remove all concerns why threaded IRQ is being used here.

> +	max8925_set_bits(info->i2c, MAX8925_SYSENSEL,
> +			 HARDRESET_EN, HARDRESET_EN);
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit max8925_onkey_probe(struct platform_device *pdev)
> +{
> +	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +	struct max8925_onkey_info *info;
> +	int irq, ret;
> +
> +	info = kzalloc(sizeof(struct max8925_onkey_info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	info->chip = chip;
> +	info->i2c = chip->i2c;
> +	info->dev = &pdev->dev;
> +	irq = chip->irq_base + MAX8925_IRQ_GPM_SW_3SEC;
> +
> +	ret = request_threaded_irq(irq, NULL, max8925_onkey_handler,
> +				   IRQF_ONESHOT, "onkey", info);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> +			irq, ret);
> +		goto out;
> +	}
> +
> +	info->idev = input_allocate_device();
> +	if (!info->idev) {
> +		dev_err(chip->dev, "Failed to allocate input dev\n");
> +		ret = -ENOMEM;
> +		goto out_input;
> +	}
> +

You need to allocate device before requesting IRQ otherwise it may crash
and burn.

> +	info->idev->name = "max8925_on";
> +	info->idev->phys = "max8925_on/input0";
> +	info->idev->id.bustype = BUS_I2C;
> +	info->idev->dev.parent = &pdev->dev;
> +	info->irq = irq;
> +	info->idev->evbit[0] = BIT_MASK(EV_KEY);
> +	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
> +
> +	ret = input_register_device(info->idev);
> +	if (ret) {
> +		dev_err(chip->dev, "Can't register input device: %d\n", ret);
> +		goto out_reg;
> +	}
> +	platform_set_drvdata(pdev, info);
> +
> +	return 0;
> +
> +out_reg:
> +	input_free_device(info->idev);
> +out_input:
> +	free_irq(info->irq, info);
> +out:
> +	kfree(info);
> +	return ret;
> +}
> +
> +static int __devexit max8925_onkey_remove(struct platform_device *pdev)
> +{
> +	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
> +
> +	if (info) {

How can info be NULL?

> +		free_irq(info->irq, info);
> +		input_unregister_device(info->idev);
> +		kfree(info);

platform_set_drvdata(pdev, NULL); - please clean up after yourself.

Thanks.

-- 
Dmitry
