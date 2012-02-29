From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 29 Feb 2012 15:17:59 -0600
Subject: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
In-Reply-To: <87obsheazt.fsf@ti.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
 <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
 <87obsheazt.fsf@ti.com>
Message-ID: <CAMXH7KFHdh=bsJizq1MBUi7L0x1U4Tgr=DR2G_ZkyuKonnTJ0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 12:43 PM, Kevin Hilman <khilman@ti.com> wrote:
> Robert Lee <rob.lee@linaro.org> writes:
>
>> Make necessary changes to implement time keeping and irq enabling
>> in the core cpuidle code. ?This will allow the removal of these
>> functionalities from various platform cpuidle implementations whose
>> timekeeping and irq enabling follows the form in this common code.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> ?arch/arm/include/asm/cpuidle.h | ? 14 ++++++
>> ?drivers/cpuidle/cpuidle.c ? ? ?| ? 90 ++++++++++++++++++++++++++++++++--------
>> ?include/linux/cpuidle.h ? ? ? ?| ? 13 ++++++
>> ?3 files changed, 99 insertions(+), 18 deletions(-)
>> ?create mode 100644 arch/arm/include/asm/cpuidle.h
>>
>> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
>> new file mode 100644
>> index 0000000..1d2075b
>> --- /dev/null
>> +++ b/arch/arm/include/asm/cpuidle.h
>> @@ -0,0 +1,14 @@
>> +#ifndef __ASM_ARM_CPUIDLE_H
>> +#define __ASM_ARM_CPUIDLE_H
>> +
>> +/* Common ARM WFI state */
>> +#define CPUIDLE_ARM_WFI_STATE {\
>> + ? ? .enter ? ? ? ? ? ? ? ? ?= cpuidle_simple_enter,\
>> + ? ? .exit_latency ? ? ? ? ? = 1,\
>> + ? ? .target_residency ? ? ? = 1,\
>> + ? ? .flags ? ? ? ? ? ? ? ? ?= CPUIDLE_FLAG_TIME_VALID,\
>> + ? ? .name ? ? ? ? ? ? ? ? ? = "WFI",\
>> + ? ? .desc ? ? ? ? ? ? ? ? ? = "ARM core clock gating (WFI)",\
>> +}
>
> nit: just name this ARM WFI. ?Clock gating is platform specific, and
> "core" has platform-specific meanings, so in order to keep this truly
> generic, I think hat ARM WFI is the best name.
>

Agree.  I'll make that change.

> Kevin
>
>
