From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Jul 2013 20:27:21 -0400 (EDT)
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <20130723163319.GA781@e102568-lin.cambridge.arm.com>
References: <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
 <20130718150408.GB2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
 <20130718180323.GC2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181452480.14924@syhkavp.arg>
 <20130719102844.GA3746@localhost.localdomain>
 <20130719105907.GB27389@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307221353360.15022@syhkavp.arg>
 <20130723104352.GA3023@localhost.localdomain>
 <alpine.LFD.2.03.1307230821270.15022@syhkavp.arg>
 <20130723163319.GA781@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1307242010580.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Lorenzo Pieralisi wrote:

> On Tue, Jul 23, 2013 at 01:28:16PM +0100, Nicolas Pitre wrote:
> 
> [...]
> 
> > > > + * - The CPU is obviously no longer coherent with the other CPUs.
> > > > + *
> > > > + * Further considerations:
> > > > + *
> > > > + * - This relies on the presence and behavior of the AUXCR.SMP bit as
> > > > + *   documented in the ARMv7 TRM.  Vendor implementations that deviate from
> > > 
> > > Sorry to be pedantic here, but there is no "ARMv7 TRM".  The SMP bit is
> > > not part of ARMv7 at all.
> > 
> > Well, I just copied Lorenzo's words here, trusting he knew more about it 
> > than I do.
> > 
> > > Also, it seems that A9 isn't precisely the
> > > same: two ACTLR bits need to be twiddled.  R-class CPUs are generally
> > > not the same either.
> 
> If you mean the ACTLR.FW bit in A9, A5, and R7, then, IIRC, we do not need to
> clear it, clearing the SMP bit is enough.
> 
> See, Dave has a point, there is no explicit "unified v7 TRM disable
> clean and exit coherency procedure" even though the designers end goal is to
> have one and that's the one you wrote. The code you posted is perfectly ok on
> all v7 implementations in the kernel I am aware of, I stand to be corrected
> but to the best of my knowledge that's the case.

OK, I'm removing allusion to an ARMv7 TRM from the comment.

> > > This is why I preferred to treat the whole sequence as specific to a
> > > particular CPU implementation.  The similarity between A7 and A15
> > > might be viewed as a happy coincidence (it also makes life easier in
> > > big.LITTLE land).
> > 
> > Fair enough.
> 
> I disagree on the happy coincidence but the point is taken. I am not
> sure about what we should do, but I reiterate my point, the sequence as
> it stands is OK on all NS v7 implementations I am aware of. We can add
> macros to differentiate processors when we need them, but again that's
> just my opinion, as correct as it can be.

I tend to prefer that as well.

"In theory, practice and theory are equivalent, but in practice they're not"

So if in _practice_ all the ARMv7 implementations we care about are OK 
with the above, then I don't see why we couldn't call it v7_*.

Here's the portion of the patch that I just changed.  All the rest 
stayed the same.  What do you think?

--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -436,4 +436,38 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
 #define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
 #define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
 
+/*
+ * Disabling cache access for one CPU in an ARMv7 SMP system is tricky.
+ * To do so we must:
+ *
+ * - Clear the SCTLR.C bit to prevent further cache allocations
+ * - Flush the desired level of cache
+ * - Clear the ACTLR "SMP" bit to disable local coherency
+ *
+ * ... and so without any intervening memory access in between those steps,
+ * not even to the stack.
+ *
+ * WARNING -- After this has been called:
+ *
+ * - No ldrex/strex (and similar) instructions must be used.
+ * - The CPU is obviously no longer coherent with the other CPUs.
+ * - This is unlikely to work as expected if Linux is running non-secure.
+ */
+#define v7_exit_coherency_flush(level) \
+	asm volatile( \
+	"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR \n\t" \
+	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
+	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR \n\t" \
+	"isb	\n\t" \
+	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
+	"clrex	\n\t" \
+	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR \n\t" \
+	"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t" \
+	"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR \n\t" \
+	"isb	\n\t" \
+	"dsb	" \
+	/* The clobber list is dictated by the call to v7_flush_dcache_* */ \
+	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
+	      "r9","r10","r11","lr","memory" )
+
 #endif


Nicolas
