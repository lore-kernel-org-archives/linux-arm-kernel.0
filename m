From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Sat, 18 Apr 2015 01:14:43 +0100
Subject: [PATCH] ARM: mm: add imprecise abort non-deadly handler
Message-ID: <1429316083.8341.76.camel@xylophone.i.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Given that imprecise aborts may be delivered after the action that
caused them (or even for non-cpu related activities such as bridge
faults from a bus-master) it is possible that the wrong process is
terminated as a result.

Add a handler to take and print imprecise aborts and allow the process
to continue. This should ensure that the abort is shown but not kill
the process that was running on the cpu core at the time.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[bwh: Change the log level and format to match other exceptions;
 set the now-unused sig and code fields for these exceptions to 0]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/arm/mm/fault.c      |   20 ++++++++++++++++++++
 arch/arm/mm/fsr-2level.c |   32 ++++++++++++++++----------------
 arch/arm/mm/fsr-3level.c |    2 +-
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 6333d9c17875..da00fd68fdf4 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -518,6 +518,26 @@ struct fsr_info {
 	const char *name;
 };
 
+static struct fsr_info fsr_info[];
+
+/*
+ * On an imprecise external abort it is possible that the currently running
+ * process did not cause it (it could be from an external bus bridge or
+ * another device causing a fault on the bus).
+ *
+ * Always return handled as we do not know how to do it and killing the
+ * current process may not prevent future faults.
+ */
+static int
+do_bad_imprecise(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
+
+	pr_alert("Imprecise abort: %s (0x%03x) at %08lx\n",
+		 inf->name, fsr, addr);
+	return 0;
+}
+
 /* FSR definition */
 #ifdef CONFIG_ARM_LPAE
 #include "fsr-3level.c"
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index 18ca74c0f341..84f2d77ac150 100644
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
+	{ do_bad_imprecise,	0,	 0,		"unknown 16"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 17"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 18"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 19"			   },
+	{ do_bad_imprecise,	0,	 0,		"lock abort"			   }, /* xscale */
+	{ do_bad_imprecise,	0,	 0,		"unknown 21"			   },
+	{ do_bad_imprecise,	0,	 0,		"imprecise external abort"	   }, /* xscale */
+	{ do_bad_imprecise,	0,	 0,		"unknown 23"			   },
+	{ do_bad_imprecise,	0,	 0,		"dcache parity error"		   }, /* xscale */
+	{ do_bad_imprecise,	0,	 0,		"unknown 25"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 26"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 27"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 28"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 29"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 30"			   },
+	{ do_bad_imprecise,	0,	 0,		"unknown 31"			   },
 };
 
 static struct fsr_info ifsr_info[] = {
diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
index ab4409a2307e..6eaae6ec6d71 100644
--- a/arch/arm/mm/fsr-3level.c
+++ b/arch/arm/mm/fsr-3level.c
@@ -16,7 +16,7 @@ static struct fsr_info fsr_info[] = {
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
 	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
-	{ do_bad,		SIGBUS,  0,		"asynchronous external abort"	},
+	{ do_bad_imprecise,	0,	 0,		"asynchronous external abort"	},
 	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
 	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
-- 
1.7.10.4
