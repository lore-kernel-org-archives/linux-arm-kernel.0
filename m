From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:56 -0800
Subject: [PATCH 14/35] davinci: move /proc/davinci_clocks to debugfs
In-Reply-To: <1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Move /proc/davinci_clocks to /sys/kernel/debug/davinci_clocks
(debugfs).

debugfs is more suited for this since the clock dump is
debug information.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   42 ++++++++++------------------------------
 1 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index f7a04c2..e46a643 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -446,24 +446,10 @@ int __init davinci_clk_init(struct davinci_clk *clocks)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-
-static void *davinci_ck_start(struct seq_file *m, loff_t *pos)
-{
-	return *pos < 1 ? (void *)1 : NULL;
-}
-
-static void *davinci_ck_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	++*pos;
-	return NULL;
-}
+#ifdef CONFIG_DEBUG_FS
 
-static void davinci_ck_stop(struct seq_file *m, void *v)
-{
-}
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 #define CLKNAME_MAX	10		/* longest clock name */
 #define NEST_DELTA	2
@@ -518,30 +504,24 @@ static int davinci_ck_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static const struct seq_operations davinci_ck_op = {
-	.start	= davinci_ck_start,
-	.next	= davinci_ck_next,
-	.stop	= davinci_ck_stop,
-	.show	= davinci_ck_show
-};
-
 static int davinci_ck_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &davinci_ck_op);
+	return single_open(file, davinci_ck_show, NULL);
 }
 
-static const struct file_operations proc_davinci_ck_operations = {
+static const struct file_operations davinci_ck_operations = {
 	.open		= davinci_ck_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= single_release,
 };
 
-static int __init davinci_ck_proc_init(void)
+static int __init davinci_clk_debugfs_init(void)
 {
-	proc_create("davinci_clocks", 0, NULL, &proc_davinci_ck_operations);
+	debugfs_create_file("davinci_clocks", S_IFREG | S_IRUGO, NULL, NULL,
+						&davinci_ck_operations);
 	return 0;
 
 }
-__initcall(davinci_ck_proc_init);
-#endif /* CONFIG_DEBUG_PROC_FS */
+device_initcall(davinci_clk_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
-- 
1.6.6.rc2.1.g42108
