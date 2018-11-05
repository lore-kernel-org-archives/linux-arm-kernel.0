From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:45 +0000
Subject: [PATCH 06/10] arm64: page: use asm EXPORT_SYMBOL()
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-7-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the copy_page and
clear_page exports to the assembly files the functions are defined in.
As we have to include <asm/export.h>, the existing includes are fixed to
follow the usual ordering conventions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 3 ---
 arch/arm64/lib/clear_page.S    | 5 ++++-
 arch/arm64/lib/copy_page.S     | 9 ++++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 74e29e69190b..784b257d9643 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -30,9 +30,6 @@
 
 #include <asm/checksum.h>
 
-EXPORT_SYMBOL(copy_page);
-EXPORT_SYMBOL(clear_page);
-
 	/* user mem (segment) */
 EXPORT_SYMBOL(__arch_copy_from_user);
 EXPORT_SYMBOL(__arch_copy_to_user);
diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
index ef08e905e35b..543313c31384 100644
--- a/arch/arm64/lib/clear_page.S
+++ b/arch/arm64/lib/clear_page.S
@@ -14,9 +14,11 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/linkage.h>
 #include <linux/const.h>
+#include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include <asm/page.h>
 
 /*
@@ -37,3 +39,4 @@ ENTRY(clear_page)
 	b.ne	1b
 	ret
 ENDPROC(clear_page)
+EXPORT_SYMBOL(clear_page)
diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index 076c43715e64..7248e7157138 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -14,12 +14,14 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/linkage.h>
 #include <linux/const.h>
+#include <linux/linkage.h>
+
+#include <asm/alternative.h>
 #include <asm/assembler.h>
-#include <asm/page.h>
+#include <asm/export.h>
 #include <asm/cpufeature.h>
-#include <asm/alternative.h>
+#include <asm/page.h>
 
 /*
  * Copy a page from src to dest (both are page aligned)
@@ -87,3 +89,4 @@ alternative_else_nop_endif
 
 	ret
 ENDPROC(copy_page)
+EXPORT_SYMBOL(copy_page)
-- 
2.11.0
