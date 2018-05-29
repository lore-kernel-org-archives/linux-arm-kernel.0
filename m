From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 29 May 2018 15:54:45 +0100
Subject: [PATCH v5 07/15] ARM: spectre-v2: add Cortex A8 and A15 validation of
 the IBE bit
In-Reply-To: <20180529145320.GJ17671@n2100.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
Message-ID: <E1fNg1N-000563-Mf@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the branch predictor hardening is enabled, firmware must have set
the IBE bit in the auxiliary control register.  If this bit has not
been set, the Spectre workarounds will not be functional.

Add validation that this bit is set, and print a warning at alert level
if this is not the case.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mm/Makefile       |  2 +-
 arch/arm/mm/proc-v7-bugs.c | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S      |  4 ++--
 3 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mm/proc-v7-bugs.c

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 9dbb84923e12..a0c40610210c 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -97,7 +97,7 @@ obj-$(CONFIG_CPU_MOHAWK)	+= proc-mohawk.o
 obj-$(CONFIG_CPU_FEROCEON)	+= proc-feroceon.o
 obj-$(CONFIG_CPU_V6)		+= proc-v6.o
 obj-$(CONFIG_CPU_V6K)		+= proc-v6.o
-obj-$(CONFIG_CPU_V7)		+= proc-v7.o
+obj-$(CONFIG_CPU_V7)		+= proc-v7.o proc-v7-bugs.o
 obj-$(CONFIG_CPU_V7M)		+= proc-v7m.o
 
 AFLAGS_proc-v6.o	:=-Wa,-march=armv6
diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
new file mode 100644
index 000000000000..e46557db6446
--- /dev/null
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/smp.h>
+
+static __maybe_unused void cpu_v7_check_auxcr_set(bool *warned,
+						  u32 mask, const char *msg)
+{
+	u32 aux_cr;
+
+	asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (aux_cr));
+
+	if ((aux_cr & mask) != mask) {
+		if (!*warned)
+			pr_err("CPU%u: %s", smp_processor_id(), msg);
+		*warned = true;
+	}
+}
+
+static DEFINE_PER_CPU(bool, spectre_warned);
+
+static void check_spectre_auxcr(bool *warned, u32 bit)
+{
+	if (IS_ENABLED(CONFIG_HARDEN_BRANCH_PREDICTOR) &&
+		cpu_v7_check_auxcr_set(warned, bit,
+				       "Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable\n");
+}
+
+void cpu_v7_ca8_ibe(void)
+{
+	check_spectre_auxcr(this_cpu_ptr(&spectre_warned), BIT(6));
+}
+
+void cpu_v7_ca15_ibe(void)
+{
+	check_spectre_auxcr(this_cpu_ptr(&spectre_warned), BIT(0));
+}
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a2d433d59848..fa9214036fb3 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -569,7 +569,7 @@ ENDPROC(__v7_setup)
 	globl_equ	cpu_ca8_do_suspend,	cpu_v7_do_suspend
 	globl_equ	cpu_ca8_do_resume,	cpu_v7_do_resume
 #endif
-	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1, bugs=cpu_v7_ca8_ibe
 
 	@ Cortex-A9 - needs more registers preserved across suspend/resume
 	@ and bpiall switch_mm for hardening
@@ -602,7 +602,7 @@ ENDPROC(__v7_setup)
 	globl_equ	cpu_ca15_suspend_size,	cpu_v7_suspend_size
 	globl_equ	cpu_ca15_do_suspend,	cpu_v7_do_suspend
 	globl_equ	cpu_ca15_do_resume,	cpu_v7_do_resume
-	define_processor_functions ca15, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+	define_processor_functions ca15, dabort=v7_early_abort, pabort=v7_pabort, suspend=1, bugs=cpu_v7_ca15_ibe
 #ifdef CONFIG_CPU_PJ4B
 	define_processor_functions pj4b, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #endif
-- 
2.7.4
