From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 15 Apr 2013 13:33:31 +0200
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM
In-Reply-To: <20130412142649.GE6637@e102568-lin.cambridge.arm.com>
References: <1365689264-14410-1-git-send-email-hechtb+renesas@gmail.com>
 <20130412142649.GE6637@e102568-lin.cambridge.arm.com>
Message-ID: <CABYn4szh7WZSCZn-xskyEW+J6+YGL0n9ueqAA3MX-fAhyjsLsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lorenzo,

thanks for the review.

2013/4/12 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
> On Thu, Apr 11, 2013 at 03:07:43PM +0100, Bastian Hecht wrote:
>
> [...]
>
>> diff --git a/arch/arm/mach-shmobile/sleep-r8a7740.S b/arch/arm/mach-shmobile/sleep-r8a7740.S
>> new file mode 100644
>> index 0000000..762f978
>> --- /dev/null
>> +++ b/arch/arm/mach-shmobile/sleep-r8a7740.S
>> @@ -0,0 +1,72 @@
>> +/*
>> + * Low level sleep code for the SoC r8a7740
>> + *
>> + * Copyright (C) 2013 Bastian Hecht
>> + *
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <linux/init.h>
>> +#include <asm/memory.h>
>> +
>> +#ifdef CONFIG_SUSPEND
>> +
>> +/* r8a7740_shutdown expects L2 to be flushed */
>> +     .text
>> +ENTRY(r8a7740_shutdown)
>> +     stmfd   sp!, {r4-r12, lr}
>> +
>> +     /* make sure the stack stays intact */
>> +     bl      v7_flush_dcache_all
>> +
>
> Why do not you move the cache flush above after clearing the C bit ?
> You must not push on the stack _after_ clearing the C bit and before
> cleaning the cache, that's the only requirement (well basically you
> should not write any data and do not rely on any dirty data sitting
> in the cache, since with the C bit cleared as I already said A9 L1
> D-cache is not searched).
>
> AS long as, with C bit cleared, you do NOT push on the stack before
> cleaning the cache, your cache flushing routine will clean data to DRAM,
> so you are fine. v7_flush_dcache_all does not use the stack.
>
>         mrc     p15, 0, r0, c1, c0, 0
>         bic     r0, r0, #(1 << 2)               @ Disable the C bit
>         mcr     p15, 0, r0, c1, c0, 0
>         isb
>         bl      v7_flush_dcache_all
>
> This code snippet will do and it is compliant with the SMP procedure,
> I do not want people to copy'n'paste code that does not work on SMP,
> I know this code runs on UP so the sequence above is safe, but why not make
> the sequence identical for both UP/SMP ?

Now this looks super straight forward. I wonder how I came up with
inverted order (even if works in the UP case). Probably when you look
at others code and they put a v7_flush_dcache_all before the disable,
one (meaning me...) starts to bend the underlying ideas about the
caches until it fits to the code you see.

Anyway: Of course I'll take the code sequence then that works for the
UP and SMP cases.

>> +     /*
>> +      * Clear the SCTLR.C bit to prevent further data cache
>> +      * allocation. Clearing SCTLR.C would make all the data accesses
>> +      * strongly ordered and would not hit the cache.
>> +      */
>> +     mrc     p15, 0, r0, c1, c0, 0
>> +     bic     r0, r0, #(1 << 2)               @ Disable the C bit
>> +     mcr     p15, 0, r0, c1, c0, 0
>> +     isb
>> +
>> +     /*
>> +      * We don't issue another v7_flush_dcache_all here as seen in many
>> +      * other places as we have a UP core and the L1 could not soak up
>> +      * data from other L1 caches in the meantime.
>> +      */
>> +
>> +     bl      cpu_v7_do_idle
>> +
>> +     /* in rare cases when WFI fails we end up here and restore things */
>
> I am still baffled by this "wfi failures" and how hardware can manage
> this situation _properly_, if you can explain to me how this works
> that would be grand.

I unfortunately don't know about the hardware design of this SoC.

> This code is also called by CPUidle right ?

I haven't experienced this when using suspend-to-ram but only for
CPUIdle. Of course this might be just a matter of probability though.

> So,
> IRQs can still cause wfi completion, there has to be a handshake between
> the core and power controller to prevent the CPU from being shutdown
> while executing code (power down command sent, standbywfi asserted and
> then released following wfi completion).
>
> Anyway, I do not like the code sequence (and I know that eg OMAP4 executes
> the same code) above because again, it works on UP, but people might be
> tempted to copy'n'paste it to their SMP implementation (with the addition
> of SMP bit restore in ACTLR).
>
> OMAP4 sequence is missing TLB flush since the core runs for a time window with
> incoherent TLBs (out of SMP). It works because other cores can't update
> their page tables while the core exiting wfi is running out of coherency
> (ie coupled idle C-states, either all CPUs down or no CPU down), but
> again, that code should not be copied verbatim since it fails to flush
> TLBs, AFAIK.
>
> Again, you are running a UP kernel so this code does not suffer from
> the same problem, but if this code is copied and used on SMP platforms then
> we do have problem and that has to be prevented.
>
> Why do not you turn MMU off (cpu_reset) and jump to the reset vector if
> wfi fails (code in arch/arm/kernel/process.c __soft_restart(), minus the
> cache flushing ?
>
>         phys_reset_t phys_reset;
>
>         /* Take out a flat memory mapping. */
>         setup_mm_for_reboot();
>
>         phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
>         phys_reset((unsigned long)addr);
>
>         BUG();
>
> where addr == virt_to_phys(cpu_resume);
>
> from what I gather from the code below.
>
> There is just a tiny performance hit owing to a couple of fetches from
> DRAM (MMU off), then cpu_resume restores the C bit and the MMU (and flushes
> the TLBs) so the virtual address space and caches are back on. By the time wfi
> fails, caches are invalid anyway so in both cases they have to be refilled.
>
> On top of that, this code is not really SH specific, it is plain v7 code
> that can be standardised.

Ok that sounds good. As we don't touch the hotpath I don't care much
about some extra cycles and I appreciate moving towards
standardization. I'll try that out and send a v3 with the two changes.

So thanks a lot,

 Bastian

> For now it is just a, hopefully useful, rant.
>
> Lorenzo
>
>> +     mrc     p15, 0, r0, c1, c0, 0
>> +     orr     r0, r0, #(1 << 2)               @ Enable the C bit
>> +     mcr     p15, 0, r0, c1, c0, 0
>> +     isb
>> +
>> +     ldmfd   sp!, {r4-r12, pc}
>> +ENDPROC(r8a7740)
>> +
>> +     .text
>> +ENTRY(v7_cpu_resume)
>> +     bl      v7_invalidate_l1
>> +     b       cpu_resume
>> +ENDPROC(v7_cpu_resume)
>> +
>> +/*
>> + * The entry point of a warm reboot, used by wakeup scenarios
>> + *
>> + * The CPU jumps in this case to (0xfffff000 & SBAR), so we need
>> + * to align this function properly.
>> + * We use a long jump into the text segment and use the physical
>> + * address as the MMU is still turned off.
>> + */
>> +     .align  12
>> +     .text
>> +ENTRY(r8a7740_resume)
>> +     ldr     pc, 1f
>> +1:   .long   v7_cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
>> +ENDPROC(r8a7740_resume_core_standby)
>> +#endif
>> --
>
