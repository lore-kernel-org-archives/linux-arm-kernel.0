From: wuyun.wu@huawei.com (Yun Wu (Abel))
Date: Wed, 4 Mar 2015 11:10:55 +0800
Subject: [PATCH v2 5/6] irqchip: gicv3-its: add support for power down
In-Reply-To: <54E333CE.5010800@huawei.com>
References: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
 <1423992723-5028-6-git-send-email-wuyun.wu@huawei.com>
 <20150217092935.1fefcb24@arm.com> <54E314B3.40803@huawei.com>
 <20150217111104.5718d6f1@arm.com> <54E333CE.5010800@huawei.com>
Message-ID: <54F677BF.9060208@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/17 20:27, Yun Wu (Abel) wrote:

> On 2015/2/17 19:11, Marc Zyngier wrote:
> 
>> On Tue, 17 Feb 2015 10:15:15 +0000
>> "Yun Wu (Abel)" <wuyun.wu@huawei.com> wrote:
>>
>>> On 2015/2/17 17:29, Marc Zyngier wrote:
>>>
>>>> On Sun, 15 Feb 2015 09:32:02 +0000
>>>> Yun Wu <wuyun.wu@huawei.com> wrote:
>>>>
>>>>> It's unsafe to change the configurations of an activated ITS
>>>>> directly since this will lead to unpredictable results. This patch
>>>>> guarantees a safe quiescent status before initializing an ITS.
>>>>
>>>> Please change the title of this patch to reflect what it actually
>>>> does. Nothing here is about powering down anything.
>>>
>>> My miss, I will fix this in next version.
>>>
>>>>
>>>>> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
>>>>> ---
>>>>>  drivers/irqchip/irq-gic-v3-its.c | 32
>>>>> ++++++++++++++++++++++++++++++++ 1 file changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c
>>>>> b/drivers/irqchip/irq-gic-v3-its.c index 42c03b2..29eb665 100644
>>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>>> @@ -1321,6 +1321,31 @@ static const struct irq_domain_ops
>>>>> its_domain_ops = { .deactivate		=
>>>>> its_irq_domain_deactivate, };
>>>>>
>>>>> +static int its_check_quiesced(void __iomem *base)
>>>>> +{
>>>>> +	u32 count = 1000000;	/* 1s */
>>>>> +	u32 val;
>>>>> +
>>>>> +	val = readl_relaxed(base + GITS_CTLR);
>>>>> +	if (val & GITS_CTLR_QUIESCENT)
>>>>> +		return 0;
>>>>> +
>>>>> +	/* Disable the generation of all interrupts to this ITS */
>>>>> +	val &= ~GITS_CTLR_ENABLE;
>>>>> +	writel_relaxed(val, base + GITS_CTLR);
>>>>> +
>>>>> +	/* Poll GITS_CTLR and wait until ITS becomes quiescent */
>>>>> +	while (count--) {
>>>>> +		val = readl_relaxed(base + GITS_CTLR);
>>>>> +		if (val & GITS_CTLR_QUIESCENT)
>>>>> +			return 0;
>>>>> +		cpu_relax();
>>>>> +		udelay(1);
>>>>> +	}
>>>>
>>>> You're now introducing a third variant of a 1s timeout loop. Notice
>>>> a pattern?
>>>>
>>>
>>> I am not sure I know exactly what you suggest. Do you mean I should
>>> code like below to keep the coding style same as the other 2 loops?
>>>
>>> 	while (1) {
>>> 		val = readl_relaxed(base + GITS_CTLR);
>>> 		if (val & GITS_CTLR_QUIESCENT)
>>> 			return 0;
>>>
>>> 		count--;
>>> 		if (!count)
>>> 			return -EBUSY;
>>>
>>> 		cpu_relax();
>>> 		udelay(1);
>>> 	}
>>
>> That'd be a good start. But given that this is starting to be a common
>> construct, it could probably be rewritten as:
>>
>> static int its_poll_timeout(struct its_node *its, void *data,
>>                             int (*fn)(struct its_node *its,
>>                                       void *data))
>> {
>> 	while (1) {
>> 		if (!fn(its, data))
>> 			return 0;
>>
>> 		...
>> 	}
>> }
>>
>> and have the call sites to provide the right utility function. We also
>> have two similar timeout loops in the main GICv3 driver, so there
>> should be room for improvement.
>>
>> Thoughts?
>>


Hi Marc,

Currently I didn't make any improvement on providing a unified utility
function to do the timeout loops, because I haven't found a proper way
yet. And to achieve this, at least three aspects I can imagine are
needed to be considered.

Refactoring the existing loop functions comes first. A prototype is
showed below.

	static T1 func_prototype(T2 node, char *msg, void **args)
	{
		u32 count = 1000000;

		do_something_here(node, args);

		while (1) {
			if (condition_satisfied(node, args))
				return (T1)SUCCESS;

			count--;
			if (!count) {
				print_err_msg(msg);
				return (T1)FAIL;
			}

			cpu_relax();
			udelay(1);
		}
	}

Obviously it will make things complicated to move do_something_here() and
print_err_msg() outside of func_prototype(), because func_prototype() could
be called sereval places. But the two functions are different from each
loop function, so...

	static T1 func_prototype(T2 node, char *msg, void **args)
	{
		u32 count = 1000000;

		do_something_here(node, args);

		while (count--) {
			if (condition_satisfied(node, args))
				return (T1)SUCCESS;

			cpu_relax();
			udelay(1);
		}

		print_err_msg(msg);
		return (T1)FAIL;
	}

Now we can unify the loop part,

	static bool condition_satisfied(T2 node, void **args);

	static u32 poll_timeout(T2 node, void **args,
				bool (*fn)(T2, void **))
	{
		u32 count = 1000000;

		while (count--) {
			if (fn(node, args))
				break;

			cpu_relax();
			udelay(1);
		}

		return count;
	}

	static T1 func_prototype(T2 node, char *msg, void **args)
	{
		do_something_here(node, args);

		if (poll_timeout(node, args, condition_satisfied)) {
			return (T1)SUCCESS;
		} else {
			print_err_msg(msg);
			return (T1)FAIL;
		}
	}

Look at what I have done, turn the original N loop functions to 2*N+1 functions.
It can hardly be called improvement.. :(

The 2nd and 3rd aspects are return value and list of parameters respectively.
Using (void *) may help a lot, I think.

Thoughts?

Thanks,
	Abel
