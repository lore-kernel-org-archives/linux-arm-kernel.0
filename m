From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 9 Jun 2015 11:14:23 +0200
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
In-Reply-To: <20150608224749.GB7557@n2100.arm.linux.org.uk>
References: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
 <20150608224749.GB7557@n2100.arm.linux.org.uk>
Message-ID: <CALszF6DPzhAufUyWW-a3X7Cp4=tjSyCBM=Y4LcnWnUH=41qeoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-09 0:47 GMT+02:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Jun 09, 2015 at 12:24:48AM +0200, Maxime Coquelin wrote:
>> Commit cb1293e2f594 ("ARM: 8375/1: disable some options on ARMv7-M") causes
>> build failure on ARMv7-M machines:
>>
>>   CC      arch/arm/kernel/asm-offsets.s
>> In file included from include/linux/sem.h:5:0,
>>                  from include/linux/sched.h:35,
>>                  from arch/arm/kernel/asm-offsets.c:14:
>> include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
>> include/linux/rcupdate.h:539:2: error: implicit declaration of function 'arch_irqs_disabled' [-Werror=implicit-function-declaration]
>>   return preempt_count() != 0 || irqs_disabled();
>>   ^
>
> The real solution is to provide a definition _in asm-generic_ for
> arch_irqs_disabled(), rather than having almost every arch doing:
>
> static inline bool arch_irqs_disabled(void)
> {
>         return arch_irqs_disabled_flags(arch_local_save_flags());
> }
>
> I'm personally refusing to take a patch for ARM which adds yet another
> copy of the above.  This is, after all, exactly the kind of stuff that
> should be in asm-generic, or if not, in include/linux but overridable
> by arch stuff.
>
> We keep going between the two extremes of "lets push lots of stuff into
> arch stuff" and "lets try to extract the common bits out of arch code".
>
> Let's try and settle on one approach, and apply it universally.

I agree on the idea but I don't measure all the impacts it would have.

>
> In the mean time, I think the right answer is to drop Arnd's patch -
> subsituting a randconfig build error for a useful-config build error
> is not something we want to do - and even partially reverting the
> patch results in randconfig build errors returning, so...

Ok, should I send a revert, or you can still drop Arnd's patch directly?

Thanks,
Maxime
