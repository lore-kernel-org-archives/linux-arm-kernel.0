From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 12 Dec 2013 14:36:01 -0500
Subject: [PATCH v3 1/2] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <20131212174838.GE1939@saruman.home>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-2-git-send-email-w-kwok2@ti.com>
 <20131210025110.GA20090@saruman.home> <52A72F28.10909@ti.com>
 <20131212174838.GE1939@saruman.home>
Message-ID: <52AA1021.2010505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013 12:48 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Dec 10, 2013 at 10:11:36AM -0500, Santosh Shilimkar wrote:
>>>> +static int kdwc3_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
>>>> +
>>>> +	kdwc3_disable_irqs(kdwc);
>>>> +	clk_disable_unprepare(kdwc->clk);
>>>
>>> I hope the clock isn't shared between core and wrapper, otherwise you
>>> could run into some troubles here. Can you confirm ?
>>>
>> Yes. the clock isn't shared. Thanks for taking care of other parts.
> 
> so clock for core is always running too ?
> 
I take that back. The clock is actually common so we should disable
it after removing the  kdwc3_remove_core() as you suggested.

You won't see issue since the  kdwc3_remove_core() not doing
any register access but moving the clock disable after
the core remove is right thing to do.

Regards,
Santosh
