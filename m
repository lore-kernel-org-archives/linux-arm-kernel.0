From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 1 Jun 2016 14:03:35 +0100
Subject: [PATCH RFC 00/10] ARM: V7M: Support caches
In-Reply-To: <5746AE5B.3050407@gmail.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
 <5746AE5B.3050407@gmail.com>
Message-ID: <574EDD27.5010903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 26/05/16 09:05, Alexandre Torgue wrote:
> Hi Vladimir,
> 
> On 04/21/2016 10:18 AM, Vladimir Murzin wrote:
>> Hi,
>>
>> This patch set allows M-class cpus benefit of optional cache support.
>> It originaly was written by Jonny, I've been keeping it localy mainly
>> rebasing over Linux versions.
>>
>> The main idea behind patches is to reuse existing cache handling code
>> from v7A/R. In case v7M cache operations are provided via memory
>> mapped interface rather than co-processor instructions, so extra
>> macros have been introduced to factor out cache handling logic and
>> low-level operations.
>>
>> Along with the v7M cache support the first user (Cortex-M7) is
>> introduced.
>>
>> Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
>> one showed significant boot speed-up.
>>
> 
> 
> Thanks for the series. Maxime and I have just tested it on STM32F7
> hardware.

Thanks for giving it a try!

> We found an issue on this M7 chip, which is not linked to your patches
> (see below patch that will be send shortly).
> Once fixed, we are able to boot but we observe instabilities which
> disappear when D-cache is disabled from kernel config.
> We observe random crashes.
> Most of them look like this (hardfault):
> 
> (gdb) info reg
> r0             0xc018c3fc    -1072118788
> r1             0x3e0    992
> r2             0x4100000b    1090519051
> r3             0x0    0
> r4             0x0    0
> r5             0xc018c3fc    -1072118788
> r6             0xc018c7dc    -1072117796
> r7             0xc018c3fc    -1072118788
> r8             0xc018bb30    -1072121040
> r9             0x3e0    992
> r10            0x4100000b    1090519051
> r11            0x0    0
> r12            0x8303c003    -2096906237
> sp             0xc016bed0    0xc016bed0 <init_thread_union+7888>
> lr             0xfffffff1    -15
> pc             0xc000b6bc    0xc000b6bc <__invalid_entry>
> xPSR           0x81000003    -2130706429
> (gdb) bt
> #0  __invalid_entry () at arch/arm/kernel/entry-v7m.S:24
> #1  <signal handler called>
> #2  vsnprintf (buf=0xc018c3fc <textbuf> "", size=992, fmt=0x4100000b "",
> args=...) at lib/vsprintf.c:1999
> #3  0xc0095910 in vscnprintf (buf=<optimized out>, size=992,
> fmt=<optimized out>, args=...) at lib/vsprintf.c:2152
> #4  0xc00269dc in vprintk_emit (facility=0, level=-1, dict=0x0,
> dictlen=<optimized out>, fmt=0x4100000b "", args=...) at
> kernel/printk/printk.c:1673
> #5  0xc000a20a in arch_local_irq_enable () at
> ./arch/arm/include/asm/irqflags.h:38
> #6  arch_cpu_idle () at arch/arm/kernel/process.c:73
> #7  0x00000000 in ?? ()
> 
> We continue to investigate this issue. If you have any idea, please let
> us know.

Nothing out of my head at the moment, sorry. I'm getting ready for the
next spin and I'll try to hummer the patches more. If you can give some
specific payload I can run here I'd try to reproduce what you've seen.

Cheers
Vladimir

> 
> Thanks.
> 
> alex
> 
> Patch which will be sent shortly:
> 
> 
> Author: Alexandre TORGUE <alexandre.torgue@gmail.com>
> Date:   Wed May 25 14:02:35 2016 +0200
> 
>     ARM: V7M: Add dsb before jumping in handler mode
> 
>     According to ARM AN321 (section 4.12):
> 
>     "If the vector table is in writable memory such as SRAM, either
> relocated
>     by VTOR or a device dependent memory remapping mechanism, then
>     architecturally a memory barrier instruction is required after the
> vector
>     table entry is updated, and if the exception is to be activated
> immediately"
> 
>     Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>     Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>
> 
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 60387a0..807949f 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -124,6 +124,7 @@ __v7m_setup:
>         badr    r1, 1f
>         ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
>         str     r1, [r12, #11 * 4]      @ write the temporary SVC vector
> entry
> +       dsb
>         mov     r6, lr                  @ save LR
>         ldr     sp, =init_thread_union + THREAD_START_SP
>         cpsie   i
> 
> 
