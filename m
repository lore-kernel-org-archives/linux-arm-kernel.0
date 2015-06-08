From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 08 Jun 2015 01:28:58 +0100
Subject: [PATCH v2] ARM: mm: Add kernel parameter for imprecise abort handling
Message-ID: <1433723338.12074.42.camel@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we receive an imprecise abort it is possible that the currently
running task did not cause it - it could be from an external bus
bridge or another device causing a fault on the bus.

Historically we've always signalled the current task anyway, but
depending on the platform and stage of development it may be more
appropriate to log and continue or to panic.

Add a kernel parameter to choose between these 3 options.

Based on work by Ben Dooks.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 Documentation/kernel-parameters.txt |  5 ++++
 arch/arm/mm/fault.c                 | 53 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/fsr-2level.c            | 32 +++++++++++-----------
 arch/arm/mm/fsr-3level.c            |  2 +-
 4 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index f6befa9855c1..19e8ebb54998 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1430,6 +1430,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	imp_abort=	[KNL,ARM]
+			Set behaviour in case of an imprecise abort.
+			Format: { "log" | "signal" | "panic" }
+			Default: "signal"
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 6333d9c17875..ad67d61ccd86 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -518,6 +518,59 @@ struct fsr_info {
 	const char *name;
 };
 
+static struct fsr_info fsr_info[];
+
+/*
+ * When we receive an imprecise abort it is possible that the
+ * currently running task did not cause it - it could be from an
+ * external bus bridge or another device causing a fault on the bus.
+ * So this handler may be configured to log or panic instead of
+ * signalling the task.
+ */
+
+static enum {
+	IMP_ABORT_LOG,
+	IMP_ABORT_SIGNAL,
+	IMP_ABORT_PANIC
+} imp_abort = IMP_ABORT_SIGNAL;
+
+static int __init imp_abort_setup(char *str)
+{
+	if (!strcmp(str, "log")) {
+		imp_abort = IMP_ABORT_LOG;
+	} else if (!strcmp(str, "signal")) {
+		imp_abort = IMP_ABORT_SIGNAL;
+	} else if (!strcmp(str, "panic")) {
+		imp_abort = IMP_ABORT_PANIC;
+	} else {
+		pr_info("imp_abort argument %s ignored\n", str);
+		return 0;
+	}
+	return 1;
+}
+__setup("imp_abort=", imp_abort_setup);
+
+static int
+do_bad_imprecise(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
+
+	switch (imp_abort) {
+	case IMP_ABORT_LOG:
+		pr_alert("Imprecise abort: %s (0x%03x) at %08lx\n",
+			 inf->name, fsr, addr);
+		return 0;
+
+	case IMP_ABORT_SIGNAL:
+	default:
+		return do_bad(addr, fsr, regs);
+
+	case IMP_ABORT_PANIC:
+		panic("Imprecise abort: %s (0x%03x) at %08lx\n",
+		      inf->name, fsr, addr);
+	}
+}
+
 /* FSR definition */
 #ifdef CONFIG_ARM_LPAE
 #include "fsr-3level.c"
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index 18ca74c0f341..8f5ef6013015 100644
--- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -24,22 +24,22 @@ static struct fsr_info fsr_info[] = {
 	 * 10 of the FSR, and may not be recoverable.  These are only
 	 * supported if the CPU abort handler supports bit 10.
 	 */
-	{ do_bad,		SIGBUS,  0,		"unknown 16"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 17"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 18"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 19"			   },
-	{ do_bad,		SIGBUS,  0,		"lock abort"			   }, /* xscale */
-	{ do_bad,		SIGBUS,  0,		"unknown 21"			   },
-	{ do_bad,		SIGBUS,  BUS_OBJERR,	"imprecise external abort"	   }, /* xscale */
-	{ do_bad,		SIGBUS,  0,		"unknown 23"			   },
-	{ do_bad,		SIGBUS,  0,		"dcache parity error"		   }, /* xscale */
-	{ do_bad,		SIGBUS,  0,		"unknown 25"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 26"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 27"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 28"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 29"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 30"			   },
-	{ do_bad,		SIGBUS,  0,		"unknown 31"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 16"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 17"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 18"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 19"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"lock abort"			   }, /* xscale */
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 21"			   },
+	{ do_bad_imprecise,	SIGBUS,  BUS_OBJERR,	"imprecise external abort"	   }, /* xscale */
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 23"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"dcache parity error"		   }, /* xscale */
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 25"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 26"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 27"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 28"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 29"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 30"			   },
+	{ do_bad_imprecise,	SIGBUS,  0,		"unknown 31"			   },
 };
 
 static struct fsr_info ifsr_info[] = {
diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
index ab4409a2307e..5795c1a89707 100644
--- a/arch/arm/mm/fsr-3level.c
+++ b/arch/arm/mm/fsr-3level.c
@@ -16,7 +16,7 @@ static struct fsr_info fsr_info[] = {
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
 	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
-	{ do_bad,		SIGBUS,  0,		"asynchronous external abort"	},
+	{ do_bad_imprecise,	SIGBUS,  0,		"asynchronous external abort"	},
 	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
 	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
-- 
2.1.4
