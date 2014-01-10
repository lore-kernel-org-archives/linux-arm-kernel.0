From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 10 Jan 2014 11:13:48 +0100
Subject: [PATCH v3 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <Pine.LNX.4.44L0.1401091446310.1493-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401091446310.1493-100000@iolanthe.rowland.org>
Message-ID: <52CFC7DC.3010406@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/09/2014 09:36 PM, Alan Stern wrote:
> On Thu, 9 Jan 2014, Hans de Goede wrote:
>
>> Add support for ohci-platform instantiation from devicetree, including
>> optionally getting clks and a phy from devicetree, and enabling / disabling
>> those on power_on / off.
>>
>> This should allow using ohci-platform from devicetree in various cases.
>> Specifically after this commit it can be used for the ohci controller found
>> on Allwinner sunxi SoCs.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Looking pretty good.  Still a couple of things to address...
>
>> +static struct usb_ohci_pdata ohci_platform_defaults = {
>> +	.power_on =		ohci_platform_power_on,
>> +	.power_suspend =	ohci_platform_power_off,
>> +	.power_off =		ohci_platform_power_off,
>>   };
>
> I wonder if these routines couldn't be shared with non-DT setups.  We
> could add an array of 3 struct clk pointers to the usb_ohci_pdata
> structure.  Then if any of them are set, store these routines in the
> power_* pointers.  (And likewise for ehci-platform.)  Something to
> consider for a future patch...

I don't like automatically setting the power_ platform_data members much.

But I've already been thinking about moving the clks member to platform_data,
and simply exporting ohci_platform_power_* so that other drivers can use them
and put them in the platform_data members themselves. That is indeed something
for another patch though.

>> @@ -60,12 +128,24 @@ static int ohci_platform_probe(struct platform_device *dev)
>>   	struct usb_hcd *hcd;
>>   	struct resource *res_mem;
>>   	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
>> -	int irq;
>> -	int err = -ENOMEM;
>> +	struct ohci_platform_priv *priv;
>> +	int clk, irq, err;
>>
>> +	/*
>> +	 * Use reasonable defaults so platforms don't have to provide these
>> +	 * with DT probing on ARM.
>> +	 */
>>   	if (!pdata) {
>> -		WARN_ON(1);
>> -		return -ENODEV;
>> +		pdata = dev->dev.platform_data = &ohci_platform_defaults;
>
> This has a subtle bug.  Consider what will happen if ohci-platform is
> loaded, then unloaded and loaded again.

Right, so we need to add a "dev->dev.platform_data == &ohci_platform_defaults"
check on remove an then set platform_data to NULL, good point, will fix in the
next version.

>
> The existing ehci-platform driver has this same bug.  I definitely
> remember discussing at once or twice in the past, but evidently it has
> never been fixed.

If you agree with the above fix I'll also throw it into the next revision
of the ehci patch.

>
>> +		/*
>> +		 * Right now device-tree probed devices don't get dma_mask set.
>> +		 * Since shared usb code relies on it, set it here for now.
>> +		 * Once we have dma capability bindings this can go away.
>> +		 */
>> +		err = dma_coerce_mask_and_coherent(&dev->dev,
>> +						   DMA_BIT_MASK(32));
>> +		if (err)
>> +			return err;
>
> The ehci-platform driver does this even when platform data is present.
> I guess you should do the same thing here (and lose the comment).
>
> (Also, I dislike this alignment of the continuation line.  IMO it's a
> bad idea to match up with some particular element of the preceding
> line.  The style used in most of the USB stack is to indent
> continuation lines by two tab stops.)

Ok, will fix.

>
>>   	}
>>
>>   	if (usb_disabled())
>
> This test belongs at the start of the function.  It is more fundamental
> than the stuff you inserted.
>

Ok, will fix.

>> @@ -83,17 +163,39 @@ static int ohci_platform_probe(struct platform_device *dev)
>>   		return -ENXIO;
>>   	}
>>
>> +	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
>> +			dev_name(&dev->dev));
>> +	if (!hcd)
>> +		return -ENOMEM;
>> +
>> +	priv = (struct ohci_platform_priv *)hcd_to_ohci(hcd)->priv;
>
> Please define an inline routine or a macro for this messy computation.

Ok, will fix.

Before I do a v4, one question:

Ma Haijun does not like the use of OHCI_MAX_CLKS:

 >> +#define OHCI_MAX_CLKS 3
 >
 > I still recommend using of_count_phandle_with_args(np, "clocks",
 > "#clock-cells") to determine the number of clocks or the existence of clocks
 > property (-ENOENT)

His suggestion would mean dynamically allocating the clks array and having
clks_count variable. I still think this is a bit overkill, but I can do that for
v4 if you want, so what do you prefer ?

Regards,

Hans
