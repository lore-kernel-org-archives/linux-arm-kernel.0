From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 01 Aug 2013 17:14:50 +0200
Subject: [PATCH] USB: ohci-at91: add usb_clk for transition to common
 clk framework
In-Reply-To: <Pine.LNX.4.44L0.1308011038380.1534-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1308011038380.1534-100000@iolanthe.rowland.org>
Message-ID: <51FA7B6A.80106@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 16:39, Alan Stern wrote:
> On Thu, 1 Aug 2013, Boris BREZILLON wrote:
>
>> The AT91 PMC (Power Management Controller) provides an USB clock used by
>> USB Full Speed host (ohci) and USB Full Speed device (udc).
>> The usb drivers (ohci and udc) must configure this clock to 48Mhz.
>> This configuration was formely done in mach-at91/clock.c, but this
>> implementation will be removed when moving to common clk framework.
>>
>> This patch adds support for usb clock retrieval and configuration, and is
>> backward compatible with the current at91 clk implementation (if usb clk
>> is not found, it does not configure/enable it).
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> @@ -163,6 +169,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>>   		goto err5;
>>   	}
>>   
>> +	uclk = clk_get(&pdev->dev, "usb_clk");
> What happens if uclk isn't found but it is needed?
It will not fail but I guess the usb host won't work as the clock won't 
be correctly
configured.

I agree with you: this is not a good solution.

Another option is to keep the previous version of this patch and put 
uclk handling
in "#ifdef CONFIG_COMMON_CLK #endif" sections.

Would this be acceptable ?

>
> Alan Stern
>
