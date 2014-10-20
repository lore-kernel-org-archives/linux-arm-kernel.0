From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 20 Oct 2014 18:58:22 +0200
Subject: [PATCH v2 2/2] ARM: EXYNOS: Call regulator core suspend prepare
 and finish functions
In-Reply-To: <CAD=FV=UtwNjyx56QtRrEo=jbX_PeMRAYZJVXzxqeS-vs4JyGRg@mail.gmail.com>
References: <1413454410-23396-1-git-send-email-javier.martinez@collabora.co.uk>	<1413454410-23396-3-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=UtwNjyx56QtRrEo=jbX_PeMRAYZJVXzxqeS-vs4JyGRg@mail.gmail.com>
Message-ID: <54453F2E.1080401@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Chris Zong as cc who posted a similar patch for Rockchip]

Hello Doug,

On 10/20/2014 06:26 PM, Doug Anderson wrote:
> Javier,
> 
> On Thu, Oct 16, 2014 at 3:13 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> The regulator framework has a set of helpers functions to be used when
>> the system is entering and leaving from suspend but these are not called
>> on Exynos platforms. This means that the .set_suspend_* function handlers
>> defined by regulator drivers are not called when the system is suspended.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/mach-exynos/suspend.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
>> index cc8d237..ee9a8e0 100644
>> --- a/arch/arm/mach-exynos/suspend.c
>> +++ b/arch/arm/mach-exynos/suspend.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/io.h>
>>  #include <linux/irqchip/arm-gic.h>
>>  #include <linux/err.h>
>> +#include <linux/regulator/machine.h>
>>
>>  #include <asm/cacheflush.h>
>>  #include <asm/hardware/cache-l2x0.h>
>> @@ -443,6 +444,22 @@ static int exynos_suspend_enter(suspend_state_t state)
>>
>>  static int exynos_suspend_prepare(void)
>>  {
>> +       int ret;
>> +
>> +       /*
>> +        * REVISIT: It would be better if struct platform_suspend_ops
>> +        * .prepare handler get the suspend_state_t as a parameter to
>> +        * avoid hard-coding the suspend to mem state. It's safe to do
>> +        * it now only because the suspend_valid_only_mem function is
>> +        * used as the .valid callback used to check if a given state
>> +        * is supported by the platform anyways.
>> +        */
>> +       ret = regulator_suspend_prepare(PM_SUSPEND_MEM);
>> +       if (ret) {
>> +               pr_err("Failed to prepare regulators for system suspend\n");
>> +               return ret;
>> +       }
>> +
>>         s3c_pm_check_prepare();
>>
>>         return 0;
>> @@ -451,6 +468,7 @@ static int exynos_suspend_prepare(void)
>>  static void exynos_suspend_finish(void)
>>  {
>>         s3c_pm_check_cleanup();
>> +       regulator_suspend_finish();
> 
> It turns out that regulator_suspend_finish() actually returns an error
> code.  Could you print a warning if you see it?
> 

Yes, I noticed this when looking at Chris patch for Rockchip but didn't re-spin
because I'm not sure anymore if this is the right solution. I mean, if is
correct to add the same calls on every platform or if the regulator suspend
prepare and finish functions should be called from the suspend core instead.

For example calling regulator_suspend_prepare() from platform_suspend_prepare()
[0] will have the advantage of passing the correct suspend_state_t state instead
of hard-coding PM_SUSPEND_MEM and will make the regulator suspend states to work
on all platforms.

> Other than that, feel free to add my Reviewed-by.  Thanks!
> 
> -Doug
> 

Best regards,
Javier

[0]: http://lxr.free-electrons.com/source/kernel/power/suspend.c#L141
