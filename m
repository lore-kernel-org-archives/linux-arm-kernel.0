From: rob.lee@linaro.org (Rob Lee)
Date: Mon, 27 Feb 2012 13:27:53 -0600
Subject: [PATCH v5 3/9] ARM: omap: Consolidate OMAP3 cpuidle time keeping
 and irq enable
In-Reply-To: <CAORVsuVCdFQUJC_cVngwUa-7faQiyT+3KrsbOmXbBjWsknFBZQ@mail.gmail.com>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-4-git-send-email-rob.lee@linaro.org>
 <CAORVsuVCdFQUJC_cVngwUa-7faQiyT+3KrsbOmXbBjWsknFBZQ@mail.gmail.com>
Message-ID: <CAMXH7KFcWBfZtPGKCDD3zvc9AkN4yiP8rD4vXk8aK51Hr8NhTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 10:26 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> On Mon, Feb 27, 2012 at 5:47 AM, Robert Lee <rob.lee@linaro.org> wrote:
>> Use core cpuidle timekeeping and irqen wrapper and remove that
>> handling from this code.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> ?arch/arm/mach-omap2/cpuidle34xx.c | ? 43 +++++++++++++++---------------------
>> ?1 files changed, 18 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
>> index 464cffd..1f6123f 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> ...
>
>> ?/**
>> + * omap3_enter_idle - Programs OMAP3 to enter the specified state
>> + * @dev: cpuidle device
>> + * @drv: cpuidle driver
>> + * @index: the index of state to be entered
>> + *
>> + * Called from the CPUidle framework to program the device to the
>> + * specified target state selected by the governor.
>> + */
>> +static int omap3_enter_idle(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
>> +{
>> + ? ? ? return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
> Is it the intention to call cpuidle_wrap_enter from the non-common
> code? Could the driver set en_core_tk_irqen to 1 and so let the core
> call the idle function? Is it to have the time measurement code closer
> to the low level idle code in ?__omap3_enter_idle?
>

Yes, Yes, and Yes.

>> +}
>> +
>> +/**
>> ?* next_valid_state - Find next valid C-state
>> ?* @dev: cpuidle device
>> ?* @drv: cpuidle driver
>> @@ -295,6 +287,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>> ? ? ? ?new_state_idx = next_valid_state(dev, drv, index);
>>
>> ?select_state:
>> +
> Stray change
>

Oops, thanks.

>> ? ? ? ?ret = omap3_enter_idle(dev, drv, new_state_idx);
>>
>> ? ? ? ?/* Restore original PER state if it was modified */
>> --
>> 1.7.1
>>
>
> Regards,
> Jean
