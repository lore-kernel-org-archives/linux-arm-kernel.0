From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 09 Sep 2011 09:50:16 +0530
Subject: [PATCH 25/25] OMAP3: CPUidle: Make use of CPU PM notifiers
In-Reply-To: <87vct2hq79.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-26-git-send-email-santosh.shilimkar@ti.com>
	<87vct2hq79.fsf@ti.com>
Message-ID: <4E699400.2070706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011 11:27 PM, Kevin Hilman wrote:
> Hi Santosh,
>
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> These notifiers can be used to isolate non-cpu specific PM
>> code from CPU idle code.
>>
>> To start with, we can already leverage VFP handlers using notifier
>> chain for low power idle code. So use them.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> A comment below related to our other discussion in the CPU PM notifiers
> thread...
>
After the discussion, this patch needs to be updated.

>> ---
>>   arch/arm/mach-omap2/cpuidle34xx.c |    7 +++++++
>>   1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
>> index 4bf6e6e..1112519 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -24,6 +24,7 @@
>>
>>   #include<linux/sched.h>
>>   #include<linux/cpuidle.h>
>> +#include<linux/cpu_pm.h>
>>
>>   #include<plat/prcm.h>
>>   #include<plat/irqs.h>
>> @@ -118,9 +119,15 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>>   		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
>>   	}
>>
>> +	if (mpu_state == PWRDM_POWER_OFF)
>> +		cpu_pm_enter();
>
> Making all CPU PM notifiers conditional on the MPU power state is not
> right since upon an MPU transition, other domains might also transition.
>
> What if there are notifiers for other drivers in other power domains
> whose states might be transitioning?  Notifiers for those devices should
> be called no matter what the MPU's target state is.
>
> Also triggering the notifiers here has the same problem that I mentioned
> with the syscore PM ops.  Namely, that next power states are not yet
> determined, so any device notifier decisions based on that will be wrong.
>
> The way I envision this working is (at least on OMAP) is CPU PM
> notifiers are triggered only *after* the next power states are
> determined and programmed.  This allows the device-specific notifiers to
> check their target power state and take appropriate action.
>
> I've been testing the CPU PM notifiers with the patch below (after also
> dropping [PATCH 2/5] from your the CPU PM notifiers series.)  This patch works
> for both suspend and idle by using the code common to them, and
> triggering the event only after the target states are programmed.
>
> I'm testing this patch now along with the 2nd patch below which removes
> all the UART calls from the idle/suspend path and just adds a notifier
> in the UART driver.
>
> Will post these officially after a bit more testing, but so far it's
> working on OMAP2420/n810 and OMAP3430/n900.
>
Agree. I will drop my patch in favour of below patch.

Regards
Santosh
