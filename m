From: kirill@shutemov.name (Kirill A. Shutsemov)
Date: Mon, 19 Jul 2010 11:53:21 +0300
Subject: [PATCH 1/5] Use SIGBUS for unalinged access instead of SIGILL
In-Reply-To: <cover.1279529223.git.kirill@shutemov.name>
References: <cover.1279529223.git.kirill@shutemov.name>
Message-ID: <91bc8b97638b650c2af70b2e25814618f75cfee2.1279529223.git.kirill@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kirill A. Shutemov <kirill@shutemov.name>

POSIX specify to use signal SIGBUS with code BUS_ADRALN for invalid
address alignment.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 arch/arm/mm/alignment.c |    4 ++--
 arch/arm/mm/fault.c     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 6f98c35..53a6096 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -924,8 +924,8 @@ static int __init alignment_init(void)
 		ai_usermode = UM_FIXUP;
 	}
 
-	hook_fault_code(1, do_alignment, SIGILL, "alignment exception");
-	hook_fault_code(3, do_alignment, SIGILL, "alignment exception");
+	hook_fault_code(1, do_alignment, SIGBUS, "alignment exception");
+	hook_fault_code(3, do_alignment, SIGBUS, "alignment exception");
 
 	return 0;
 }
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index cbfb2ed..ce6f3a4 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -463,9 +463,9 @@ static struct fsr_info {
 	 * defines these to be "precise" aborts.
 	 */
 	{ do_bad,		SIGSEGV, 0,		"vector exception"		   },
-	{ do_bad,		SIGILL,	 BUS_ADRALN,	"alignment exception"		   },
+	{ do_bad,		SIGBUS,	 BUS_ADRALN,	"alignment exception"		   },
 	{ do_bad,		SIGKILL, 0,		"terminal exception"		   },
-	{ do_bad,		SIGILL,	 BUS_ADRALN,	"alignment exception"		   },
+	{ do_bad,		SIGBUS,	 BUS_ADRALN,	"alignment exception"		   },
 /* Do we need runtime check ? */
 #if __LINUX_ARM_ARCH__ < 6
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
-- 
1.7.1.1
