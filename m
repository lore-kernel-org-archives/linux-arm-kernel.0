From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 16 Oct 2010 20:06:38 +0200
Subject: [PATCH 2/2] ARM: add a TCM memory test
Message-ID: <1287252398-13356-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a simple test for the TCM memory, it will try to
exercise it a bit by calling into it and reading/writing
variables with canaries.

Cc: Rickard Andersson <rickard.andersson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/Kconfig           |    9 +++++
 arch/arm/kernel/Makefile   |    1 +
 arch/arm/kernel/tcm-test.c |   82 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/tcm-test.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e749933..d7999f8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1019,6 +1019,15 @@ if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
 
+config TCM_TEST
+	bool "TCM testing module"
+	depends on HAVE_TCM
+	help
+	  This enables a small testing module that execise the TCM
+	  memory on the platform at startup to make sure it's working.
+	  If you're really using the TCM it is a scarce resource so
+	  this should only be selected for testing.
+
 config ARM_ERRATA_411920
 	bool "ARM errata: Invalidation of the Instruction Cache operation can fail"
 	depends on CPU_V6
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 078dd22..91af751 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_TCM_TEST)		+= tcm-test.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
diff --git a/arch/arm/kernel/tcm-test.c b/arch/arm/kernel/tcm-test.c
new file mode 100644
index 0000000..6fc7c61
--- /dev/null
+++ b/arch/arm/kernel/tcm-test.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2010 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * TCM memory test
+ *
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/tcm.h>
+
+#define CANARY1 0xDEADBEEFU
+#define CANARY2 0x2BADBABEU
+#define CANARY3 0xCAFEBABEU
+
+/* Uninitialized data */
+static u32 __tcmdata tcmvar;
+/* Initialized data */
+static u32 __tcmdata tcmassigned = CANARY2;
+/* Constant */
+static const u32 __tcmconst tcmconst = CANARY3;
+
+static void __tcmlocalfunc tcm_to_tcm(void)
+{
+	int i;
+	for (i = 0; i < 100; i++)
+		tcmvar ++;
+}
+
+static void __tcmfunc hello_tcm(void)
+{
+	/* Some abstract code that runs in ITCM */
+	int i;
+	for (i = 0; i < 100; i++) {
+		tcmvar ++;
+	}
+	tcm_to_tcm();
+}
+
+static void __init test_tcm(void)
+{
+	u32 *tcmem;
+	int i;
+
+	hello_tcm();
+	pr_info("Hello TCM executed from ITCM RAM\n");
+
+	pr_info("TCM variable from testrun: %u @ %p\n", tcmvar, &tcmvar);
+	BUG_ON(tcmvar != 200);
+
+	tcmvar = CANARY1;
+	pr_info("TCM variable: 0x%x @ %p\n", tcmvar, &tcmvar);
+	BUG_ON(tcmvar != CANARY1);
+
+	pr_info("TCM assigned variable: 0x%x @ %p\n", tcmassigned, &tcmassigned);
+	BUG_ON(tcmassigned != CANARY2);
+
+	pr_info("TCM constant: 0x%x @ %p\n", tcmconst, &tcmconst);
+	BUG_ON(tcmconst != CANARY3);
+
+	/* Allocate some TCM memory from the pool */
+	tcmem = tcm_alloc(20);
+	if (tcmem) {
+		pr_info("TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
+		tcmem[0] = CANARY1;
+		tcmem[1] = CANARY2;
+		tcmem[2] = CANARY3;
+		tcmem[3] = CANARY1;
+		tcmem[4] = CANARY2;
+		for (i = 0; i < 5; i++)
+			pr_info("TCM tcmem[%d] = %08x\n", i, tcmem[i]);
+		BUG_ON(tcmem[0] != CANARY1);
+		BUG_ON(tcmem[1] != CANARY2);
+		BUG_ON(tcmem[2] != CANARY3);
+		BUG_ON(tcmem[3] != CANARY1);
+		BUG_ON(tcmem[4] != CANARY2);
+		tcm_free(tcmem, 20);
+	}
+}
+
+late_initcall(test_tcm);
-- 
1.6.3.3
