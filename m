From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 16 Jul 2013 19:08:12 +0200
Subject: [PATCH v3 6/7] USB: ohci-at91: add usb_clk for transition to
 common clk framework
In-Reply-To: <Pine.LNX.4.44L0.1307161246130.1032-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1307161246130.1032-100000@iolanthe.rowland.org>
Message-ID: <51E57DFC.5030302@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alan,

On 16/07/2013 18:48, Alan Stern wrote:
> On Tue, 16 Jul 2013, Boris BREZILLON wrote:
>
>> The AT91 PMC (Power Management Controller) provides an USB clock used by
>> USB Full Speed host (ohci) and USB Full Speed device (udc).
>> The usb drivers (ohci and udc) must configure this clock to 48Mhz.
>> This configuration was formely done in mach-at91/clock.c, but this
>> implementation will be removed when moving to common clk framework.
>>
>> This patch add support for usb clock retrieval and configuration, and is
>> backward compatible with the current at91 clk implementation (if usb clk
>> is not found, it does not configure/enable the usb clk).
> But it does print a warning in the system log, right?
Yes it does.
>
>> @@ -144,6 +150,11 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>>   		goto err2;
>>   	}
>>   
>> +	uclk = clk_get(&pdev->dev, "usb_clk");
>> +	if (IS_ERR(uclk)) {
>> +		uclk = NULL;
>> +		dev_warn(&pdev->dev, "failed to get usb_clk\n");
>> +	}
> Is this really what you want for backward compatibility?
Here are some proposition to remove the warning message:

1) replace it with a dev_info and change the message:
     dev_info(&pdev->dev, "failed to get usb_clk (most likely using old 
at91 clk implementation)\n");
2) drop the log and silently ignore the missing clk (I'm not a big fan 
of this solution
     as it may lead to some errors if we're using new clk implem and the 
clock is really missing)
3) rework the current clk_set_rate function to accept clk_set_rate on 
usb clk and add clk_lookup entries
     for the usb clk (I'm not a big fan of this solution neither as this 
modifications will only be used for a short time
     until the transition to common clk framework is completed).
> Alan Stern
>

Thanks for your review.

Best Regards,

Boris
