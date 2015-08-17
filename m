From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 17 Aug 2015 18:56:10 -0500
Subject: [PATCH 2/3] [v4] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <20150810094008.GD1604@arm.com>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <1438992995-22610-2-git-send-email-timur@codeaurora.org>
 <20150810094008.GD1604@arm.com>
Message-ID: <55D2749A.401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 04:40 AM, Will Deacon wrote:
>> >+static inline void __dcc_putchar(char c)
>> >+{
>> >+	asm volatile("msr dbgdtrtx_el0, %0"
>> >+			: /* No output register */
>> >+			: "r" (c));
>> >+	isb();

> I think we should be masking out the upper bits of c before the msr
> (the compiler probably expects a uxtb).

Well, we've never seen a problem, but that doesn't mean it doesn't 
exist.  I couldn't find anything in the ARMv8 ARM (section H9.2.7 
DBGDTRTX_EL0) about word sizes.

Do you think that I need an explicit instruction to clear the upper 
bits?  I tried a few compiler tricks (e.g. "c && 0xff" and the like), 
and they had no effect.

I do need help with the inline assembly.  I tried this:

static inline void __dcc_putchar(char c)
{
	unsigned int __c;

	asm volatile("uxtb %0, %w1\n"
		"msr dbgdtrtx_el0, %0"
			: "=r" (__c)
			: "r" (c));
	isb();
}

it gives this assembly code:

   28:	38401423 	ldrb	w3, [x1],#1
   2c:	53001c63 	uxtb	w3, w3
   30:	d5130503 	msr	dbgdtrrx_el0, x3

Is this correct?  Shouldn't it be "uxtb x3, w3"?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
