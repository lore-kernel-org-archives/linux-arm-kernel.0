From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 15 Jan 2014 16:07:40 +0100
Subject: [PATCH v5 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <Pine.LNX.4.44L0.1401141404420.1310-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401141404420.1310-100000@iolanthe.rowland.org>
Message-ID: <52D6A43C.9090706@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/14/2014 08:08 PM, Alan Stern wrote:
> On Mon, 13 Jan 2014, Hans de Goede wrote:
>
>> Add support for ohci-platform instantiation from devicetree, including
>> optionally getting clks and a phy from devicetree, and enabling / disabling
>> those on power_on / off.
>>
>> This should allow using ohci-platform from devicetree in various cases.
>> Specifically after this commit it can be used for the ohci controller found
>> on Allwinner sunxi SoCs.
>
> This is fine as far as I am concerned, except for one thing.
>
>> @@ -60,17 +127,23 @@ static int ohci_platform_probe(struct platform_device *dev)
>>   	struct usb_hcd *hcd;
>>   	struct resource *res_mem;
>>   	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
>> -	int irq;
>> -	int err = -ENOMEM;
>> -
>> -	if (!pdata) {
>> -		WARN_ON(1);
>> -		return -ENODEV;
>> -	}
>> +	struct ohci_platform_priv *priv;
>> +	int clk, irq, err;
>
> clk isn't initialized to anything...

Good catch, will fix and then do a v6 with this + the issue from your other mail fixed
and I'll add your ack.

>
>> -err_put_hcd:
>> -	usb_put_hcd(hcd);
>>   err_power:
>>   	if (pdata->power_off)
>>   		pdata->power_off(dev);
>> +err_put_clks:
>> +	while (--clk >= 0)
>> +		clk_put(priv->clks[clk]);
>
> ... but it gets used here.  The compiler should have warned about this.

Should have yes, but it doesn't (I've just double checked).

> After fixing that, you can add
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks & Regards,

Hans
