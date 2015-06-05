From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 5 Jun 2015 13:35:24 -0500
Subject: [PATCH] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <20140617095155.GD13020@arm.com>
References: <1402957778-13830-1-git-send-email-abhimany@codeaurora.org>
 <20140617095155.GD13020@arm.com>
Message-ID: <CAOZdJXWSr=DNEQ9WiL+qhosGDx2y0Tgz4zcwMXFvRE0k6iodjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 4:51 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jun 16, 2014 at 11:29:38PM +0100, Abhimanyu Kapur wrote:
>> Add support for debug communications channel based
>> hvc console for arm64 cpus.

I know it's been a year since this patch was posted, but I'm working
on re-submitting it.  Unfortunately, I can't answer most of your
questions, but I want to try to fix this patch up and get it accepted.

> Should we be setting MDSCR_EL1.TDCC to prevent userspace access to the DCC?

I personally don't know enough about ARM to answer that question, but
it does makes sense that we don't want userspace to access the DCC
registers.  Where would MDSCR_EL1.TDCC be set?  Should we add it to
hvc_dcc_init()?

>> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
>> ---
>>  arch/arm64/include/asm/dcc.h | 41 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/tty/hvc/Kconfig      |  2 +-
>>  2 files changed, 42 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/include/asm/dcc.h
>>
>> diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
>> new file mode 100644
>> index 0000000..ef74324
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/dcc.h
>> @@ -0,0 +1,41 @@
>> +/* Copyright (c) 2014 The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <asm/barrier.h>
>> +
>> +static inline u32 __dcc_getstatus(void)
>> +{
>> +     u32 __ret;
>
> Can this result in the mrs receiving a W register?

Another question I can't answer.  I understand what you're saying, but
I don't know what to do about it.

>> +     asm volatile("mrs %0, mdccsr_el0" : "=r" (__ret)
>> +                     : : "cc");
>
> Why the CC clobber? Why volatile?

I don't think we need the CC clobber, but the volatiles do appear to
be important.  Without that, DCC does not work.

>> +
>> +     return __ret;
>> +}
>> +
>> +static inline char __dcc_getchar(void)
>> +{
>> +     char __c;
>> +
>> +     asm volatile("mrs %0, dbgdtrrx_el0" : "=r" (__c));
>> +     isb();
>
> Why the isb and why volatile??

The driver does appear to work without the isb, but there's a reason
it was added.  On ARM32, reading/writing the DCC register is
apparently a context change:

http://www.serverphorums.com/read.php?12,395361

I don't know if the same thing is true on ARM64.  However, I don't
understand why reading/writing the DCC register is a context change on
ARM32.

>> +
>> +     return __c;
>> +}
>> +
>> +static inline void __dcc_putchar(char c)
>> +{
>> +     asm volatile("msr dbgdtrtx_el0, %0"
>> +                     : /* No output register */
>> +                     : "r" (c));
>
> Can you guarantee that GCC hasn't put junk in the upper bits of c?

Should I change the prototype to:

static inline void __dcc_putchar(unsigned int c)


>
>> +     isb();
>
> Why the isb?
>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
