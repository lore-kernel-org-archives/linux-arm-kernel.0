From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 16:18:59 +0100
Subject: [PATCH 2/9] ARM: change NR_IPIS to 8
In-Reply-To: <20160218143709.GQ19428@n2100.arm.linux.org.uk>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-3-git-send-email-arnd@arndb.de>
 <20160218143709.GQ19428@n2100.arm.linux.org.uk>
Message-ID: <2915766.O3WEnikESX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 14:37:09 Russell King - ARM Linux wrote:
> On Thu, Feb 18, 2016 at 03:01:54PM +0100, Arnd Bergmann wrote:
> > When function tracing for IPIs is enabled, we get a warning for an
> > overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> > as triggered by raise_nmi():
> > 
> > arch/arm/kernel/smp.c: In function 'raise_nmi':
> > arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
> >   trace_ipi_raise(target, ipi_types[ipinr]);
> 
> We really don't want to treat the backtrace IPI as a normal IPI at all -
> we want it to invoke the least amount of code possible.  Hence this code
> which avoids the issue:
> 
>         if ((unsigned)ipinr < NR_IPI) {
>                 trace_ipi_entry_rcuidle(ipi_types[ipinr]);
>                 __inc_irq_stat(cpu, ipi_irqs[ipinr]);
>         }
> 
> However, what's missing is that the addition of tracing here missed
> that CPU_BACKTRACE is not to be traced.  The call in raise_nmi()
> should have been converted to __smp_cross_call() to avoid the
> tracing code.

I've replaced the patch locally with the version below now, and
will throw it into the randconfig build test infrastructure to
make sure I didn't screw up in an obvious way here.

	Arnd

>From 7528c9b0558fdf4de785e62e61f0dd2ffe874110 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 31 Jan 2016 22:26:21 +0100
Subject: [PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE

When function tracing for IPIs is enabled, we get a warning for an
overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
as triggered by raise_nmi():

arch/arm/kernel/smp.c: In function 'raise_nmi':
arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
  trace_ipi_raise(target, ipi_types[ipinr]);

This is a correct warning as we actually overflow the array here.

This patch raise_nmi() to call __smp_cross_call() instead of
smp_cross_call(), to avoid calling into ftrace. For clarification,
I'm also adding a two new code comments describing how this one
is special.

The warning appears to have shown up after patch e7273ff49acf
("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
changed the number assignment from '15' to '8', but as far as I can
tell has existed since the IPI tracepoints were first introduced.
If we decide to backport this patch to stable kernels, we probably
need to backport e7273ff49acf as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 3d7351c844aa..2fd0a2619b0b 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,6 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
+/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
 #define NR_IPI	7
 
 typedef struct {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b4048e370730..9802a94260db 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -72,6 +72,10 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	/*
+	 * CPU_BACKTRACE is special and not included in NR_IPI
+	 * or tracable with trace_ipi_*
+	 */
 	IPI_CPU_BACKTRACE,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
@@ -757,7 +761,7 @@ static void raise_nmi(cpumask_t *mask)
 	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
 		nmi_cpu_backtrace(NULL);
 
-	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
 void arch_trigger_all_cpu_backtrace(bool include_self)
