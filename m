From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Aug 2014 14:32:28 +0530
Subject: [PATCH v7 RESEND] ARM: omap: edma: add suspend suspend/resume
 hooks
In-Reply-To: <53FC4980.1070606@zonque.org>
References: <1408693562-18068-1-git-send-email-d-gerlach@ti.com>
 <53FC2AD4.4070400@ti.com> <53FC4980.1070606@zonque.org>
Message-ID: <53FC4D24.3020108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 August 2014 02:16 PM, Daniel Mack wrote:
> Hi,
> 
> On 08/26/2014 08:36 AM, Sekhar Nori wrote:
>> On Friday 22 August 2014 01:16 PM, Dave Gerlach wrote:
> 
> Thanks for pushing that forward!
> 
>>> +static int edma_pm_suspend(struct device *dev)
>>> +{
>>> +	int j, r;
>>> +
>>> +	r = pm_runtime_get_sync(dev);
>>> +	if (r < 0) {
>>> +		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
>>> +		return r;
>>> +	}
>>
>> The driver currently does a pm_runtime_get_sync() once during probe. And
>> does not do a put(). So this should actually be not required. In fact
>> looks like this additional get() call will prevent the clock from
>> getting disabled which is probably not what you intend.
> 
> Well, the pm runtime is put again ...
> 
>>> +
>>> +	for (j = 0; j < arch_num_cc; j++) {
>>> +		struct edma *ecc = edma_cc[j];
>>> +
>>> +		disable_irq(ecc->irq_res_start);
>>> +		disable_irq(ecc->irq_res_end);
>>
>> Do we really need to disable these irqs?
>>
>>> +	}
>>> +
>>> +	pm_runtime_put_sync(dev);
> 
> ... here, so it's in sync and should be fine.

May be I am missing something but because of the pm_runtime_get_sync()
in probe() usage count is already 1 when suspend() is called. The
pm_runtime_get_sync() in this function makes it 2 and therefore
pm_runtime_put_sync() returns immediately because the usage count is
greater that 0 after decrementing by 1. That means the module's clocks
is not disabled after suspend() is finished.

> 
> I was also sure than when I wrote the code, disabling the interrupts
> during suspend was necessary, and even the only thing that has to be
> done at suspend time. Now that I address this again, my tests show that
> in can in fact be omitted.

Thanks!

Regards,
Sekhar
