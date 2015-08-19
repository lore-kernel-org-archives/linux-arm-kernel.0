From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 19 Aug 2015 11:14:27 +0100
Subject: [PATCH 2/3] [v4] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <55D3825D.6020105@codeaurora.org>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <1438992995-22610-2-git-send-email-timur@codeaurora.org>
 <20150810094008.GD1604@arm.com> <55D2749A.401@codeaurora.org>
 <20150818082141.GA6281@e103592.cambridge.arm.com>
 <55D3825D.6020105@codeaurora.org>
Message-ID: <20150819101426.GB6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 02:07:09PM -0500, Timur Tabi wrote:
> On 08/18/2015 03:21 AM, Dave Martin wrote:
> >>Do you think that I need an explicit instruction to clear the upper
> >>>bits?  I tried a few compiler tricks (e.g. "c && 0xff" and the
> >>>like), and they had no effect.
> >The in-register representation of a char permits the upper bits to be
> >nonzero, so you need to convert to a register-sized type if you want
> >to be able to force those bits to zero.
> >
> >Try: (unsigned long)(unsigned char)c or (unsigned long)c & 0xff.
> 
> I tried all those, and more, and I still always get the same thing:
> 
>   28:	38401423 	ldrb	w3, [x1],#1
>   2c:	d5130503 	msr	dbgdtrrx_el0, x3
> 
> I know that ldrb will zero-extend the byte to a 32-bit word.  But I
> don't see any way to zero-extend the word into a 64-bit register.
> 
> I'm not even sure that this is necessary.  The dbgdtrrx_el0 register
> is technically only 32-bit anyway.  It looks to me like the code is
> already correct.

[...]

> >Check the ARM ARM for what operand combinations are allowed.  However,
> >it doesn't really make any difference here because it's a general rule
> >in the architecture that when an instruction's output is in a
> >W-register, the upper 32 bits of the corresponding X-register are
> >always zeroed anyway.
> 
> So does that mean that ldrb will zero-extend the byte to all 64 bits of x3?

Yes.  No extra operation is required.

Cheers
---Dave
