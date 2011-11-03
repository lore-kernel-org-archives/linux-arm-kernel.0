From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 3 Nov 2011 09:44:14 +0100
Subject: [PATCH V3] AMBA: Put devices into low-power state in suspend_noirq
In-Reply-To: <201111022357.09759.rjw@sisk.pl>
References: <1320142497-16750-1-git-send-email-ulf.hansson@stericsson.com>
	<4EB14ABB.6020103@stericsson.com>
	<20111102140453.GF19187@n2100.arm.linux.org.uk>
	<201111022357.09759.rjw@sisk.pl>
Message-ID: <4EB2545E.2000504@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael J. Wysocki wrote:
> On Wednesday, November 02, 2011, Russell King - ARM Linux wrote:
>> On Wed, Nov 02, 2011 at 02:50:51PM +0100, Ulf Hansson wrote:
>>> Just some thinking, you may comment if you like....
>>>
>>> When using a power_domain this will then mean that the power domain  
>>> callbacks for suspend|resume should take similar actions as they do in  
>>> their runtime_suspend|resume callbacks to put the devices into low power  
>>> state. This should be in line of what you prefer?
>> If it is appropriate to cut the vcore for the device when in runtime
>> suspend state, then a driver itself has to explicitly do that.  vcore
>> handling is different from pclk handling because loss of vcore requires
>> the device to be reinitialized, whereas pclk does not.
> 
> Well, I have a comment here.
> 
> There are systems having separate logic for removing power from power
> domains, so individual drivers obviously can't do that.  What they
> can do is to indicate that their devices don't need power at the moment,
> which is done by using the runtime PM reference counting, and the
> subsystem layer has to take care of the actual power removal.
> 
>>> This will mean some duplicated code but at the same time give the device  
>>> driver full control and responsibility of putting its device in  
>>> low-power state.
>> It should not mean any duplicated code - if a driver itself wishes to call
>> its runtime suspend and resume handlers from its normal suspend/resume
>> handlers, that's a choice it can make (and it alone can make).  Again,
>> take a moment to think a little more about your original proposal of
>> pushing that into the bus layer.
>>
>> And consider the case of a non-runtime PM system (where the runtime PM
>> callbacks are NULL) yet you have system suspend enabled, and you trigger
>> a system suspend.  Do you really want the suspend of the devices to be
>> skipped because the runtime PM callbacks were NULL because of system
>> configuration?

This is a fact and is as I see it the main reason to why not this patch 
should not be accepted.

>>
>> With them being explicit calls in the driver, this doesn't happen because
>> if you omit those functions for non-runtime PM, you'll get a link error.
>>
>>> In parallel it would then also make sense to remove the pm_runtime  
>>> handling completely from the amba bus and let the pclk be fully runtime  
>>> handled from the device driver instead. Since it must handle it from  
>>> suspend anyway...
>> We know that it's safe to handle the pclk at the bus layer for normal
>> runtime PM as it causes no state loss.  We also know that throwing the
>> vcore handling in there is the wrong thing to do because it does cause
>> state loss and therefore needs proper handling at the driver level.

The main reason for putting this into the bus was to remove the handling 
of pclk from the device drivers since it was common for all drivers. Due 
to the above discussion it will be there anyway, but for 
suspend|suspend_noirq instead.

In my perfect world :-), either the bus controls the pclk completely or 
not, to have something in between just does not feel right.

So either I suggest to remove the runtime handling of the pclk and then 
move the responsibility to the drivers (I think it will be somewhat 
cleaner code in each device driver if this is done) or add handling of 
the pclk to the amba normal suspend|resume functions as well, that could 
be feasible as well.

One additional thought, considering using a power domain with runtime 
functions. Ideally the power domain will do it's runtime stuff and then 
would like to call the pm_generic_runtime_* functions which right now is 
going directly towards the driver and skipping the bus etc. This might 
be another discussion though, but never the less, it could be a reason 
to why not have runtime functions at all in the bus.

>>
>> Hence, the bus code can take care of the pclk but not for vcore.
>>
>> So, I don't see any reason to change the bus code.
> 
> I agree.
> 
> At least calling a driver's .runtime_resume() callback from the bus type's
> _resume_noirq() one doesn't seem quite right (and analogously for suspend).
> It generally is expected that drivers will provide their own .suspend_noirq()
> and .resume_noirq() callbacks, which may point to the same callback routines
> as .runtime_suspend() and .runtime_resume(), respectively, in some cases.
> 
> It _may_ lead to some code duplication in some cases, but that may be avoided
> by using the struct dev_pm_domain pointer in struct device.  In some cases.
> 
> Thanks,
> Rafael
> 
