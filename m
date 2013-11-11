From: chris.ruehl@gtsys.com.hk (Chris Ruehl)
Date: Mon, 11 Nov 2013 13:33:24 +0800
Subject: [PATCH 1/2] usb: chipidea: usbmisc: Add support for i.MX27/i.MX31
 CPUs
In-Reply-To: <1384145140.400290349@f353.i.mail.ru>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <5280414C.3060806@gtsys.com.hk> <1384145140.400290349@f353.i.mail.ru>
Message-ID: <52806C24.8040100@gtsys.com.hk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Monday, November 11, 2013 12:45 PM, Alexander Shiyan wrote:
>> Hi Alexander,
>>
>> On Sunday, November 10, 2013 03:18 PM, Alexander Shiyan wrote:
>>> This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.
>>>
>>> Signed-off-by: Alexander Shiyan<shc_work@mail.ru>
>>> ---
>>>    drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> ...
>>> +static int usbmisc_imx27_init(struct imx_usbmisc_data *data)
>>> +{
>>> +	unsigned long flags;
>>> +	u32 val;
>>> +
>>> +	switch (data->index) {
>>> +	case 0:
>>> +		val = MX27_OTG_PM_BIT;
>>> +		break;
>>> +	case 1:
>>> +		val = MX27_H1_PM_BIT;
>>> +		break;
>>> +	case 2:
>>> +		val = MX27_H2_PM_BIT;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	};
>>> +
>>
>>    From my understanding this can not work, the usbmisc->base not point into the
>> usb control register (USB_CTRL). Reference manual 30.5.1.1 says
>> BASE + 0x600
>> you must add the offset to the readl instruction.
>
> Why not work?
> usbotg: usb at 10024000
> usbh1: usb at 10024200
> usbh2: usb at 10024400
> usbmisc: usbmisc at 10024600
> So, offset to USB_CTRL should already be defined by DTS.

in the usbmisc_imx_probe() the base pointer is loaded from

res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
data->base = devm_ioremap_resource(&pdev->dev, res);

(and I did not see any of_ operations)

usbmisc = data;

  base is set to 0x10024000

when I look around all other functions init functions did a offset calculation.

>
>
>>> +	spin_lock_irqsave(&usbmisc->lock, flags);
>>> +	if (data->disable_oc)
>>> +		val = readl(usbmisc->base) | val;
>>
>> else part not needed, the registers bits are set to 0 (reset)
>> the function is called on start-up once only, right?!
>>
>>> +	else
>>> +		val = readl(usbmisc->base)&   ~val;
>>> +	writel(val, usbmisc->base);
>>> +	spin_unlock_irqrestore(&usbmisc->lock, flags);
>>> +
>>> +	return 0;
>>> +}
>
> Bit can be set/cleared wrongly by the bootloader, it is not a big
> overhead to set it in proper state.
>
ohh, yes that true!

> ...
>
