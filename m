From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 12:02:29 +0000
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <AANLkTimqiqABxCejdeOQWZZ62DVUZW2v-yMpdu1aNDQT@mail.gmail.com>
References: <1294990949-2729-1-git-send-email-ccross@android.com>
	<AANLkTimqiqABxCejdeOQWZZ62DVUZW2v-yMpdu1aNDQT@mail.gmail.com>
Message-ID: <20110114120229.GA15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 11:43:04AM +0000, Catalin Marinas wrote:
> > ? ? ? ?pr_debug("VFP: bounce: trigger %08x fpexc %08x\n", trigger, fpexc);
> >
> > ? ? ? ?/*
> > + ? ? ? ?* If the exception occured in thumb mode, pc is exception location + 2,
> > + ? ? ? ?* the middle of the 32-bit VFP instruction. ?Add 2 to get exception
> > + ? ? ? ?* location + 4, the same we get in ARM mode.
> > + ? ? ? ?*/
> > +#ifdef CONFIG_ARM_THUMB
> > + ? ? ? if (regs->ARM_cpsr & PSR_T_BIT)
> > + ? ? ? ? ? ? ? regs->ARM_pc += 2;
> > +#endif
> 
> You can use "if (thumb_mode(regs))" and avoid the #ifdef entirely.

I don't think this is correct.  On entry to the undefined instruction
handler, we get the uncorrected PC value, so PC points to the
instruction after the faulting instruction.

If it was an ARM instruction, that is located at PC-4.  If it was a
Thumb instruction, it is located at PC-2.  This PC value is passed
unmodified to the VFP entry code, and the passed r2 reflect the
value in regs->ARM_pc.

The VFP entry assembly doesn't touch the PC value, except when it
wants to retry an instruction:

        sub     r2, r2, #4
        str     r2, [sp, #S_PC]         @ retry the instruction

So I think that 2 to the PC when in thumb mode is incorrect, as that'll
cause us to skip the instruction following the faulted one.

I think that the undefined instruction handling needs reworking for
Thumb entirely as we could be dealing with a 16-bit or 32-bit thumb
instruction, and we have no way of knowing without repeatedly
decoding that instruction.
