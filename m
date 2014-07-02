From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 2 Jul 2014 23:50:25 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140702213340.GT32514@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
 <20140702191832.5e9f35fc@free-electrons.com>
 <20140702175857.GR32514@n2100.arm.linux.org.uk>
 <20140702222817.1262a7b0@free-electrons.com>
 <20140702213340.GT32514@n2100.arm.linux.org.uk>
Message-ID: <20140702235025.33025455@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 2 Jul 2014 22:33:40 +0100, Russell King - ARM Linux wrote:

> That's where having a separate processor struct comes in (which we
> already have for the pj4b) and having a separate switch_mm which knows
> to set the TTB flags to write allocate.

Ah, okay.

> You're assuming that I remember all the details each time... I know
> that you have sent me several times all the details about what each
> Armada device requires, and each time I've briefly read it and thought
> "yes, I must get to that" and then never have done.  That's why we're
> not making progress - I haven't had the time to read and digest your
> messages properly.  For example, if you asked me right now what
> Armada XP requires, whether it's SMP or not, I really couldn't tell
> you.

That's surely something I understand perfectly. It took me a while to
get in my head all the requirements of the various SoCs, so I certainly
understand that someone not working on a daily with only those specific
SoCs can easily lose track of what each SoC requires.

Maybe I should write up a summary document/web-page of the requirements
of each SoC, with their identifier values, all progressively add all
the relevant details as the discussion progresses.

> Right, so you're using pj4b_processor_functions here.
> 
> #ifdef CONFIG_CPU_PJ4B
>         globl_equ       cpu_pj4b_switch_mm,     cpu_v7_switch_mm
>         globl_equ       cpu_pj4b_set_pte_ext,   cpu_v7_set_pte_ext
>         globl_equ       cpu_pj4b_proc_init,     cpu_v7_proc_init
> 
> So we need to delete the first (switch_mm) so we can replace it.  I
> think we may need a second set of processor functions to deal with
> the MP version as well.  Most of these would need to be aliased
> to the cpu_pj4b versions, except for the switch_mm one too.
> 
> You may wish to consider changing switch_mm to look something like the
> following.  I'm assuming that for pj4b you just need WBWA for both
> the inner and the outer, but not the shared bit - you'll need to change
> that if it needs something else:
> 
> ENTRY(cpu_pj4b_switch_mm)
> 	orr	r0, r0, #TTB_IRGN_WBWA | TTB_RGN_OC_WBWA
> 	b	1f
> ENTRY(cpu_pj4b_mp_switch_mm)
> 	orr	r0, r0, #TTB_FLAGS_SMP
> 	b	1f
> 	
> ENTRY(cpu_v7_switch_mm)
> #ifdef CONFIG_MMU
>         ALT_SMP(orr     r0, r0, #TTB_FLAGS_SMP)
>         ALT_UP(orr      r0, r0, #TTB_FLAGS_UP)
> 1:      mmid    r1, r1                          @ get mm->context.id
>         mov     r2, #0
> #ifdef CONFIG_ARM_ERRATA_430973
>         mcr     p15, 0, r2, c7, c5, 6           @ flush BTAC/BTB
> #endif
> ...
> ENDPROC(cpu_v7_switch_mm)
> ENDPROC(cpu_pj4b_switch_mm)
> ENDPROC(cpu_pj4b_mp_switch_mm)
> 
> That gets rid of the one in the switch_mm path.  The setup
> function is much more icky.
> 
> I think __v7_setup needs splitting up - especially due to all the
> errata in there.  I think we ought to add a whole load of processor
> proc_info's - for ARM Cortex-A8, Cortex-A9, Cortex-A15 etc.  Each
> one calls a separate setup function which runs only the appropriate
> errata fixups for that core (which eliminates a load of testing in
> __v7_setup).
> 
> This also means we can split the v7_ttb_setup macro and change it
> to be per CPU.  (I'm not entirely convinced right now that TTB1
> isn't initialised with an undefined value - I can't see where r8
> is setup amongst the mess that this has turned into.
> 
> I'm not sure what this means for the 3level v7 code - that's something
> I've never looked at except a brief glance when it went in.  The
> v7_ttb_setup there looks rather complicated and might make the changes
> I outlined above much harder.  That also isn't something I can play
> around with because I've never been able to get Linux running on the
> Versatile Express with the CPU card that would support that code.  We
> may need to enlist Catalin's help to modify that code.
> 
> That's about the best guidance I can give this evening, and I hope
> it helps you.

Wow, thanks a lot for all those details. It'll also take me a little
while to digest these informations, and see what I can implement based
on that.

Thanks again!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
