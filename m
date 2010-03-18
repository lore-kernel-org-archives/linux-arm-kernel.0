From: virtuoso@slind.org (Alexander Shishkin)
Date: Thu, 18 Mar 2010 14:37:22 +0200
Subject: [PATCH 1/1] [RFC] arm: add half-word __xchg
In-Reply-To: <20100318123223.GA6855@Krystal>
References: <20100310173503.GC12345@n2100.arm.linux.org.uk>
	<1268904552-2355-1-git-send-email-virtuoso@slind.org>
	<20100318123223.GA6855@Krystal>
Message-ID: <71a0d6ff1003180537w46128c55l574a608e3be06a56@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2010 14:32, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> * Alexander Shishkin (virtuoso at slind.org) wrote:
>> On systems where ldrexh/strexh are not available, use a generic local
>> version.
>>
>> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
>> CC: linux-arm-kernel-bounces at lists.infradead.org
>> CC: Imre Deak <imre.deak@nokia.com>
>> CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
>> ---
>> ?arch/arm/include/asm/system.h | ? 61 ++++++++++++++++++++++++++++++++++-------
>> ?1 files changed, 51 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
>> index d65b2f5..a2ee41f 100644
>> --- a/arch/arm/include/asm/system.h
>> +++ b/arch/arm/include/asm/system.h
>> @@ -218,6 +218,39 @@ do { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> ? ? ? last = __switch_to(prev,task_thread_info(prev), task_thread_info(next)); ? ? ? ?\
>> ?} while (0)
>>
>> +static inline unsigned long __xchg_local_generic(unsigned long x,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?volatile void *ptr, int size)
>> +{
>> + ? ? extern void __bad_xchg(volatile void *, int);
>> + ? ? unsigned long ret;
>> + ? ? unsigned long flags;
>> +
>> + ? ? switch (size) {
>> + ? ? case 1:
>> + ? ? ? ? ? ? raw_local_irq_save(flags);
>> + ? ? ? ? ? ? ret = *(volatile unsigned char *)ptr;
>> + ? ? ? ? ? ? *(volatile unsigned char *)ptr = x;
>> + ? ? ? ? ? ? raw_local_irq_restore(flags);
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 2:
>> + ? ? ? ? ? ? raw_local_irq_save(flags);
>> + ? ? ? ? ? ? ret = *(volatile unsigned short *)ptr;
>> + ? ? ? ? ? ? *(volatile unsigned short *)ptr = x;
>> + ? ? ? ? ? ? raw_local_irq_restore(flags);
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 4:
>> + ? ? ? ? ? ? raw_local_irq_save(flags);
>> + ? ? ? ? ? ? ret = *(volatile unsigned long *)ptr;
>> + ? ? ? ? ? ? *(volatile unsigned long *)ptr = x;
>> + ? ? ? ? ? ? raw_local_irq_restore(flags);
>> + ? ? ? ? ? ? break;
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>> +
>> ?#if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
>> ?/*
>> ? * On the StrongARM, "swp" is terminally broken since it bypasses the
>> @@ -262,6 +295,22 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>> ? ? ? ? ? ? ? ? ? ? ? : "r" (x), "r" (ptr)
>> ? ? ? ? ? ? ? ? ? ? ? : "memory", "cc");
>> ? ? ? ? ? ? ? break;
>> +#ifdef CONFIG_CPU_32v6K
>> + ? ? case 2:
>> + ? ? ? ? ? ? asm volatile("@ __xchg2\n"
>> + ? ? ? ? ? ? "1: ? ? ldrexh ?%0, [%3]\n"
>> + ? ? ? ? ? ? " ? ? ? strexh ?%1, %2, [%3]\n"
>> + ? ? ? ? ? ? " ? ? ? teq ? ? %1, #0\n"
>> + ? ? ? ? ? ? " ? ? ? bne ? ? 1b"
>> + ? ? ? ? ? ? ? ? ? ? : "=&r" (ret), "=&r" (tmp)
>> + ? ? ? ? ? ? ? ? ? ? : "r" (x), "r" (ptr)
>> + ? ? ? ? ? ? ? ? ? ? : "memory", "cc");
>> + ? ? ? ? ? ? break;
>> +#else
>> + ? ? case 2:
>> + ? ? ? ? ? ? ret = __xchg_local_generic(x, ptr, 2);
>> + ? ? ? ? ? ? break;
>
> Calling __xchg_local_generic as an underlying xchg() implementation on
> SMP is buggy. I think we have to surround this by "#ifndef CONFIG_SMP",
> so it generates a "__bad_xchg(ptr, size), ret = 0;" error for short xchg
> on SMP. That's odd though, as a program that builds on UP will break on
> SMP.

Point taken, thanks.

Regards,
--
Alex
