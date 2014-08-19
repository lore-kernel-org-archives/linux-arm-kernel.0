From: achandran@mvista.com (Arun Chandran)
Date: Tue, 19 Aug 2014 14:34:02 +0530
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <20140815182157.GD21908@leverpostej>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
Message-ID: <CAFdej02yS6+QGdkLFM+1318NvdjFdMTZvQe6qV7nu5BAdXNO2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
>
> If you'd be willing to spin a preparatory patch removing the other
> externs on function declarations in asm/proc-fns.h, that would be
> appreciated. Remember to add a Reported-by for Geoff.
>

Today I did "find arch/arm64 -name "*.h" | xargs grep -l "^extern"" in v3.16
and got

arch/arm64/mm/mm.h
arch/arm64/include/asm/exec.h
arch/arm64/include/asm/cpu_ops.h
arch/arm64/include/asm/suspend.h
arch/arm64/include/asm/tlbflush.h
arch/arm64/include/asm/stackprotector.h
arch/arm64/include/asm/stacktrace.h
arch/arm64/include/asm/mmu_context.h
arch/arm64/include/asm/cachetype.h
arch/arm64/include/asm/cputable.h
arch/arm64/include/asm/virt.h
arch/arm64/include/asm/efi.h
arch/arm64/include/asm/elf.h
arch/arm64/include/asm/pgtable.h
arch/arm64/include/asm/bitops.h
arch/arm64/include/asm/kgdb.h
arch/arm64/include/asm/fixmap.h
arch/arm64/include/asm/uaccess.h
arch/arm64/include/asm/page.h
arch/arm64/include/asm/smp_plat.h
arch/arm64/include/asm/memblock.h
arch/arm64/include/asm/perf_event.h
arch/arm64/include/asm/processor.h
arch/arm64/include/asm/ptrace.h
arch/arm64/include/asm/smp.h
arch/arm64/include/asm/hw_breakpoint.h
arch/arm64/include/asm/string.h
arch/arm64/include/asm/dma-mapping.h
arch/arm64/include/asm/fpsimd.h
arch/arm64/include/asm/mmu.h
arch/arm64/include/asm/memory.h
arch/arm64/include/asm/hwcap.h
arch/arm64/include/asm/system_misc.h
arch/arm64/include/asm/signal32.h
arch/arm64/include/asm/hardirq.h
arch/arm64/include/asm/ftrace.h
arch/arm64/include/asm/io.h
arch/arm64/include/asm/cacheflush.h
arch/arm64/include/asm/irq.h
arch/arm64/include/asm/pgalloc.h
arch/arm64/include/asm/syscall.h
arch/arm64/include/asm/topology.h
arch/arm64/include/asm/kvm_asm.h

No Idea what to do with the above ones.
Anyway I have sent a patch to remove it from asm/proc-fns.h.

--Arun
