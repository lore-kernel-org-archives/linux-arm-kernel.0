From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 25 Apr 2016 15:32:52 +0200
Subject: [PATCH] PM / Runtime: Defer resuming of the device in
 pm_runtime_force_resume()
In-Reply-To: <3340490.Br5NVWnCR9@avalon>
References: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
 <3340490.Br5NVWnCR9@avalon>
Message-ID: <CAPDyKFoQp+-t=c8-Y6+f9U+WJHMEtwGUQ=+PaVNc1-vUkV8CEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2016 at 19:31, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Ulf,
>
> Thank you for the patch.
>
> On Thursday 21 Apr 2016 12:34:02 Ulf Hansson wrote:
>> When the pm_runtime_force_suspend|resume() helpers were invented, we still
>> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>>
>> To make sure these helpers worked for all combinations and without
>> introducing too much of complexity, the device was always resumed in
>> pm_runtime_force_resume().
>>
>> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
>> unset, we needed to resume the device as the subsystem/driver couldn't
>> rely on using runtime PM to do it.
>>
>> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
>> removed this combination, of using CONFIG_PM_SLEEP without the earlier
>> CONFIG_PM_RUNTIME.
>>
>> For this reason we can now rely on the subsystem/driver to use runtime PM
>> to resume the device, instead of forcing that to be done in all cases. In
>> other words, let's defer this to a later point when it's actually needed.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Note, this patch is based upon another not yet queued patch [1]. The reason
>> is simply because that [1] is a more important patch as it fixes a problem.
>> It was posted to linux-pm April 8th and I expect it (or a new revision of
>> it) to be applied before $subject patch.
>>
>> [1]
>> https://patchwork.kernel.org/patch/8782851
>>
>> ---
>>  drivers/base/power/runtime.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index b746904..a190ca0 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -1506,6 +1506,17 @@ int pm_runtime_force_resume(struct device *dev)
>>               goto out;
>>       }
>>
>> +     /*
>> +      * The PM core increases the runtime PM usage count in the system PM
>> +      * prepare phase. If the count is greather than 1 at this point, someone
>> +      * else has also increased it. In such case, let's make sure to runtime
>> +      * resume the device as that is likely what is expected. In other case
>> +      * we trust the subsystem/driver to runtime resume the device when it's
>> +      * actually needed.
>> +      */
>> +     if (atomic_read(&dev->power.usage_count) < 2)
>> +             goto out;
>> +
>>       ret = pm_runtime_set_active(dev);
>>       if (ret)
>>               goto out;
>
> This works in the sense that it prevents devices from being PM resumed at
> system resume time if not needed. However, devices that are part of a PM
> domain and that were idle before system suspend are suspended twice (with
> their .runtime_suspend() handler called twice), which is not good at all.
>
> The first suspend occurs at system suspend time, with
> pm_runtime_force_suspend() rightfully suspending the device as the device is
> active (due to being woken up by pm_genpd_prepare()). The second suspend
> occurs at resume time due to device_complete() calling pm_runtime_put().
>
> I've tracked the issue to the fact that pm_genpd_complete() calls
> pm_runtime_set_active() regardless of whether the device was PM resumed or
> not. As pm_runtime_force_suspend() doesn't resume devices with this patch
> applied, the pm_runtime_put() call from device_complete() will try to runtime
> suspend the device a second time as the state is incorrectly set to
> RPM_ACTIVE.
>
> With the current genpd implementation this patch isn't needed (and neither is
> my patch), as genpd expects the device to be always active when the system is
> resumed. However, when genpd isn't used, pm_runtime_force_resume() needs to
> skip resuming devices that were suspended before system suspend. This patch
> looks good to me to fix that problem.
>
> Do we need to fix genpd first ?

Following you reasoning, I agree!

Let's put this patch on hold for a little while. I am already working
on changing genpd, so it shouldn't take long before I can post some
additional genpd patches improving the behaviour.

Kind regards
Uffe
