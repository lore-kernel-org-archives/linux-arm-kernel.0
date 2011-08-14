From: bsteinsbo@gmail.com (Bjarne Steinsbo)
Date: Sun, 14 Aug 2011 14:51:48 +0200
Subject: [PATCH] ARM: mm/alignment.c: Fix build breakage when CONFIG_PROC_FS
	is not selected
Message-ID: <CAFULf_zzAZKk5CsPz+9x1i0gORbapwBBwzRH1BM7s_ZuEs_8DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling mm/alignment.c without CONFIG_PROC_FS selected fails with
undefined cpu_is_v6_unaligned() and safe_usermode().

Move #ifdef CONFIG_PROC_FS, including definition of usermode_action[],
further down to avoid this problem.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
---
 arch/arm/mm/alignment.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index cfbcf8b..c335c76 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -86,16 +86,6 @@ core_param(alignment, ai_usermode, int, 0600);
 #define UM_FIXUP	(1 << 1)
 #define UM_SIGNAL	(1 << 2)

-#ifdef CONFIG_PROC_FS
-static const char *usermode_action[] = {
-	"ignored",
-	"warn",
-	"fixup",
-	"fixup+warn",
-	"signal",
-	"signal+warn"
-};
-
 /* Return true if and only if the ARMv6 unaligned access model is in use. */
 static bool cpu_is_v6_unaligned(void)
 {
@@ -123,6 +113,16 @@ static int safe_usermode(int new_usermode, bool warn)
 	return new_usermode;
 }

+#ifdef CONFIG_PROC_FS
+static const char *usermode_action[] = {
+	"ignored",
+	"warn",
+	"fixup",
+	"fixup+warn",
+	"signal",
+	"signal+warn"
+};
+
 static int alignment_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "User:\t\t%lu\n", ai_user);
-- 
1.7.1
