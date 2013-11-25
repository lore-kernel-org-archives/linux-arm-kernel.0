From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 25 Nov 2013 12:05:28 +0200
Subject: [PATCH] PM / Clocks: fix pm_clk_resume/suspend if
 CONFIG_PM_RUNTIME is set
In-Reply-To: <528FAA00.9060801@ti.com>
References: <1384954307-27094-1-git-send-email-grygorii.strashko@ti.com>
 <528D0296.1070001@codeaurora.org> <528D082C.3040405@ti.com>
 <528D1327.7080205@codeaurora.org> <528D1784.8080704@ti.com>
 <528D1C49.3020301@ti.com> <87ppps6zve.fsf@linaro.org>
 <528FAA00.9060801@ti.com>
Message-ID: <529320E8.7030703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2013 09:01 PM, Santosh Shilimkar wrote:
> On Friday 22 November 2013 01:43 PM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>> [...]
>>
>>>>> It looks like even if you just remove the locks here, the PM core is
>>>>> free to call this function with irqs disabled if pm_runtime_irq_safe()
>>>>> has been called on the device. Perhaps runtime PM can only do the
>>>>> clk_enable()/clk_disable() part and the clk_unprepare()/clk_prepare()
>>>>> calls should happen in the system suspend callbacks?
>>>>
>>>> Even don't know what to say :( On Keystone clk_unprepare()/clk_prepare() are NOPs.
>>>> But clk_prepare() has to be called at least once before clk_enable() :((
>>>> So, solution with suspend/resume will not fix current problem :( unfortunately.
>>>>
>>>> FYI, Now pm_clk_suspend/pm_clk_resume are called from arch/arm/mach-keystone/pm_domain.c
>>>> (also similar solution is used by Davinci, but issue has not been detected because
>>>> PM runtime hasn't been used by Davinci IP drivers before)
>>>>
>>> One way to deal with this is to have clk_unprepare()/clk_prepare()
>>> called from dev_pm_domain ops before calling pm_clk_[suspend/resume]() if we
>>> can't have that as part of runtime code.
>>
>> That doesn't solve the irq_safe problem that Stephen pointed out without
>> being very careful.  Basically, if you have _any_ potentially sleeping
>> calls in this path, you can never allow devices to use
>> pm_runtime_irq_safe().
>>
> You are right. I realized that after reading the code.
> 
>> Also, I don't like having the clk_enable in the PM core but the
>> clk_prepare in the platform-specific pm_domain.  That seems prone for
>> platforms to get wrong.
>>
> Agree.
> 
>> I'll need to think about this a little more before having any idea what
>> to do here.
>>
> Thanks Kevin for looking into it.

May be it can be solved through CCF by introducing additional flag like
CLK_SET_NO_PREPARE for cases when clocks perpetration isn't really needed.
So, when this flag is set CCF will just auto-increment "prepare_count" 
when clock is registered.

Of Course, this will not solve the case when clock need to be prepared and
driver wants to use PM Runtime, but for SoCs like Keystone that can be
fast & simple solution. 


Regards,
- grygrorii
