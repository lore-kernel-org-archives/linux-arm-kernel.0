From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Nov 2013 11:53:11 -0800
Subject: [PATCH] PM / Clocks: fix pm_clk_resume/suspend if
 CONFIG_PM_RUNTIME is set
In-Reply-To: <528D082C.3040405@ti.com>
References: <1384954307-27094-1-git-send-email-grygorii.strashko@ti.com>
 <528D0296.1070001@codeaurora.org> <528D082C.3040405@ti.com>
Message-ID: <528D1327.7080205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/13 11:06, Grygorii Strashko wrote:
> On 11/20/2013 08:42 PM, Stephen Boyd wrote:
>> On 11/20/13 05:31, Grygorii Strashko wrote:
>>> @@ -230,7 +230,7 @@ int pm_clk_suspend(struct device *dev)
>>>   	list_for_each_entry_reverse(ce, &psd->clock_list, node) {
>>>   		if (ce->status < PCE_STATUS_ERROR) {
>>>   			if (ce->status == PCE_STATUS_ENABLED)
>>> -				clk_disable(ce->clk);
>>> +				clk_disable_unprepare(ce->clk);
>>>   			ce->status = PCE_STATUS_ACQUIRED;
>>>   		}
>>>   	}
>>> @@ -259,7 +259,7 @@ int pm_clk_resume(struct device *dev)
>>>   
>>>   	list_for_each_entry(ce, &psd->clock_list, node) {
>>>   		if (ce->status < PCE_STATUS_ERROR) {
>>> -			clk_enable(ce->clk);
>>> +			clk_prepare_enable(ce->clk);
>>>   			ce->status = PCE_STATUS_ENABLED;
>>>   		}
>>>   	}
>> This is inside a spin_lock_irqsave(). You should be getting scheduling
>> while atomic warnings with this change. Are you testing with
>> DEBUG_ATOMIC_SLEEP=y?
> Ops, thanks. No, It's not tested with DEBUG_ATOMIC_SLEEP and 
> I agree with you.
>
> So, I see two option here:
> 1) split above loops on two
> 2) add calls of clk_prepare()/clk_unprepare() in pm_clk_notify()
>
> In my opinion option [2] is better.
>

Doesn't that mean the clock will always be prepared as long as the
device is present? That doesn't sound good. I would like the clocks to
be disabled and unprepared as long as the device is suspended.

What is the lock protecting? The linked list or something more? Can we
remove the locks?

It looks like even if you just remove the locks here, the PM core is
free to call this function with irqs disabled if pm_runtime_irq_safe()
has been called on the device. Perhaps runtime PM can only do the
clk_enable()/clk_disable() part and the clk_unprepare()/clk_prepare()
calls should happen in the system suspend callbacks?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
