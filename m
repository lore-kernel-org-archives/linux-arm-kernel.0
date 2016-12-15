From: slash.tmp@free.fr (Mason)
Date: Thu, 15 Dec 2016 16:18:35 +0100
Subject: Linux fails to start secondary cores when system resumes from
 Suspend-to-RAM
Message-ID: <d4db03ce-80fc-2968-c5c2-84f79272ce8d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm playing with suspend-to-RAM on the tango platform:

  http://lxr.free-electrons.com/source/arch/arm/mach-tango/platsmp.c

When the system is suspended, the CPU is completely powered down
(receives no power whatsoever). When the system receives a wake-up
event, the CPU is powered up, and starts up exactly the same way
as for a cold boot (I think).

However, while Linux successfully starts the secondary cores when
the system first boots, it fails when the system resumes from "S3".

I added printascii() calls inside secondary_start_kernel() and I can
see that the following instruction are "properly" run:

	cpu_switch_mm(mm->pgd, mm);
	local_flush_bp_all();
	enter_lazy_tlb(mm, current);

but it seems local_flush_tlb_all(); never returns... :-(

  http://lxr.free-electrons.com/source/arch/arm/include/asm/tlbflush.h#L332


Looking more closely at that function, it seems to be failing in:

	tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);

(meaning: I get a log before, but not after)

On my system, tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
resolves to:

c010ce18:       e3170602        tst     r7, #2097152    ; 0x200000
c010ce1c:       1e086f17        mcrne   15, 0, r6, cr8, cr7, {0}

What could be happening?
Can a core "hang" on this instruction?
Can a core "crash" on this instruction (meaning, an exception
is raised, and the core loops inside the exception code without
Linux noticing... that seems unlikely)

I'm stumped. Could someone throw me a clue?

Mark Rutland offered a guess about IPIs not working correctly.
Could this explain the behavior I'm seeing?

Regards.
