From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 13 Nov 2014 22:13:03 +0200
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <7390758.7nHkBpm2Zh@vostro.rjw.lan>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>
 <545D0074.7060205@ti.com> <7390758.7nHkBpm2Zh@vostro.rjw.lan>
Message-ID: <546510CF.7060004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2014 04:07 AM, Rafael J. Wysocki wrote:
> On Friday, November 07, 2014 07:25:08 PM Grygorii Strashko wrote:
> 
> [cut]
> 
>>
>> 4) I've copied here comment from Rafael:
>>   >>>> Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
>>   >>>> it must take the fact that the driver's own ->runtime_resume() may be called
>>   >>>> as a result of this into account.
>>   Agree, that's a little bit annoying, but we are living with that for more then
>>   5 years already (I'm 3 years) - so, I am, as driver developer, expecting above behavior
>>   (just walk through the drivers and you will see how many drivers expecting the same).
>>
>> So, any volunteers to check and fix ~500 drivers.
> 
> Where did you get that number from?

Sry, my bad. Rechecked - found 289 occurrences of pm_runtime_enable().
Number of Runtime PM enabled drivers = at about 289 +-10%.
- headers, suspend/resume,..
+ buses like amba and spmi 

> 
> Also please note that some bus types don't have this problem by design (e.g. PCI,
> as pointed to by Alan).

Right. I worry about Platform bus first of all, because HW PM implementation
(at least for ARM SoCs) can be very different there.

> 
> [cut]
> 
>>>
>>>>
>>>> - Runtime PM (if compiled in) needs to be enabled for all devices in power
>>>>     domains by default.  Otherwise devices may lose power as a result for
>>>>     power management of the other devices in the same domain.
>>
>> It should prevent enabling/disabling of RPM from sys_fs too.
> 
> It looks like you're confusing disable/enable with auto/on.  These are different
> things.
> 
>>>>
>>>> - The core should try to power up domains before calling really_probe() both
>>>>     for CONFIG_PM_RUNTIME set and unset, so ->probe() can always make the
>>>>     "device is accessible" assumption.
>>
>> Here I'm still think that pm_runtime_get_sync() (or similar) API should work.
>> Another way, PM domain should decide what to do when the first device attached to it
>> - power up and stay powered on for example
>>   (It will work if devices are attached before ->probe();
>>    it will not work if devices will be attached once they've been created, but this is different
>>    question)
> 
> The PM domain itself can't do that.  The only place that has enough knowledge
> is the code that enumerates devices (DT, ACPI or board-specific).
> 
>>>
>>> And how exactly will you then power up the PM domain when
>>> CONFIG_PM_RUNTIME is unset?
>>>
>>>>
>>>> - Bus types may need to do more on top of that in their ->probe(), so the
>>>>     driver's ->probe() can make that assumption too in all cases.
>>>>
>>>> Does that make sense to you?
>>>
>>
>> I would like to take the liberty to add a couple of points from me:
>>   - it seems reasonable to have ability to disable Runtime PM globally from sys_fs:
>>     once disabled - "get" should power on device, "put" should do nothing all the
>>     time except when ->remove() is called.
> 
> This is how the "power/control" file works and you can easily have this by writing
> "on" to that file for every device.
> 
>>   
>>   - It might be reasonable to add API like pm_runtime_probe_getXXX() which will do
>>     everything what standard pm_runtime_get_sync() is doing with one exception:
>>     it will not call driver's .runtime_resume() callback.
> 
> Use case?

This is just a different view (RFC) on your idea to call pm_runtime_get_sync()
 before dev->driver is initialized
("(b) bypassing the driver callbacks somehow".
  http://marc.info/?l=linux-pm&m=141505768026211&w=2)

- add some flag like dev->is_probing
- in pm_runtime_probe_get_sync() do
  dev->is_probing = true;
  pm_runtime_get_sync();
  dev->is_probing = false;
  
- update 3 places in code pm_generic_runtime_resume, pm_genpd_default_save_state and
  __rpm_get_callback like below (only for .runtime_resume):

+++ b/drivers/base/power/generic_ops.c
@@ -42,6 +42,9 @@ int pm_generic_runtime_resume(struct device *dev)
 {
        const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
        int ret;
+       
+       if (dev->is_probing)
+               pm = NULL;

Then drivers (at least platform drivers) will be able to call
  pm_runtime_enable(dev);
  pm_runtime_probe_get_sync(dev);
at any time they think is right (no problem with parent devices,
Power domain will be enabled, class/type/bus callback will be called,
no need to use pm_runtime_set_active()).

regards,
-grygorii
