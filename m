From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Nov 2009 01:27:42 -0500
Subject: [PATCH 09/10] input: enable touch on 88pm860x
In-Reply-To: <20091114025425.GA3587@core.coreip.homeip.net>
References: <771cded00911130104s3bc6ff97ma3a7f7ad76ae9198@mail.gmail.com>
	<20091114025425.GA3587@core.coreip.homeip.net>
Message-ID: <771cded00911162227i24cd5a4cv9899e220b1c37c6e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 9:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Haojian,
>
> On Fri, Nov 13, 2009 at 04:04:44AM -0500, Haojian Zhuang wrote:
>> From 122d2c29ffef393b533628c2be8bdb308220331f Mon Sep 17 00:00:00 2001
>> + ? ? ? ? ? ? input_report_abs(touch->idev, ABS_PRESSURE, 0);
>
> Your device does not seem to be reporting real pressure so please don't
> fake ABS_PRESSURE events.
>
>> + ? ? ? ? ? ? input_report_abs(touch->idev, ABS_TOOL_WIDTH, 1);
>
> This event is used to report size of the touching object, if you don't
> know it do not report.
>
>> + ? ? ? ? ? ? input_report_abs(touch->idev, BTN_TOUCH, 0);
>
> There certainly isn't EV_ABS/BTN_TOUCH event, you meant to use
> input_report_key().
>
>> +
>> + ? ? if (++touch->count) {
>
> Input core takes care to call open only when first client opens the
> device, no need to count here.
>
>> + ? ? if (--touch->count == 0) {
>
> Same goes for close.
>
>> +
>> + ? ? if (pdev->dev.parent->platform_data) {
>> + ? ? ? ? ? ? pm860x_pdata = pdev->dev.parent->platform_data;
>> + ? ? ? ? ? ? pdata = pm860x_pdata->touch;
>> + ? ? } else
>> + ? ? ? ? ? ? pdata = NULL;
>
> I don't see pdata being used...
>
>> +
>> + ? ? set_bit(ABS_PRESSURE, touch->idev->absbit);
>> + ? ? set_bit(EV_SYN, touch->idev->evbit);
>> + ? ? set_bit(EV_KEY, touch->idev->evbit);
>> + ? ? set_bit(BTN_TOUCH, touch->idev->keybit);
>
> __set_bit(), no need to lock the bus. Also temprary for input device
> looks more pleasing to an eye and probably saves a couple of bytes.
>
>> +
>> + ? ? },
>> + ? ? .probe ?= pm860x_touch_probe,
>> + ? ? .remove = pm860x_touch_remove,
>
> __devexit_p()
>
>> +};
>> +
>> +config TOUCHSCREEN_88PM860X
>> + ? ? bool "Marvell 88PM860x touchscreen"
>> + ? ? depends on MFD_88PM860X
>> + ? ? help
>> + ? ? ? Say Y here if you have a 88PM860x PMIC and want to enable
>> + ? ? ? support for the built-in touchscreen.
>
> No module option?
>
>> ?endif
>> @@ -42,3 +42,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE) ?+=
>> mainstone-wm97xx.o
>> ?obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE) ? ?+= zylonite-wm97xx.o
>> ?obj-$(CONFIG_TOUCHSCREEN_W90X900) ? ?+= w90p910_ts.o
>> ?obj-$(CONFIG_TOUCHSCREEN_PCAP) ? ? ? ? ? ? ? += pcap_ts.o
>> +obj-$(CONFIG_TOUCHSCREEN_88PM860X) ? += 88pm860x-ts.o
>
> Would appreciate if you arrange makefile alphabetically.
>
> Thanks.
>
> --
> Dmitry
>

Up to now, I don't support module yet. When each component of this
PMIC is ready, I'll enable module.

Thanks
Haojian
