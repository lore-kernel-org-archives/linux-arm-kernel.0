From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 11:30:21 +0000
Subject: [PATCH v8 9/4] arm64: remove irq_count and do_softirq_own_stack()
In-Reply-To: <68E0E2C7-A4C2-45C2-95C5-842FA807F918@gmail.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1450454507-8907-1-git-send-email-james.morse@arm.com>
 <68E0E2C7-A4C2-45C2-95C5-842FA807F918@gmail.com>
Message-ID: <20151221113021.GH23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 20, 2015 at 08:07:46PM +0900, Jungseok Lee wrote:
> On Dec 19, 2015, at 1:01 AM, James Morse wrote:
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 0667fb7d8bb1..6745a9041f99 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -181,19 +181,20 @@ alternative_endif
> > 	.macro	irq_stack_entry
> > 	mov	x19, sp			// preserve the original sp
> > 
> > -	this_cpu_ptr irq_stack, x25, x26
> > -
> > 	/*
> > -	 * Check the lowest address on irq_stack for the irq_count value,
> > -	 * incremented by do_softirq_own_stack if we have re-enabled irqs
> > -	 * while on the irq_stack.
> > +	 * Compare sp and sp_el0, if the top ~(THREAD_SIZE - 1) bits match,
> > +	 * we are on a task stack, and should switch to the irq stack.
> > 	 */
> > -	ldr	x26, [x25]
> > -	cbnz	x26, 9998f		// recursive use?
> > +	mrs	x26, sp_el0		// already masked
> 
> Nit: How about using 'get_thread_info x26'?

Something like the following?

Will

--->8

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6745a9041f99..c0db321db7e1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -182,12 +182,12 @@ alternative_endif
 	mov	x19, sp			// preserve the original sp
 
 	/*
-	 * Compare sp and sp_el0, if the top ~(THREAD_SIZE - 1) bits match,
-	 * we are on a task stack, and should switch to the irq stack.
+	 * Compare sp with the current thread_info, if the top
+	 * ~(THREAD_SIZE - 1) bits match, we are on a task stack, and
+	 * should switch to the irq stack.
 	 */
-	mrs	x26, sp_el0		// already masked
 	and	x25, x19, #~(THREAD_SIZE - 1)
-	cmp	x25, x26
+	cmp	x25, tsk
 	b.ne	9998f
 
 	this_cpu_ptr irq_stack, x25, x26
@@ -406,10 +406,10 @@ el1_irq:
 	bl	trace_hardirqs_off
 #endif
 
+	get_thread_info tsk
 	irq_handler
 
 #ifdef CONFIG_PREEMPT
-	get_thread_info tsk
 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
 	cbnz	w24, 1f				// preempt count != 0
 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
