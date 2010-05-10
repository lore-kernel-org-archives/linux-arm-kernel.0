From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 10 May 2010 16:07:57 +0300
Subject: [PATCH] Handle instruction cache maintenance fault properly
Message-ID: <AANLkTikIbI6hKoYSZlo6QDlyi2Qjxg287i-ilHpz1FF9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Between "clean D line..." and "invalidate I line" operations in
v7_coherent_user_range(), the memory page may get swapped out.
And the fault on "invalidate I line" could not be properly handled
causing the oops.

The patch adds the missing handling for "instruction cache
maintenance fault". Let's handle it as translation fault.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 arch/arm/mm/fault.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 9d40c34..8924617 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -463,7 +463,7 @@ static struct fsr_info {
 	{ do_bad,		SIGILL,	 BUS_ADRALN,	"alignment exception"		   },
 	{ do_bad,		SIGKILL, 0,		"terminal exception"		   },
 	{ do_bad,		SIGILL,	 BUS_ADRALN,	"alignment exception"		   },
-	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
+	{ do_translation_fault,	SIGSEGV, SEGV_MAPPER,	"I-cache maintenance
fault"	   },
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation
fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
 	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
-- 
1.7.0.4
