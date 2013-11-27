From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Nov 2013 13:32:04 -0500
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <20131127174140.GE8123@saruman.home>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-2-git-send-email-w-kwok2@ti.com> <5295B93A.3040400@ti.com>
 <20131127174140.GE8123@saruman.home>
Message-ID: <52963AA4.6030007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 November 2013 12:41 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Nov 27, 2013 at 02:49:54PM +0530, George Cherian wrote:
>>> +	error = of_platform_populate(node, NULL, NULL, dev);
>>> +	if (error) {
>>> +		dev_err(&pdev->dev, "failed to create dwc3 core\n");
>>> +		goto err_core;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +err_core:
>>> +	kdwc3_disable_irqs(kdwc);
>>> +err_irq:
>>> +	kdwc3_disable(kdwc);
>>> +
>>> +	return error;
>>> +}
>>> +
>>> +static int kdwc3_remove(struct platform_device *pdev)
>>> +{
>>> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
>>> +
>>> +	if (kdwc) {
>>> +		kdwc3_disable_irqs(kdwc);
>>> +		kdwc3_disable(kdwc);
>>> +		platform_set_drvdata(pdev, NULL);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>
>> You need to unregister the child nodes in remove.
>> Also why can't the dwc3-omap driver be reused, Felipe??
>> I believe the TI wrapper for Keystone is similar to that of AM437x or
>> OMAP5.
> 
> it is very similar indeed, if it can be easily re-use that glue, I'd
> rather not add another.
> 
Initial idea was actually to use same driver but the integration IP
is quite different on Keystone vs OMAP which lead to have a separate
glue layer. They look similar but there are differences in terms of phys,
interrupts, register space. And also non OTG support, runtime PM
vs clock etc for now.

After all the glue is really a very small code describes the integration
details thanks to nice abstracted dwc3 core layer. So as discussed
over irc, keeping the separate glue is preferred but do let us know
if you think otherwise.

Regards,
Santosh
