From: eun.taik.lee@samsung.com (EunTaik Lee)
Date: Tue, 16 Feb 2016 04:44:38 +0000 (GMT)
Subject: [PATCH v2] arm64: add alignment fault hanling
Message-ID: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Userspace memory is mapped as below:
F2A7F000--F2A7FFFF Normal Memory
F2A80000--F2A80FFF Device nGnRnE

And that userspace application makes a system call
as below:

-009 |do_strncpy_from_user(inline)
-009 |strncpy_from_user()
-010 |getname_flags()
-011 |user_path_at_empty()
-012 |user_path_at()
-013 |SYSC_faccessat(inline)
-013 |sys_faccessat()
-014 |__sys_trace(asm)
 --> |exception

The string spans from 0xF2A7FFC1 to 0xF2A7FFFB.

When do_strncpy_from_user() reads the last (unsigned long)
value, the alignement fault is triggered. The 8 byte
from 0xF2A7FFC1 spans to the next page that is mapped as
Device nGnRnE, which does not allow an unaligned access,
causes the abort.

The instruction which caused the alignment fault is registered
in the fixup table but the exception handler does not reach there.

This patch registers a alignment fault handler and fixes up the
pc if appropriate.

Signed-off-by: Eun Taik Lee <eun.taik.lee@samsung.com>
---

changes in v2 : call do_bad_area() instead of calling
 fix_up_exception directly.

 arch/arm64/mm/fault.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 19211c4..a5ebb99 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -371,6 +371,14 @@ static int __kprobes do_translation_fault(unsigned long addr,
 	return 0;
 }
 
+static int __kprobes do_alignment_fault(unsigned long addr,
+					  unsigned int esr,
+					  struct pt_regs *regs)
+{
+	do_bad_area(addr, esr, regs);
+	return 0;
+}
+
 /*
  * This abort handler always returns "fault".
  */
@@ -418,7 +426,7 @@ static struct fault_info {
 	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
 	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
 	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
-	{ do_bad,		SIGBUS,  BUS_ADRALN,	"alignment fault"		},
+	{ do_alignment_fault,	SIGBUS,  BUS_ADRALN,	"alignment fault"		},
 	{ do_bad,		SIGBUS,  0,		"debug event"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 35"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 36"			},
-- 
1.9.1
