From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Feb 2012 22:12:06 +0000
Subject: [PATCH 5/5] ARM: Cortex-M3: Add support for exception handling
In-Reply-To: <20120224220122.GD14173@pengutronix.de>
References: <20120216200143.GS14173@pengutronix.de>
 <1329423490-15580-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1329423490-15580-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120216222002.GL27825@n2100.arm.linux.org.uk>
 <20120224220122.GD14173@pengutronix.de>
Message-ID: <CAHkRjk70x+Fn+Z4iUxSMc7Zq2cKBo_ka0tNhV0i5JWmEixpRrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2012/2/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Thu, Feb 16, 2012 at 10:20:02PM +0000, Russell King - ARM Linux wrote:
>> On Thu, Feb 16, 2012 at 09:18:10PM +0100, Uwe Kleine-K?nig wrote:
>> > + ? .macro ?v7m_exception_entry
>> > + ? cpsid ? i
>> > + ? tst ? ? lr, #0x8 ? ? ? ? ? ? ? ?@ check the return stack
>> > + ? bne ? ? 1f ? ? ? ? ? ? ? ? ? ? ?@ exception on process stack
>> > + ? add ? ? r12, sp, #32 ? ? ? ? ? ?@ MSP before exception
>> > + ? stmdb ? sp!, {r4-r12, lr} ? ? ? @ push unsaved registers
>> > + ? b ? ? ? 2f
>> > +1:
>> > + ? mrs ? ? r12, psp ? ? ? ? ? ? ? ?@ get the process stack
>> > + ? sub ? ? sp, #S_FRAME_SIZE
>> > + ? stmia ? sp, {r4-r12, lr} ? ? ? ?@ push unsaved registers
>> > + ? ldmia ? r12, {r0-r3, r6, r8-r10} @ load automatically saved registers
>> > + ? add ? ? r12, sp, #S_R0
>> > + ? stmia ? r12, {r0-r3, r6, r8-r10} @ fill in the rest of struct pt_regs
>>
>> I guess this means that pt_regs no longer contains r0..pc, cpsr, old_r0
>> on this Cortex-M ?

Just to reply to Russell - yes, this part needs changing (could be the
pt_regs saving or just the signal and trace code that copies them to
user so that we preserve the ABI).

> I stared at the code now for some time and I wonder if it wouldn't be
> the most nice solution to just do something like this on exception
> entry:
>
> ? ? ? ?cpsid ? i
> ? ? ? ?sub ? ? sp, #S_FRAME_SIZE
> ? ? ? ?stmia ? sp, {r0-r12}
> ? ? ? ?put_the_right_sp_to_sp[13]
> ? ? ? ?put_lr_returnaddr_and_xPSR_from_right_stack_to_sp[14-16]
>
> For returning you could just do:
>
> ? ? ? ?add ? ? sp, #S_FRAME_SIZE
> ? ? ? ?cpsie ? i
> ? ? ? ?bx ? ? ?lr

For this kind of returning, do we actually change between Process and
Handler stack?

But we still need to set the pt_regs to the user stack. The kernel
would touch all of them if a signal is to be delivered (actually
restoring them when returning from the signal handler).

> after fixing r0 on the right stack in case you need to return something.
>
> The machine takes care to restore {r0-r3,r12,lr} and the remaining
> registers should be untouched as everything we called between entry and
> exit is AAPCS conformant.

As I said, we have sys_sigreturn which modifies those registers.

> Anyhow, I will try to implement that if I still think it could work
> after sleeping.

It's late here as well :). We'll see next week.

-- 
Catalin
