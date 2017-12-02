From: david@lechnology.com (David Lechner)
Date: Fri,  1 Dec 2017 20:34:14 -0600
Subject: [PATCH v1 6/6] ARM: davinci: remove clock debugfs
In-Reply-To: <1512182054-17410-1-git-send-email-david@lechnology.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
Message-ID: <1512182054-17410-7-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removed the debugfs entry for mach-davinci clocks. The clocks now use
the common clock framework, which provides debugfs already, so this code is
redundant.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/clock.c | 79 -------------------------------------------
 1 file changed, 79 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 0e63d93..347902e 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -626,82 +626,3 @@ void __init davinci_clk_init(struct davinci_clk *clk, const char *con_id,
 	if (clk->flags & ALWAYS_ENABLED)
 		clk_prepare_enable(clk->hw.clk);
 }
-
-#ifdef CONFIG_DEBUG_FS
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-
-#define CLKNAME_MAX	10		/* longest clock name */
-#define NEST_DELTA	2
-#define NEST_MAX	4
-
-static void
-dump_clock(struct seq_file *s, unsigned nest, struct davinci_clk *parent)
-{
-	char		*state;
-	char		buf[CLKNAME_MAX + NEST_DELTA * NEST_MAX];
-	struct davinci_clk *clk;
-	unsigned	i;
-
-	if (parent->flags & CLK_PLL)
-		state = "pll";
-	else if (parent->flags & CLK_PSC)
-		state = "psc";
-	else
-		state = "";
-
-	/* <nest spaces> name <pad to end> */
-	memset(buf, ' ', sizeof(buf) - 1);
-	buf[sizeof(buf) - 1] = 0;
-	i = strlen(parent->name);
-	memcpy(buf + nest, parent->name,
-			min(i, (unsigned)(sizeof(buf) - 1 - nest)));
-
-	seq_printf(s, "%s users=%2d %-3s %9ld Hz\n",
-		   buf, parent->usecount, state, parent->rate);
-	/* REVISIT show device associations too */
-
-	/* cost is now small, but not linear... */
-	list_for_each_entry(clk, &parent->children, childnode) {
-		dump_clock(s, nest + NEST_DELTA, clk);
-	}
-}
-
-static int davinci_ck_show(struct seq_file *m, void *v)
-{
-	struct davinci_clk *clk;
-
-	/*
-	 * Show clock tree; We trust nonzero usecounts equate to PSC enables...
-	 */
-	mutex_lock(&clocks_mutex);
-	list_for_each_entry(clk, &clocks, node)
-		if (!clk->parent)
-			dump_clock(m, 0, clk);
-	mutex_unlock(&clocks_mutex);
-
-	return 0;
-}
-
-static int davinci_ck_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, davinci_ck_show, NULL);
-}
-
-static const struct file_operations davinci_ck_operations = {
-	.open		= davinci_ck_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init davinci_clk_debugfs_init(void)
-{
-	debugfs_create_file("davinci_clocks", S_IFREG | S_IRUGO, NULL, NULL,
-						&davinci_ck_operations);
-	return 0;
-
-}
-device_initcall(davinci_clk_debugfs_init);
-#endif /* CONFIG_DEBUG_FS */
-- 
2.7.4
