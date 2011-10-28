From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 28 Oct 2011 10:12:42 +0200
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <Pine.LNX.4.44L0.1110271206450.2004-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1110271206450.2004-100000@iolanthe.rowland.org>
Message-ID: <4EAA63FA.8050506@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Stern wrote:
> On Thu, 27 Oct 2011, Ulf Hansson wrote:
> 
>> To be able to make sure devices are put into runtime suspend
>> after a suspend sequence, the suspend_noirq callback is used.
>>
>> Previously it was was possible for drivers doing pm_runtime_suspend
>> and pm_runtime_put_sync directly from it's suspend callbacks.
>> This is now not possible due to the following commit, which solve a
>> race issue:
>>
>> PM: Limit race conditions between runtime PM and system sleep (v2)
> 
> I have a small request for this patch:
> 
>> +static int amba_pm_runtime_suspend_noirq(struct device *dev)
>> +{
> ...
>> +}
> 
>> +static int amba_pm_runtime_resume_noirq(struct device *dev)
>> +{
> ...
>> +}
> 
> Can the names of these functions be changed?  Since they run during
> system sleep transitions with IRQs disabled, they aren't really runtime
> suspend or resume routines.

Sure, we can rename/move the code - do you have a proposal? :-)

The idea with having them as separate functions and something with 
"runtime" in the name is because it is only when having 
CONFIG_PM_RUNTIME the functions actually does something.

If I move the the code into amba_pm_suspend|resume_noirq I will need 
ifdefs around the code. I am fine with that as well...

> 
> In fact, since each routine is used in only one place, maybe they can 
> be eliminated entirely and moved into their callers?
> 
> Alan Stern
> 
> 

BR
Ulf Hansson
