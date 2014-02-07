From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  7 Feb 2014 18:20:14 +0000
Subject: [PATCH] ARM: mm: add imprecise abort non-deadly handler
In-Reply-To: <1391797214-17142-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1391797214-17142-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1391797214-17142-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given that imprecise aborts may be delivered after the action that
caused them (or even for non-cpu related activities such as bridge
faults from a bus-master) it is possible that the wrong process is
terminated as a result.

It is not know at this time in an SMP system which cores get notified
of an imprecise external abort, we have yet to find the right details
in the architecture reference manuals. This also means that killing
the process is probably the wrong thing to do on reception of these aborts.

Add a handler to take and print imprecise aborts and allow the process
to continue. This should ensure that the abort is shown but not kill
the process that was running on the cpu core at the time.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mm/fault.c      | 15 +++++++++++++++
 arch/arm/mm/fsr-2level.c | 32 ++++++++++++++++----------------
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index eb8830a..c1fd5ba 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -512,6 +512,21 @@ do_bad(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 1;
 }
 
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
+	printk(KERN_INFO "Caught imprecise abort (0x%03x) %08lx", fsr, addr);
+	return 0;
+}
+
 struct fsr_info {
 	int	(*fn)(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 	int	sig;
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index 18ca74c..8f5ef60 100644
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
-- 
1.8.5.3
