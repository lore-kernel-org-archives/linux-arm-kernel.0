From: achandran@mvista.com (Arun Chandran)
Date: Mon, 18 Aug 2014 12:13:17 +0530
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <20140815182157.GD21908@leverpostej>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
Message-ID: <CAFdej03UvS+QWL9L4ecdBT6TeBG_p3_yuKL1ogHwfpwcGekKTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff, Mark,

On Fri, Aug 15, 2014 at 11:51 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Geoff,
>
> On Fri, Aug 15, 2014 at 06:20:21PM +0100, Geoff Levand wrote:
>> Hi Arun,
>>
>> On Tue, 2014-08-12 at 18:12 +0530, Arun Chandran wrote:
>> > soft_restart() will fail on arm64 systems that does not
>> > quarantee the flushing of cache to PoC with flush_cache_all().
>> >
>> > soft_restart(addr)
>> > {
>> >     push_to_stack(addr);
>> >
>> >     Do mm setup for restart;
>> >     Flush&turnoff D-cache;
>> >
>> >     pop_from_stack(addr); --> fails here as addr is not at PoC
>> >     cpu_reset(addr) --> Jumps to invalid address
>> > }
>>
>> For the cpu-ops shutdown I'm working on I need a call to move the
>> secondary processors to an identity mapped spin loop after the identity
>> map is enabled.  I want to do this in C code, so it needs to happen
>> after the identity map is enabled, and before the dcache is disabled.
>>
>> I think to do this we can keep the existing soft_restart(addr) routine
>> with something like this:
>>
>> void soft_restart(unsigned long addr)
>> {
>>       setup_mm_for_reboot();
>>
>> #if defined(CONFIG_SMP)
>>       smp_secondary_shutdown();
>> #endif
>>
>>       cpu_soft_restart(addr);
>>
>>       /* Should never get here */
>>       BUG();
>> }
>>
>
> I don't follow why you need a hook in the middle of soft_restart. That
> sounds like a layering violation to me.
>
> I assume this is for implementing the spin-table cpu-return-addr idea?
>
> If so, what's wrong with something like:
>
> #define ADDR_INVALID ((unsigned long)-1)
> static DEFINE_PER_CPU(unsigned long, return_addr) = ADDR_INVALID;
>
> int spin_table_cpu_disable(unsigned int cpu)
> {
>         if (per_cpu(return_addr, cpu) != ADDR_INVALID)
>                 return 0;
>
>         return -EOPNOTSUPP;
> }
>
> void spin_table_cpu_die(unsigned int cpu)
> {
>         unsigned long release_addr = per_cpu(return_addr, cpu);
>
>         /*
>          * We should have a local_disable(DBG|ASYNC|FIQ|IRQ) function or
>          * something similar as these are all context synchronising and
>          * therefore expensive.
>          */
>         local_dbg_disable();
>         local_async_disable();
>         local_fiq_disable();
>         arch_local_irq_disable();
>
>         soft_restart(release_addr);
> }
>
> [...]
>
>> > diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
>> > index 0c657bb..e18d5d0 100644
>> > --- a/arch/arm64/include/asm/proc-fns.h
>> > +++ b/arch/arm64/include/asm/proc-fns.h
>> > @@ -32,6 +32,7 @@ extern void cpu_cache_off(void);
>> >  extern void cpu_do_idle(void);
>> >  extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
>> >  extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
>> > +extern void cpu_soft_restart(unsigned long addr) __attribute__((noreturn));
>>
>> Function prototypes are never definitions, so remove this 'extern'
>> keyword.  checkpatch should have warned about this.  If it did not,
>> report it to the checkpatch maintainers.
>
> Good point.
>
> Arun, could you fix up the latest version [1] of your patch to not use
> extern for the function declaration?

Yes I will fix and name it as V1 and send.
>
> If you'd be willing to spin a preparatory patch removing the other
> externs on function declarations in asm/proc-fns.h, that would be
> appreciated. Remember to add a Reported-by for Geoff.
>
Yes I will be happy to do that :)

> Also, please remember to use a version number in the patch subject (e.g.
> "[PATCHv2] arm64: convert part of soft_restart() to assembly"), as that
> will make it easier to find the latest version in future.
>
OK. Done.

> [...]
>
>> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> > index 7736779..a7c3fce 100644
>> > --- a/arch/arm64/mm/proc.S
>> > +++ b/arch/arm64/mm/proc.S
>> > @@ -76,6 +76,40 @@ ENTRY(cpu_reset)
>> >     ret     x0
>> >  ENDPROC(cpu_reset)
>> >
>> > +   .align 3
>> > +1: .quad   memstart_addr
>> > +
>> > +ENTRY(cpu_soft_restart)
>> > +   adr     x1, cpu_reset
>> > +   adr     x2, 1b
>> > +
>> > +   /* virt_to_phys(cpu_reset) */
>> > +   ldr     x3, [x2]
>> > +   ldr     x3, [x3]
>> > +   mov     x4, #1
>> > +   lsl     x4, x4, #(VA_BITS - 1)
>> > +   add     x1, x1, x4
>> > +   add     x1, x1, x3
>> > +
>> > +   /* Save it; We can't use stack as it is going to run with caches OFF */
>> > +   mov     x19, x0
>> > +   mov     x20, x1
>> > +
>> > +   bl      setup_mm_for_reboot
>> > +
>> > +   bl      flush_cache_all
>> > +   /* Turn D-cache off */
>> > +   bl      cpu_cache_off
>> > +   /* Push out any further dirty data, and ensure cache is empty */
>> > +   bl      flush_cache_all
>>
>> It would be nice to have some blank lines above the comments.  Same
>> below.
>
> Makes sense to me. For the latest version [1], that should only mean a
> line after the call to cpu_cache_off in cpu_soft_restart.
>

Ok.
--Arun
