From: will.deacon@arm.com (Will Deacon)
Date: Tue,  9 Mar 2010 16:01:53 +0000
Subject: [PATCH] ARM: KGDB: add support for SMP platforms
Message-ID: <1268150513-3425-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support SMP platforms, KGDB requires the architecture backend to
implement the kgdb_roundup_cpus function.

This patch, taken against 2.6.33, implements the function for ARM based on
the MIPS port.

Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/kgdb.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index ba8ccfe..a5b846b 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -9,6 +9,7 @@
  * Authors:  George Davis <davis_g@mvista.com>
  *           Deepak Saxena <dsaxena@plexity.net>
  */
+#include <linux/irq.h>
 #include <linux/kgdb.h>
 #include <asm/traps.h>
 
@@ -158,6 +159,18 @@ static struct undef_hook kgdb_compiled_brkpt_hook = {
 	.fn			= kgdb_compiled_brk_fn
 };
 
+static void kgdb_call_nmi_hook(void *ignored)
+{
+       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
+}
+
+void kgdb_roundup_cpus(unsigned long flags)
+{
+       local_irq_enable();
+       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
+       local_irq_disable();
+}
+
 /**
  *	kgdb_arch_init - Perform any architecture specific initalization.
  *
-- 
1.6.3.3
