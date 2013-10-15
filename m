From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Oct 2013 19:30:50 +0200
Subject: [RFC v3 PATCH 1/7] ARM: add support for kernel mode NEON in
 atomic context
In-Reply-To: <20131015172604.GA4765@arm.com>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381666503-23726-2-git-send-email-ard.biesheuvel@linaro.org>
 <20131015172604.GA4765@arm.com>
Message-ID: <CAKv+Gu-heuH7cqt96bSwSsu_BY0zqbW1qLYP9W0fAdbU=3W9Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 October 2013 19:26, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Sun, Oct 13, 2013 at 01:14:57PM +0100, Ard Biesheuvel wrote:
>> diff --git a/arch/arm/include/asm/neon.h b/arch/arm/include/asm/neon.h
>> index 8f730fe..800d85c 100644
>> --- a/arch/arm/include/asm/neon.h
>> +++ b/arch/arm/include/asm/neon.h
>> @@ -8,10 +8,30 @@
>>   * published by the Free Software Foundation.
>>   */
>>
>> +#include <linux/types.h>
>> +#include <linux/hardirq.h>
>> +#include <asm/fpstate.h>
>>  #include <asm/hwcap.h>
>>
>>  #define cpu_has_neon()               (!!(elf_hwcap & HWCAP_NEON))
>>
>> +/*
>> + * Avoid wasting stack space by making the size of the allocated area depend on
>> + * whether we are currently running in process context. (If this is the case, we
>> + * will use the normal preserve/restore mechanism, leaving the allocated stack
>> + * space unused.)
>> + */
>> +#define __QREG_SIZE(num)     \
>> +     ((!in_interrupt()) ? 0 : (num) > 16 ? 256 : 16 * (((num) + 1) & ~1U))
>> +
>> +#define DEFINE_NEON_REGSTACK_PARTIAL(v, num)         \
>> +     struct {                                        \
>> +             struct vfp_partial_state regs;          \
>> +             u8 qregs[__QREG_SIZE(num)];             \
>> +     } v
>
> Oh, interesting gcc feature. What does it generate?
>

Well, it's not a feature particular to GCC, as far as I am aware. The
anonymous struct is just runtime variably sized depending on
in_interrupt() and the requested number of registers.

-- 
Ard.
