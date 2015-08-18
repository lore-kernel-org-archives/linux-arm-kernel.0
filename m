From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 18 Aug 2015 09:21:52 +0100
Subject: [PATCH 2/3] [v4] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <55D2749A.401@codeaurora.org>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <1438992995-22610-2-git-send-email-timur@codeaurora.org>
 <20150810094008.GD1604@arm.com> <55D2749A.401@codeaurora.org>
Message-ID: <20150818082141.GA6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 06:56:10PM -0500, Timur Tabi wrote:
> On 08/10/2015 04:40 AM, Will Deacon wrote:
> >>>+static inline void __dcc_putchar(char c)
> >>>+{
> >>>+	asm volatile("msr dbgdtrtx_el0, %0"
> >>>+			: /* No output register */
> >>>+			: "r" (c));
> >>>+	isb();
> 
> >I think we should be masking out the upper bits of c before the msr
> >(the compiler probably expects a uxtb).
> 
> Well, we've never seen a problem, but that doesn't mean it doesn't
> exist.  I couldn't find anything in the ARMv8 ARM (section H9.2.7
> DBGDTRTX_EL0) about word sizes.
> 
> Do you think that I need an explicit instruction to clear the upper
> bits?  I tried a few compiler tricks (e.g. "c && 0xff" and the
> like), and they had no effect.

The in-register representation of a char permits the upper bits to be
nonzero, so you need to convert to a register-sized type if you want
to be able to force those bits to zero.

Try: (unsigned long)(unsigned char)c or (unsigned long)c & 0xff.

> 
> I do need help with the inline assembly.  I tried this:
> 
> static inline void __dcc_putchar(char c)
> {
> 	unsigned int __c;
> 
> 	asm volatile("uxtb %0, %w1\n"
> 		"msr dbgdtrtx_el0, %0"
> 			: "=r" (__c)
> 			: "r" (c));
> 	isb();
> }
> 
> it gives this assembly code:
> 
>   28:	38401423 	ldrb	w3, [x1],#1
>   2c:	53001c63 	uxtb	w3, w3
>   30:	d5130503 	msr	dbgdtrrx_el0, x3
> 
> Is this correct?  Shouldn't it be "uxtb x3, w3"?

Check the ARM ARM for what operand combinations are allowed.  However,
it doesn't really make any difference here because it's a general rule
in the architecture that when an instruction's output is in a
W-register, the upper 32 bits of the corresponding X-register are
always zeroed anyway.

Cheers
---Dave
