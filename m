From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Sep 2010 11:55:01 +0100
Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq
	on UP systems
In-Reply-To: <20100902162124.GN11597@atomide.com>
References: <20100817154035.GD20325@n2100.arm.linux.org.uk>
	<20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902162124.GN11597@atomide.com>
Message-ID: <20100904105501.GA12674@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 09:21:24AM -0700, Tony Lindgren wrote:
> Do not call test_for_ipi or test_for_ltrirq on UP systems.
> 
> Note that we can't put test_for_ltriq into SMP statement as
> it's inlined into the code and the remaining lines of the
> macro would still run before UP macro line.

I think we can do better than this - unfortunately the assembler gets
a little difficult (complaining about symbols in different sections),
but it's relatively easy to work-around by precomputing the offset
using .equ.  I'm debating about making this a UP_B(label) and hiding
these details beneath this macro, rather than having this kind of thing
exposed every time we need to do something like this.

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bb2ef60..947b3ab 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -46,7 +46,9 @@
 	 * this macro assumes that irqstat (r6) and base (r5) are
 	 * preserved from get_irqnr_and_base above
 	 */
-	test_for_ipi r0, r6, r5, lr
+	SMP(test_for_ipi r0, r6, r5, lr)
+	.equ	off, 9997f - 9998b
+	UP(b	. + off)
 	movne	r0, sp
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
@@ -57,6 +59,7 @@
 	adrne	lr, BSYM(1b)
 	bne	do_local_timer
 #endif
+9997:
 #endif
 
 	.endm
