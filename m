From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 5 Mar 2013 09:29:57 +0000
Subject: [PATCH LINUX v5] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <20130305080845.GA19097@mudshark.cambridge.arm.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
 <51340ACD.70904@gmail.com>
 <20130305030436.GA18040@mudshark.cambridge.arm.com>
 <513596F2.1000701@gmail.com>
 <20130305080845.GA19097@mudshark.cambridge.arm.com>
Message-ID: <1362475797.8941.67.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-05 at 08:08 +0000, Will Deacon wrote:
> Cheers Rob, that was enough to reproduce for me. The problem is likely that
> CONFIG_AEABI=n, so the ABI doesn't actually mandate even base registers for
> 64-bit values in registers.

Me too.

> Ian -- this would be fixed if you used our atomic64 routines instead of
> inventing your own :)

I looked and couldn't see an existing 64 bit xchg, was I looking in the
wrong place? Ah, wait, I see atomic64_xchg now. But that needs an
atomic64_t while I have a xen_ulong_t (which == 64 bits on ARM). This is
a kernel<->hypervisor ABI so I can't just change it to an atomic64_t. I
suppose I could cast (see below, untested) but that seems rather icky.

Ian.

diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
index 0e1f59e..e86a1b3 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -2,6 +2,7 @@
 #define _ASM_ARM_XEN_EVENTS_H
 
 #include <asm/ptrace.h>
+#include <asm/atomic.h>
 
 enum ipi_vector {
 	XEN_PLACEHOLDER_VECTOR,
@@ -15,27 +16,6 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
 
-/*
- * We cannot use xchg because it does not support 8-byte
- * values. However it is safe to use {ldr,dtd}exd directly because all
- * platforms which Xen can run on support those instructions.
- */
-static inline xen_ulong_t xchg_xen_ulong(xen_ulong_t *ptr, xen_ulong_t val)
-{
-	xen_ulong_t oldval;
-	unsigned int tmp;
-
-	smp_wmb();
-	asm volatile("@ xchg_xen_ulong\n"
-		"1:     ldrexd  %0, %H0, [%3]\n"
-		"       strexd  %1, %2, %H2, [%3]\n"
-		"       teq     %1, #0\n"
-		"       bne     1b"
-		: "=&r" (oldval), "=&r" (tmp)
-		: "r" (val), "r" (ptr)
-		: "memory", "cc");
-	smp_wmb();
-	return oldval;
-}
+#define xchg_xen_ulong(ptr, val) atomic64_xchg((atomic64_t *)(ptr), (val))
 
 #endif /* _ASM_ARM_XEN_EVENTS_H */
