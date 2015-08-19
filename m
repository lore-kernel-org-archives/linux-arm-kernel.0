From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 19 Aug 2015 17:37:36 +0100
Subject: [PATCH 2/3] [v4] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <55D4ABF4.5020600@codeaurora.org>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <1438992995-22610-2-git-send-email-timur@codeaurora.org>
 <20150810094008.GD1604@arm.com> <55D2749A.401@codeaurora.org>
 <20150818082141.GA6281@e103592.cambridge.arm.com>
 <55D3825D.6020105@codeaurora.org>
 <20150819101426.GB6281@e103592.cambridge.arm.com>
 <55D4ABF4.5020600@codeaurora.org>
Message-ID: <20150819163736.GC6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 11:16:52AM -0500, Timur Tabi wrote:
> On 08/19/2015 05:14 AM, Dave Martin wrote:
> >>>So does that mean that ldrb will zero-extend the byte to all 64 bits of x3?
> >Yes.  No extra operation is required.
> 
> So my patch is actually correct as-is?

+static inline void __dcc_putchar(char c)
+{
+	asm volatile("msr dbgdtrtx_el0, %0"
+			: /* No output register */
+			: "r" (c));

For safety, you still need to make sure that c is appropriately masked
before passing it to the asm.  Something like this should definitely be
safe:

			: "r" ((unsigned long)(unsigned char)c)

GCC can then emit uxtb or not, depending on whether it's needed in each
context where the asm is inlined.

Cheers
---Dave
