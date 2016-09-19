From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Sep 2016 11:12:29 +0100
Subject: [RFC PATCH v2 11/11] irqchip: mbigen: promote mbigen init
In-Reply-To: <3f9b5a3e-13f4-75a4-15bc-f55e26740205@linaro.org>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
 <1473862879-7769-12-git-send-email-guohanjun@huawei.com>
 <57DABD2F.1030606@arm.com> <3f9b5a3e-13f4-75a4-15bc-f55e26740205@linaro.org>
Message-ID: <57DFBA0D.7040801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/16 10:49, Hanjun Guo wrote:
> On 2016/9/15 23:24, Marc Zyngier wrote:
>> On 14/09/16 15:21, Hanjun Guo wrote:
>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>
>>> mbigen is an irqchip and it needs to be probed before
>>> devices, same logic is used for SMMU and etc., let's
>>> use arch_initcall instead of platform init for mbigen.
>>>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ma Jun <majun258@huawei.com>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>  drivers/irqchip/irq-mbigen.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>>> index ca6add1..3a33de6 100644
>>> --- a/drivers/irqchip/irq-mbigen.c
>>> +++ b/drivers/irqchip/irq-mbigen.c
>>> @@ -374,7 +374,11 @@ static struct platform_driver mbigen_platform_driver = {
>>>  	.probe			= mbigen_device_probe,
>>>  };
>>>
>>> -module_platform_driver(mbigen_platform_driver);
>>> +static __init int mbigen_init(void)
>>> +{
>>> +	return platform_driver_register(&mbigen_platform_driver);
>>> +}
>>> +arch_initcall(mbigen_init);
>>>
>>>  MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
>>>  MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
>>>
>>
>> I've already NACKed such a patch in the past, and I will carry on
>> NACKing it until all the other avenues (like properly tracking device
>> dependencies) have been explored and have been proven not to be fit for
>> purpose.
> 
> I'd happy to work on this to make progress.
> 
>>
>> Rafael had proposed something around this subject last year, and I've
> 
> Sorry, obviously I missed something, could you give me the link about
> Rafael's patches? I will pull back and test it on our hardware.

Please see this discussion from almost a year ago:

https://patchwork.kernel.org/patch/7407401/

in which I give the existing pointers and explain why I'm pushing back
on things like this patch.

> 
>> been repeatedly advising you to work with him and others to make it
>> happen. You can choose to ignore this advise, but that doesn't make this
>> patch an acceptable approach.
> 
> OK, I will drop this patch in next version, and work on the generic
> solution instead.

That'd be the ideal thing, and that's what I suggested when we did meet
in BKK earlier this year. Obviously, I didn't convey my point clearly
enough.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
