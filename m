From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 16 Jan 2014 10:15:25 +0530
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <CAL_Jsq+TrRgGWT+Hd-q_A6f+4rOb_Nm3QVm04_enVToSsvuWgA@mail.gmail.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>
 <CAL_Jsq+TrRgGWT+Hd-q_A6f+4rOb_Nm3QVm04_enVToSsvuWgA@mail.gmail.com>
Message-ID: <52D763E5.4050408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 09:11 PM, Rob Herring wrote:
> On Wed, Jan 15, 2014 at 7:07 AM, Prashant Gaikwad <pgaikwad@nvidia.com> wrote:
>> Now arch timer is registerd using generic sched timer, delay
>> timer registration is the only part remaining in arch ports.
>> Move this part to drivers clocksource and remove arch timer
>> from arch ports.
>>
>> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
>> ---
>>   arch/arm/include/asm/arch_timer.h    |    1 -
>>   arch/arm/kernel/Makefile             |    1 -
>>   arch/arm/kernel/arch_timer.c         |   44 ----------------------------------
>>   arch/arm64/include/asm/arch_timer.h  |    5 ----
>>   arch/arm64/include/asm/delay.h       |   32 ++++++++++++++++++++++++
>>   arch/arm64/include/asm/timex.h       |    5 +--
>>   arch/arm64/kernel/time.c             |    9 -------
>>   arch/arm64/lib/delay.c               |   26 ++++++++++++++++++++
>>   drivers/clocksource/arm_arch_timer.c |   12 ++++++++-
>>   9 files changed, 71 insertions(+), 64 deletions(-)
>>   delete mode 100644 arch/arm/kernel/arch_timer.c
>>   create mode 100644 arch/arm64/include/asm/delay.h

Thanks for the comments Rob!! I was planning to do that in later patch. 
Is that fine?

>> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
>> index 0704e0c..61ad692 100644
>> --- a/arch/arm/include/asm/arch_timer.h
>> +++ b/arch/arm/include/asm/arch_timer.h
>> @@ -10,7 +10,6 @@
>>   #include <clocksource/arm_arch_timer.h>
>>
>>   #ifdef CONFIG_ARM_ARCH_TIMER
>> -int arch_timer_arch_init(void);
>>
>>   /*
>>    * These register accessors are marked inline so the compiler can
>> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
>> index a30fc9b..6b51cf9 100644
>> --- a/arch/arm/kernel/Makefile
>> +++ b/arch/arm/kernel/Makefile
>> @@ -45,7 +45,6 @@ obj-$(CONFIG_SMP)             += smp_tlb.o
>>   endif
>>   obj-$(CONFIG_HAVE_ARM_SCU)     += smp_scu.o
>>   obj-$(CONFIG_HAVE_ARM_TWD)     += smp_twd.o
>> -obj-$(CONFIG_ARM_ARCH_TIMER)   += arch_timer.o
>>   obj-$(CONFIG_DYNAMIC_FTRACE)   += ftrace.o insn.o
>>   obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o insn.o
>>   obj-$(CONFIG_JUMP_LABEL)       += jump_label.o insn.o patch.o
>> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
>> deleted file mode 100644
>> index 1791f12..0000000
>> --- a/arch/arm/kernel/arch_timer.c
>> +++ /dev/null
>> @@ -1,44 +0,0 @@
>> -/*
>> - *  linux/arch/arm/kernel/arch_timer.c
>> - *
>> - *  Copyright (C) 2011 ARM Ltd.
>> - *  All Rights Reserved
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - */
>> -#include <linux/init.h>
>> -#include <linux/types.h>
>> -#include <linux/errno.h>
>> -
>> -#include <asm/delay.h>
>> -
>> -#include <clocksource/arm_arch_timer.h>
>> -
>> -static unsigned long arch_timer_read_counter_long(void)
>> -{
>> -       return arch_timer_read_counter();
>> -}
>> -
>> -static struct delay_timer arch_delay_timer;
>> -
>> -static void __init arch_timer_delay_timer_register(void)
>> -{
>> -       /* Use the architected timer for the delay loop. */
>> -       arch_delay_timer.read_current_timer = arch_timer_read_counter_long;
>> -       arch_delay_timer.freq = arch_timer_get_rate();
>> -       register_current_timer_delay(&arch_delay_timer);
>> -}
>> -
>> -int __init arch_timer_arch_init(void)
>> -{
>> -        u32 arch_timer_rate = arch_timer_get_rate();
>> -
>> -       if (arch_timer_rate == 0)
>> -               return -ENXIO;
>> -
>> -       arch_timer_delay_timer_register();
>> -
>> -       return 0;
>> -}
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index 9400596..48e06bd 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -145,9 +145,4 @@ static inline u64 arch_counter_get_cntvct(void)
>>          return cval;
>>   }
>>
>> -static inline int arch_timer_arch_init(void)
>> -{
>> -       return 0;
>> -}
>> -
>>   #endif
>> diff --git a/arch/arm64/include/asm/delay.h b/arch/arm64/include/asm/delay.h
>> new file mode 100644
>> index 0000000..ea90d99
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/delay.h
>> @@ -0,0 +1,32 @@
>> +
>> +/*
>> + * Copyright (c) 2014, NVIDIA Corporation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ASM_ARM64_DELAY_H
>> +#define __ASM_ARM64_DELAY_H
>> +
>> +#include <asm-generic/delay.h>
>> +
>> +struct delay_timer {
>> +       unsigned long (*read_current_timer)(void);
>> +       unsigned long freq;
>> +};
>> +
>> +/* Delay-loop timer registration. */
>> +#define ARCH_HAS_READ_CURRENT_TIMER
>> +extern void register_current_timer_delay(const struct delay_timer *timer);
> Can't all but the define be moved to a common location?
>
>> +
>> +#endif /* defined(_ARM64_DELAY_H) */
>> diff --git a/arch/arm64/include/asm/timex.h b/arch/arm64/include/asm/timex.h
>> index 81a076e..ca4bdfb 100644
>> --- a/arch/arm64/include/asm/timex.h
>> +++ b/arch/arm64/include/asm/timex.h
>> @@ -16,13 +16,12 @@
>>   #ifndef __ASM_TIMEX_H
>>   #define __ASM_TIMEX_H
>>
>> -#include <asm/arch_timer.h>
>> -
>>   /*
>>    * Use the current timer as a cycle counter since this is what we use for
>>    * the delay loop.
>>    */
>> -#define get_cycles()   arch_counter_get_cntvct()
>> +typedef unsigned long cycles_t;
>> +#define get_cycles()   ({ cycles_t c; read_current_timer(&c) ? 0 : c; })
> Could be in a common location conditional on ARCH_HAS_READ_CURRENT_TIMER.
>
>>   #include <asm-generic/timex.h>
>>
>> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
>> index 29c39d5..213d1a3 100644
>> --- a/arch/arm64/kernel/time.c
>> +++ b/arch/arm64/kernel/time.c
>> @@ -63,14 +63,5 @@ EXPORT_SYMBOL(profile_pc);
>>
>>   void __init time_init(void)
>>   {
>> -       u32 arch_timer_rate;
>> -
>>          clocksource_of_init();
>> -
>> -       arch_timer_rate = arch_timer_get_rate();
>> -       if (!arch_timer_rate)
>> -               panic("Unable to initialise architected timer.\n");
>> -
>> -       /* Calibrate the delay loop directly */
>> -       lpj_fine = arch_timer_rate / HZ;
>>   }
>> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
>> index dad4ec9..cde0a28 100644
>> --- a/arch/arm64/lib/delay.c
>> +++ b/arch/arm64/lib/delay.c
>> @@ -24,6 +24,19 @@
>>   #include <linux/module.h>
>>   #include <linux/timex.h>
>>
>> +static const struct delay_timer *delay_timer;
>> +static bool delay_calibrated;
>> +
>> +int read_current_timer(unsigned long *timer_val)
>> +{
>> +       if (!delay_timer)
>> +               return -ENXIO;
>> +
>> +       *timer_val = delay_timer->read_current_timer();
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(read_current_timer);
>> +
> This too could be common.
>
>>   void __delay(unsigned long cycles)
>>   {
>>          cycles_t start = get_cycles();
>> @@ -53,3 +66,16 @@ void __ndelay(unsigned long nsecs)
>>          __const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
>>   }
>>   EXPORT_SYMBOL(__ndelay);
>> +
>> +void register_current_timer_delay(const struct delay_timer *timer)
>> +{
>> +       if (!delay_calibrated) {
>> +               pr_info("Switching to timer-based delay loop\n");
>> +               delay_timer                     = timer;
>> +               lpj_fine                        = timer->freq / HZ;
>> +
>> +               delay_calibrated                = true;
>> +       } else {
>> +               pr_info("Ignoring duplicate/late registration of read_current_timer delay\n");
>> +       }
>> +}
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 57e823c..8ee9918 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -422,6 +422,16 @@ struct timecounter *arch_timer_get_timecounter(void)
>>          return &timecounter;
>>   }
>>
>> +static struct delay_timer arch_delay_timer;
>> +
>> +static void __init arch_delay_timer_register(void)
>> +{
>> +       /* Use the architected timer for the delay loop. */
>> +       arch_delay_timer.read_current_timer = arch_timer_read_counter();
>> +       arch_delay_timer.freq = arch_timer_rate;
>> +       register_current_timer_delay(&arch_delay_timer);
>> +}
>> +
>>   static void __init arch_counter_register(unsigned type)
>>   {
>>          u64 start_count;
>> @@ -630,7 +640,7 @@ static void __init arch_timer_common_init(void)
>>
>>          arch_timer_banner(arch_timers_present);
>>          arch_counter_register(arch_timers_present);
>> -       arch_timer_arch_init();
>> +       arch_delay_timer_register();
>>   }
>>
>>   static void __init arch_timer_init(struct device_node *np)
>> --
>> 1.7.4.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
