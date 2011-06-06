From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 6 Jun 2011 17:32:22 +0100 (BST)
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <20110603235302.GA26822@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
	<20110602201611.GA10532@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106030834240.2311@localhost6.localdomain6>
	<20110603235302.GA26822@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1106061704450.2247@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Jun 2011, Russell King - ARM Linux wrote:

> On Fri, Jun 03, 2011 at 11:44:02AM +0100, Frank Hofmann wrote:
>> On Thu, 2 Jun 2011, Russell King - ARM Linux wrote:
>>> But... it requires the v:p offset in r1, and the _virtual_ address of
>>> the code to continue at in lr.  These are specifically saved for it by
>>> cpu_suspend in arch/arm/kernel/sleep.S.
>>
>> I've read that - that's why the hibernation resume path has been written
>> this way. I'm trying to create the conditions necessary, i.e. set up
>> r0/r1/lr _and_ the MMU state in such a way that it's callable unmodified.
>
> I think you missed my point.  Go back and look at this bit of your code,
> and indentify what _exactly_ is in r1 at the point cpu_do_resume is
> called.  I'll give you a hint - it's not the v:p offset as required.

Ah, ok, double stupid mistake really - the inverted v:p, and then #CR_M 
for the MMU off ... neither is correct.

Kudos to your eyesight ;-) Great spotting ! I wish every reviewer were 
that thorough.

I got the MMU transition to work on Friday - where the above two come in 
... I wasn't verbose enough then to say what exactly needed changing to 
make it work.


I've adapted the hibernation code now so that it does directly use 
cpu_suspend / cpu_resume, and it appears to work on v6 / ARM1176 (need to 
test others still - OMAP3 ...).

The hibernation restore code now calls cpu_resume() like this:

void * notrace __swsusp_arch_restore_image(void)
{
         extern struct pbe *restore_pblist;
         extern void cpu_resume(void);
         extern void *sleep_save_sp;
         struct pbe *pbe;

         cpu_switch_mm(swapper_pg_dir, &init_mm);

         for (pbe = restore_pblist; pbe; pbe = pbe->next)
                 copy_page(pbe->orig_address, pbe->address);

         sleep_save_sp = *((u32*)__swsusp_arch_ctx);
         flush_tlb_all();
         flush_cache_all();

         identity_mapping_add(swapper_pg_dir, __pa(_stext), __pa(_etext));
         identity_mapping_add(swapper_pg_dir, __pa(_sdata), __pa(_edata));

         flush_tlb_all();
         flush_cache_all();
         cpu_proc_fin();

         flush_tlb_all();
         flush_cache_all();

         cpu_reset(__pa(cpu_resume));
}

There's a few things about it that I'm not fully happy with quite yet:

a) The fixup of sleep_save_sp is ugly (and assumes that for SMP, the
    boot CPU is always number 0). The really ugly bit is the assembly
    code in swsusp_arch_suspend ...

    It'd be better to have an interface for setting / retrieving it.

    How do you think this should be dealt with ?

b) Embedding 1:1 mappings for the MMU off transition into swapper_pg_dir
    is currently done without cleaning up.
    The hibernation code should really leave no traces behind.

c) it needs a cpu_reset that disables the MMU. cpu_v6/v7_reset don't do
    so, hence a corresponding modification to arch/arm/mm/proc-*.S is
    needed (that's no different to e.g. KEXEC, really ...)

I'll send another patch once I've done OMAP3 testing.

Thanks,
FrankH.



>
>        ldr     r2, =cpu_do_resume
>        sub     r2, r1                  @ __pa()
>        ldr     r3, =.Lmmu_is_off
>        sub     r3, r1                  @ __pa()
>        sub     r0, r1                  @ __pa()
>        ldr     lr, =.Lpost_mmu
>        mrc     p15, 0, r1, c1, c0, 0
>        bic     r1, #CR_M
>        mcr     p15, 0, r1, c1, c0, 0   @ MMU OFF
>
>        mrc     p15, 0, r1, c2, c0, 0   @ queue a dependency on CP15
>        sub     pc, r3, r1, lsr #32     @ to local label, phys addr
> .ltorg
> .align 5
> .Lmmu_is_off:
>        mov     pc, r2                  @ jump to phys cpu_v6_do_resume
>
