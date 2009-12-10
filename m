From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 9 Dec 2009 23:06:36 -0500
Subject: [PATCH v2 08/09] input: enable touch on 88pm860x
In-Reply-To: <200912091957.26793.dmitry.torokhov@gmail.com>
References: <771cded00912090517l5665e02fj35e90d02932e545a@mail.gmail.com>
	<20091210032149.GH10138@core.coreip.homeip.net>
	<200912091957.26793.dmitry.torokhov@gmail.com>
Message-ID: <771cded00912092006o2fd46687v8aa9d2aa1404cb59@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2009 at 10:57 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wednesday 09 December 2009 07:21:49 pm Dmitry Torokhov wrote:
>> > +
>> > +static int __devinit pm860x_touch_probe(struct platform_device *pdev)
>> > +{
>> > + ? struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
>> > + ? struct pm860x_platform_data *pm860x_pdata;
>> > + ? struct pm860x_touch_pdata *pdata;
>> > + ? struct pm860x_touch *touch;
>> > + ? int irq, ret;
>> > +
>> > + ? irq = platform_get_irq(pdev, 0);
>> > + ? if (irq < 0) {
>> > + ? ? ? ? ? dev_err(&pdev->dev, "No IRQ resource!\n");
>> > + ? ? ? ? ? return -EINVAL;
>> > + ? }
>> > +
>> > + ? if (pdev->dev.parent->platform_data) {
>> > + ? ? ? ? ? pm860x_pdata = pdev->dev.parent->platform_data;
>> > + ? ? ? ? ? pdata = pm860x_pdata->touch;
>> > + ? } else
>> > + ? ? ? ? ? pdata = NULL;
>> > +
>> > + ? if (pdata == NULL) {
>> > + ? ? ? ? ? dev_err(&pdev->dev, "platform data isn't assigned to "
>> > + ? ? ? ? ? ? ? ? ? "touch\n");
>> > + ? ? ? ? ? return -EINVAL;
>> > + ? }
>>
>> This should be written as:
>>
>> ...
>> ? ? ? struct pm860x_platform_data *pm860x_pdata =
>> ?pdev->dev.parent->platform_data; ...
>>
>> ? ? ? if (pm860x_pdata) {
>> ? ? ? ? ? ? ? pdata = pm860x_pdata->touch;
>> ? ? ? ? ? ? ? if (!pdata) {
>> ? ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "touchscreen platform data is missing\n");
>> ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> ? ? ? ? ? ? ? }
>> ? ? ? }
>
> Ugh, sorry, it was pure garbage... long day for me...
>
> ? ? ? ?if (!pm860x_pdata) {
> ? ? ? ? ? ? ? ?dev_err(&pdev->dev, "platform data is missing\n");
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?}
>
> ? ? ? ?pdata = pm860x_pdata->touch;
> ? ? ? ?if (!pdata) {
> ? ? ? ? ? ? ? ?dev_err(&pdev->dev, "touchscreen data is missing\n");
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?}
>
> should be better.
>
> Sorry for the confusion.
>
> --
> Dmitry
>

Update it :)

Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0008-input-enable-touch-on-88pm860x.patch
Type: text/x-patch
Size: 9019 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091209/0137ca60/attachment-0001.bin>
