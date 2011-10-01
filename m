From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 21:21:53 +0200
Subject: [PATCH 04/11] ARM: allow building alignment.c without PROC_FS
In-Reply-To: <1317496920-7764-1-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
Message-ID: <1317496920-7764-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two functions cpu_is_v6_unaligned and safe_usermode
are only defined when CONFIG_PROC_FS is enabled, but
are used outside of the #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Martin <dave.martin@linaro.org>
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
1.7.5.4
