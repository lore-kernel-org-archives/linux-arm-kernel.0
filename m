From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Nov 2014 12:51:08 +0100
Subject: [PATCH v4] clocksource: arch_timer: Allow the device tree to
 specify uninitialized timer registers
In-Reply-To: <CAD=FV=VhaMo4fNide3a2S6jdLiq2pyOqY3hmx7ai0iDTPxCsPA@mail.gmail.com>
References: <1412753627-28287-1-git-send-email-sonnyrao@chromium.org>
 <CAD=FV=VhaMo4fNide3a2S6jdLiq2pyOqY3hmx7ai0iDTPxCsPA@mail.gmail.com>
Message-ID: <5475BEAC.9020208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Doug, Olof,

IIUC, it sounds like this patch is needed from some other patches in 
arm-soc. Olof was proposing to take this patch through its tree to 
facilitate the integration.

Olof, is it this patch you were worried about ?

Thanks

   -- Daniel

On 11/20/2014 12:01 AM, Doug Anderson wrote:
> Daniel,
>
> On Wed, Oct 8, 2014 at 12:33 AM, Sonny Rao <sonnyrao@chromium.org> wrote:
>> From: Doug Anderson <dianders@chromium.org>
>>
>> Some 32-bit (ARMv7) systems are architected like this:
>>
>> * The firmware doesn't know and doesn't care about hypervisor mode and
>>    we don't want to add the complexity of hypervisor there.
>>
>> * The firmware isn't involved in SMP bringup or resume.
>>
>> * The ARCH timer come up with an uninitialized offset (CNTVOFF)
>>    between the virtual and physical counters.  Each core gets a
>>    different random offset.
>>
>> * The device boots in "Secure SVC" mode.
>>
>> * Nothing has touched the reset value of CNTHCTL.PL1PCEN or
>>    CNTHCTL.PL1PCTEN (both default to 1 at reset)
>>
>> On systems like the above, it doesn't make sense to use the virtual
>> counter.  There's nobody managing the offset and each time a core goes
>> down and comes back up it will get reinitialized to some other random
>> value.
>>
>> This adds an optional property which can inform the kernel of this
>> situation, and firmware is free to remove the property if it is going
>> to initialize the CNTVOFF registers when each CPU comes out of reset.
>>
>> Currently, the best course of action in this case is to use the
>> physical timer, which is why it is important that CNTHCTL hasn't been
>> changed from its reset value and it's a reasonable assumption given
>> that the firmware has never entered HYP mode.
>>
>> Note that it's been said that on ARMv8 systems the firmware and
>> kernel really can't be architected as described above.  That means
>> using the physical timer like this really only makes sense for ARMv7
>> systems.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> ---
>> Changes in v2:
>> - Add "#ifdef CONFIG_ARM" as per Will Deacon
>>
>> Changes in v3:
>> - change property name to arm,cntvoff-not-fw-configured and specify
>>    that the value of CNTHCTL.PL1PC(T)EN must still be the reset value
>>    of 1 as per Mark Rutland
>>
>> Changes in v4:
>> - change property name to arm,cpu-registers-not-fw-configured and
>>    specify that all cpu registers must have architected reset values
>>    per Mark Rutland
>> - change from "#ifdef CONFIG_ARM" to "if (IS_ENABLED(CONFIG_ARM))" per
>>    Arnd Bergmann
>> ---
>>   Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++++++
>>   drivers/clocksource/arm_arch_timer.c                 | 8 ++++++++
>>   2 files changed, 16 insertions(+)
>
> Do you know what the status of this patch is?  This patch and Sonny's
> patch at <https://patchwork.kernel.org/patch/5051901/> are needed on
> Rockchip rk3288 for some specific things:
>
> 1. To make SMP happy with coreboot.
>
> 2. To (I assume) make SMP happy after S2R (no matter which firmware is
> used since I don't think anyone has PSCI for rk3288).
>
> ...we still need a DTS entry atop these patches, but that's trivial to
> add once these land.
>
> Thanks!
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
