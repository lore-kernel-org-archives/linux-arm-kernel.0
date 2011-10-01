From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 1 Oct 2011 18:12:02 +0100
Subject: [PATCH] Add missing include of linux/ftrace.h
In-Reply-To: <20111001163511.GI11710@n2100.arm.linux.org.uk>
References: <1317309202-1001-1-git-send-email-jamie@jamieiles.com>
	<20111001163511.GI11710@n2100.arm.linux.org.uk>
Message-ID: <20111001171202.GA13684@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2011 at 05:35:11PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 29, 2011 at 04:13:22PM +0100, Jamie Iles wrote:
> > __exception_irq_entry uses __irq_entry which is defined in
> > linux/ftrace.h.
> > 
> > Reported-by: Zoltan Devai <zdevai@gmail.com>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> This introduces a circular dependency:
> 
> linux/ftrace.h -> linux/kallsyms.h -> linux/kernel.h -> linux/bitops.h
>  -> asm/bitops.h -> asm/system.h -> linux/ftrace.h
> 
> This is not good as it means that we end up with indeterminant effects
> happening depending on where in that cycle the first include happens.

Crap.  I don't think having users of __exception_irq_entry include 
linux/ftrace.h is great, so how about this instead?

Jamie

8<----

From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] move __exception and friends to asm/exception.h

The definition of __exception_irq_entry for
CONFIG_FUNCTION_GRAPH_TRACER=y needs linux/ftrace.h, but this creates a
circular dependency with it's current home in asm/system.h.  Create
asm/exception.h and update all current users.

Reported-by: Zoltan Devai <zdevai@gmail.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/include/asm/exception.h |   13 +++++++++++++
 arch/arm/include/asm/system.h    |    7 -------
 arch/arm/kernel/irq.c            |    1 +
 arch/arm/kernel/smp.c            |    1 +
 arch/arm/kernel/traps.c          |    1 +
 arch/arm/mach-pxa/irq.c          |    2 ++
 arch/arm/mm/fault.c              |    1 +
 7 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/include/asm/exception.h

diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
new file mode 100644
index 0000000..7d6fd97
--- /dev/null
+++ b/arch/arm/include/asm/exception.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_ARM_EXCEPTION_H
+#define __ASM_ARM_EXCEPTION_H
+
+#include <linux/ftrace.h>
+
+#define __exception	__attribute__((section(".exception.text")))
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#define __exception_irq_entry	__irq_entry
+#else
+#define __exception_irq_entry	__exception
+#endif
+
+#endif /* __ASM_ARM_EXCEPTION_H */
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..ed6b049 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -62,13 +62,6 @@
 
 #include <asm/outercache.h>
 
-#define __exception	__attribute__((section(".exception.text")))
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-#define __exception_irq_entry	__irq_entry
-#else
-#define __exception_irq_entry	__exception
-#endif
-
 struct thread_info;
 struct task_struct;
 
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index de3dcab..61c1468 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -37,6 +37,7 @@
 #include <linux/proc_fs.h>
 #include <linux/ftrace.h>
 
+#include <asm/exception.h>
 #include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d88ff02..1122faf 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -31,6 +31,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
+#include <asm/exception.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index bc9f9da..2103825 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -27,6 +27,7 @@
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
+#include <asm/exception.h>
 #include <asm/system.h>
 #include <asm/unistd.h>
 #include <asm/traps.h>
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index b09e848..ca60757 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -19,6 +19,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
+#include <asm/exception.h>
+
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/gpio.h>
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3b5ea68..aa33949 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 
+#include <asm/exception.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
-- 
1.7.4.1
