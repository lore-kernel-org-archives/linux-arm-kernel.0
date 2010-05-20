From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 20 May 2010 09:46:51 +0800
Subject: [PATCH 03/05] input: enable onkey driver of max8925
In-Reply-To: <20100519163041.GA18753@core.coreip.homeip.net>
References: <AANLkTim0nDQ9oGfKY3ccf7P1bC3pJreInsMrmxRDl4xm@mail.gmail.com>
	<20100519163041.GA18753@core.coreip.homeip.net>
Message-ID: <AANLkTik3hGTMATHu80Tn6OeaHkEObFbhR-S7xHaIIQQV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 12:30 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Haojian,
>
> On Wed, May 19, 2010 at 02:58:07PM +0800, Haojian Zhuang wrote:
>> +
>> +/* MAX8925 gives us an interrupt when ONKEY is held for 3 seconds. */
>> +static irqreturn_t max8925_onkey_handler(int irq, void *data)
>> +{
>> + ? ? struct max8925_onkey_info *info = data;
>> +
>> + ? ? input_report_key(info->idev, KEY_POWER, 1);
>> + ? ? input_sync(info->idev);
>> +
>> + ? ? /* Enable hardreset to halt if system isn't shutdown on time */
>
> A comment mentioning that max8925_set_bits() may sleep would instantly
> remove all concerns why threaded IRQ is being used here.
>
>> + ? ? ret = request_threaded_irq(irq, NULL, max8925_onkey_handler,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?IRQF_ONESHOT, "onkey", info);
>> + ? ? if (ret < 0) {
>> + ? ? ? ? ? ? dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
>> + ? ? ? ? ? ? ? ? ? ? irq, ret);
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? info->idev = input_allocate_device();
>> + ? ? if (!info->idev) {
>> + ? ? ? ? ? ? dev_err(chip->dev, "Failed to allocate input dev\n");
>> + ? ? ? ? ? ? ret = -ENOMEM;
>> + ? ? ? ? ? ? goto out_input;
>> + ? ? }
>> +
>
> You need to allocate device before requesting IRQ otherwise it may crash
> and burn.
>
>> +static int __devexit max8925_onkey_remove(struct platform_device *pdev)
>> +{
>> + ? ? struct max8925_onkey_info *info = platform_get_drvdata(pdev);
>> +
>> + ? ? if (info) {
>
> How can info be NULL?
>
>> + ? ? ? ? ? ? free_irq(info->irq, info);
>> + ? ? ? ? ? ? input_unregister_device(info->idev);
>> + ? ? ? ? ? ? kfree(info);
>
> platform_set_drvdata(pdev, NULL); - please clean up after yourself.
>
> Thanks.
>
> --
> Dmitry
>

Thanks a lot. Now the updated patch is attached and pasted in below.

Best Regards
Haojian
