From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 4 Feb 2010 06:08:42 -0500
Subject: [PATCH 5/5] input: support onkey in 88pm860x
In-Reply-To: <20100203173628.GB30600@core.coreip.homeip.net>
References: <771cded01002030504ye3416c8nafe21be405237ace@mail.gmail.com>
	<20100203173628.GB30600@core.coreip.homeip.net>
Message-ID: <771cded01002040308t3fe112e5leb60bc969fbfcfb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2010 at 12:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Haojian,
>
> On Wed, Feb 03, 2010 at 08:04:30AM -0500, Haojian Zhuang wrote:
>
> Looks most;y good with the exceptin of the following:
>
>> +
>> + ? ? info = kzalloc(sizeof(struct pm860x_onkey_info), GFP_KERNEL);
>> + ? ? if (!info)
>> + ? ? ? ? ? ? return -ENOMEM;
>> + ? ? info->chip = chip;
>> + ? ? info->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
>> + ? ? info->dev = &pdev->dev;
>> + ? ? info->irq = irq + chip->irq_base;
>> +
>> + ? ? ret = request_threaded_irq(info->irq, NULL, pm860x_onkey_handler,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?IRQF_ONESHOT, "onkey", info);
>> + ? ? if (ret < 0) {
>> + ? ? ? ? ? ? dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
>> + ? ? ? ? ? ? ? ? ? ? info->irq, ret);
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? info->idev = input_allocate_device();
>
> You can't enable IRQ first and allocate the device later. If IRQ comes
> here it will go "BOOM".
>
>> + ? ? if (!info->idev) {
>> + ? ? ? ? ? ? dev_err(chip->dev, "Failed to allocate input dev\n");
>> + ? ? ? ? ? ? ret = -ENOMEM;
>> + ? ? ? ? ? ? goto out_input;
>> + ? ? }
>> +
>> + ? ? info->idev->name = "88pm860x_on";
>> + ? ? info->idev->phys = "88pm860x_on/input0";
>> + ? ? info->idev->id.bustype = BUS_I2C;
>> + ? ? info->idev->dev.parent = &pdev->dev;
>> + ? ? info->irq = irq;
>> + ? ? info->idev->evbit[0] = BIT_MASK(EV_KEY);
>> + ? ? info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
>> +
>> + ? ? ret = input_register_device(info->idev);
>> + ? ? if (ret) {
>> + ? ? ? ? ? ? dev_err(chip->dev, "Can't register input device: %d\n", ret);
>> + ? ? ? ? ? ? goto out_reg;
>> + ? ? }
>> + ? ? platform_set_drvdata(pdev, info);
>> +
>> + ? ? return 0;
>> +
>> +out_reg:
>> + ? ? input_free_device(info->idev);
>> +out_input:
>> + ? ? free_irq(info->irq, info);
>
> So this needs to be in reverse order as well.
>
>> +out:
>> + ? ? kfree(info);
>> + ? ? return ret;
>> +}
>> +
>> +static int __devexit pm860x_onkey_remove(struct platform_device *pdev)
>> +{
>> + ? ? struct pm860x_onkey_info *info = platform_get_drvdata(pdev);
>> +
>> + ? ? if (info) {
>
> "info" will never be NULL, your probe routine makes sure of it. Also it
> is considered a good manners to set drvdata back to NULL after
> unbinding.
>
>> + ? ? ? ? ? ? free_irq(info->irq, info);
>> + ? ? ? ? ? ? input_unregister_device(info->idev);
>> + ? ? ? ? ? ? kfree(info);
>> + ? ? }
>> + ? ? return 0;
>> +}
>> +
>

Fix and format the new patch.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-input-support-onkey-in-88pm860x.patch
Type: text/x-patch
Size: 6025 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100204/9345e64e/attachment-0001.bin>
