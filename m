From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 17 Jul 2013 17:45:39 +0200
Subject: [PATCH v3 6/7] USB: ohci-at91: add usb_clk for transition to
 common clk framework
In-Reply-To: <Pine.LNX.4.44L0.1307171131580.1555-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1307171131580.1555-100000@iolanthe.rowland.org>
Message-ID: <51E6BC23.6020700@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/2013 17:33, Alan Stern wrote:
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
> This does not take into account any of the changes you discussed with
> Russell King and me -- it is exactly the same as the previous version.
Sorry, I don't understand. I didn't send any new version since yesterday.

I'm sending it right now and it's part of the
"ARM: at91: move to common clk framework" series (as discussed with you).


>> @@ -144,6 +150,11 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>>   		goto err2;
>>   	}
>>   
>> +	uclk = clk_get(&pdev->dev, "usb_clk");
>> +	if (IS_ERR(uclk)) {
>> +		uclk = NULL;
>> +		dev_warn(&pdev->dev, "failed to get usb_clk\n");
>> +	}
>>   	iclk = clk_get(&pdev->dev, "ohci_clk");
>>   	if (IS_ERR(iclk)) {
>>   		dev_err(&pdev->dev, "failed to get ohci_clk\n");
>> @@ -212,10 +223,11 @@ static void usb_hcd_at91_remove(struct usb_hcd *hcd,
>>   	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
>>   	usb_put_hcd(hcd);
>>   
>> +	clk_put(uclk);
> What will clk_put() do when uclk is NULL?
>
> Alan Stern
>
