From: kirill@shutemov.name (Kirill A. Shutsemov)
Date: Mon, 19 Jul 2010 11:53:23 +0300
Subject: [PATCH 3/5] Check arch version and modify fsr_info[] depends on it at
	runtime
In-Reply-To: <cover.1279529223.git.kirill@shutemov.name>
References: <cover.1279529223.git.kirill@shutemov.name>
Message-ID: <85444c1c1533e159f2228f36adf6ad52623ae266.1279529223.git.kirill@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kirill A. Shutemov <kirill@shutemov.name>

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 arch/arm/mm/fault.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 84131c8..345a3c9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -466,12 +466,7 @@ static struct fsr_info {
 	{ do_bad,		SIGBUS,	 BUS_ADRALN,	"alignment exception"		   },
 	{ do_bad,		SIGKILL, 0,		"terminal exception"		   },
 	{ do_bad,		SIGBUS,	 BUS_ADRALN,	"alignment exception"		   },
-/* Do we need runtime check ? */
-#if __LINUX_ARM_ARCH__ < 6
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
-#else
-	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"I-cache maintenance fault"	   },
-#endif
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
 	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
@@ -596,3 +591,14 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	arm_notify_die("", regs, &info, ifsr, 0);
 }
 
+static int __init exceptions_init(void)
+{
+	if (cpu_architecture() >= CPU_ARCH_ARMv6) {
+		hook_fault_code(4, do_translation_fault, SIGSEGV, SEGV_MAPERR,
+				"I-cache maintenance fault");
+	}
+
+	return 0;
+}
+
+arch_initcall(exceptions_init);
-- 
1.7.1.1
