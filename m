From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 15 Jan 2014 19:58:25 +0100
Subject: [PATCH v6 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <Pine.LNX.4.44L0.1401151123340.1587-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401151123340.1587-100000@iolanthe.rowland.org>
Message-ID: <52D6DA51.5050905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/15/2014 05:30 PM, Alan Stern wrote:
> On Wed, 15 Jan 2014, Hans de Goede wrote:
>
>> +static int ohci_platform_power_on(struct platform_device *dev)
>> +{
>> +	struct usb_hcd *hcd = platform_get_drvdata(dev);
>> +	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
>> +	int clk, ret;
>> +
>> +	for (clk = 0; clk < OHCI_MAX_CLKS && priv->clks[clk]; clk++) {
>
> You fixed this one...
>
>> @@ -125,13 +225,22 @@ static int ohci_platform_remove(struct platform_device *dev)
>>   {
>>   	struct usb_hcd *hcd = platform_get_drvdata(dev);
>>   	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
>> +	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
>> +	int clk;
>>
>>   	usb_remove_hcd(hcd);
>> -	usb_put_hcd(hcd);
>>
>>   	if (pdata->power_off)
>>   		pdata->power_off(dev);
>>
>> +	for (clk = 0; priv->clks[clk] && clk < OHCI_MAX_CLKS; clk++)
>
> but not this one.  :-(  Same for the ehci-platform patch.

Oops, sorry about that, v7 coming up.

> In fact, it might be easier to make this loop go backward, like
> you do in the *_platform_power_off routines.

I prefer keep doing things forward here, the backward loop in
power_off is because the disable_unprepare must be done in reverse
order if the prepare_enable calls.

> Is there a devm-type routine that will take care of all this for you?

Nope, the downside of getting the clocks by index rather then by name
is that there are no devm routines for that.

Regards,

Hans
