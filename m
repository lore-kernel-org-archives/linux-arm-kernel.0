From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2011 17:24:43 +0100
Subject: RFC: Status of kernel/fiq.c
In-Reply-To: <20110405160546.GA7976@arm.com>
References: <20110405160546.GA7976@arm.com>
Message-ID: <20110405162443.GA11737@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 05:05:47PM +0100, Dave Martin wrote:
> Hi all,
> 
> I've hit a Thumb-2 compatibility issue in the assembler functions
> in kernel/fiq.c, and I'm wondering how to proceed.
> 
> With regard to set_fiq_regs() and get_fiq_regs(), does anyone know:
> 
>   * whether we still need the stack frame manipulation code in this
> 	leaf function, e.g.
> 
>         "mov    ip, sp\n\
>         stmfd  sp!, {fp, ip, lr, pc}\n\
>         sub    fp, ip, #4\n\

That's the standard APCS stack frame.  Look at the function closely
and you'll notice that its declared NAKED, so the compiler doesn't
generate anything for it.  So we have to do this by hand.

>   * what the nop (mov r0,r0) after the CPSR writes is for
>         (I'm guessing there may have been some 1-instruction hazard
>         here for some old processors, but I'm not aware of a need
>         for this in anything current.)

You're correct, and its for ARMv3 CPUs.  After writing the CPSR you
have to wait one cycle before accessing the banked registers.  On
other platforms that has been solved so the nop is harmless even
though it's not necessary.  Simplification of code dictates that we
don't try to ifdef it.

>   * should anyone be using fiq.c on v7 platforms?

Is the FIQ wired to anything useful on ARMv7.

> As the code stands, it could also go wrong if the compiler
> happens to allocate r8-r12 or lr for one of the inline asm
> constraints -- though this is pretty unlikely to happen, and
> I doubt if it ever has happened in practice.

Actually, that goes for r8 to r14 inclusive - as we switch the CPU mode to
FIQ, we lose access to any values held in those registers prior to the
assembly block being started.

The only possibility of it being unsafe is if the compiler allocates 'ip'
for 'tmp'.  We could work around that by getting rid of 'tmp' or telling
the compiler that 'tmp' is a register variable and it will be r3.
