From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 11:26:24 +0000
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <AANLkTimZ9itumf=QZPD55+JA5cUOWKgwuA1_5=XsdPsP@mail.gmail.com>
References: <1295014231.7901.41.camel@e102109-lin.cambridge.arm.com>
	<20110114154919.GE15996@n2100.arm.linux.org.uk>
	<1295022193.7901.56.camel@e102109-lin.cambridge.arm.com>
	<20110114163520.GH15996@n2100.arm.linux.org.uk>
	<1295024327.7901.70.camel@e102109-lin.cambridge.arm.com>
	<20110114173050.GJ15996@n2100.arm.linux.org.uk>
	<20110114184759.GN15996@n2100.arm.linux.org.uk>
	<AANLkTi=J2A1Qv6NGB1bsMr6d+1VFV26KEBQ=NJ=791s0@mail.gmail.com>
	<AANLkTimd44_FjnJUCNwz412Ned5S_+YcyHjfitus3vLQ@mail.gmail.com>
	<AANLkTimZ9itumf=QZPD55+JA5cUOWKgwuA1_5=XsdPsP@mail.gmail.com>
Message-ID: <20110126112624.GC2562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 03:33:24PM -0800, Colin Cross wrote:
> I think there is an additional change needed to
> __und_usr_unknown/do_undefinstr.  do_undefinstr, which gets called
> directly in __und_usr as well as by mov pc, lr, expects regs->ARM_pc
> to be the fault address, and not the next PC, and gets called for 2 or
> 4 byte instructions.

It expects it to be the next PC:

asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
{
        unsigned int correction = thumb_mode(regs) ? 2 : 4;
        unsigned int instr;
        siginfo_t info;
        void __user *pc;

        /*
         * According to the ARM ARM, PC is 2 or 4 bytes ahead,
         * depending whether we're in Thumb mode or not.
         * Correct this offset.
         */
        regs->ARM_pc -= correction;

We expect the PC to be pointing at the next instruction to be executed.
This is the value of the PC saved by the CPU when entering the exception.
We correct the PC by four bytes for ARM mode to point at the previously
executed instruction.

For 16-bit Thumb mode, the PC is again pointing at the next instruction
to be executed, and this is the value saved by the CPU.  So we correct
the PC by two bytes as that is the Thumb instruction size.

The problem comes with T2, where we advance the saved PC by two bytes
if the instruction was 32-bit such that it again points at the next
instruction to be executed.  This is where the problem comes in because
we have two different chunks of code with completely different
expectations.

Maybe we need to pass in the correction factor to do_undefinstr instead.
