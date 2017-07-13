From: mirceac@gmail.com (Mircea Ciocan)
Date: Thu, 13 Jul 2017 10:23:41 +0200
Subject: Porting a custom interrupt handler from kernel 2.6.25 to 3.16.45
Message-ID: <CAHumR2+WR3Fdtft8xrPfcT3-dpKqCL__aaEc6qri3N5-x0yCXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everybody, I'm new to the intricacies of the ARM platform
interrupt handling and I have to port a custom interrupt handler from
2.6.25 to 3.16.45.
The current situation is like this:
The timer IRQ (only one active for the moment) triggers, and the
interrupt routine is executed only once correctly.
The next time it triggers, or maybe at the end of the generic arm
interrupt handler, I got an Oops because the stack or PC seems to be
smashed and the CPU goes haywire.
The strange thing is that if in the "normal" irq handler of the timer
I don't clear the interrupt bit, the kernel loops endlessly in the
interrupt routine but it doesn't crash at all.

In the original 2.6 arch/arm/kernel/entry-armv.S the code is inserted like this:
/*  Interrupt handling.  Preserves r7, r8, r9 */
        .macro  irq_handler
#ifdef CONFIG_ARCH_CUSTOM
        irq_handler_custom r0, r6, r5, r1, lr, r2
#else
        get_irqnr_preamble r5, lr
1:      get_irqnr_and_base r0, r6, r5, lr
        movne   r1, sp
        @
        @ routine called with r0 = irq number, r1 = struct pt_regs *
        @
        adrne   lr, 1b
        bne     asm_do_IRQ
#endif
[...snip...]
        .endm

In the 3.16 new kernel the code, that doesn't work, looks like this:
/* Interrupt handling.  */

        .macro  irq_handler
#ifdef CONFIG_ARCH_CUSTOM
        irq_handler_spc300 r0, r6, r5, r1, lr, r2
#else
#ifdef CONFIG_MULTI_IRQ_HANDLER
        ldr     r1, =handle_arch_irq
        mov     r0, sp
        adr     lr, BSYM(9997f)
        ldr     pc, [r1]
#else
        arch_irq_handler_default
#endif
#endif
9997:
        .endm

I have seen that around kernel 3.0 there were some register shuffling
in the irq handler ( commit b059bdc ("ARM: entry: rejig register
allocation in exception entry handlers", 2011-06-25) )

So I will kindly ask for your assistance to point me on the right
track to have this issue solved, do I just need to shuffle the
registers or other more important changes are need ?
At least I would like to know what registers have a special meaning
and must be preserved in the latest kernel.
Also if it's a Fine Manual that I can read about the architecture of
the interrupt handling on the ARM platform, explaining the roles and
constrains on the registers used I will appreciate any pointers.

 Best regards,
 Mircea
