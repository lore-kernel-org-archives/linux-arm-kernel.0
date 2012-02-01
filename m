From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed,  1 Feb 2012 09:37:31 +0100
Subject: [PATCH] ARM: OMAP2+: PM debug: fix the use of debugfs_create_* API
In-Reply-To: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
References: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
Message-ID: <1328085451-23225-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check the return code pointer value from debugfs_create_dir for error
or NULL.
Also added an additional check to prevent the creation of a 'suspend'
entry at the debugfs root in case a power domain directory cannot be
created.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 4411163..814bcd9 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -220,8 +220,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 		return 0;
 
 	d = debugfs_create_dir(pwrdm->name, (struct dentry *)dir);
-
-	(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d,
+	if (!(IS_ERR_OR_NULL(d)))
+		(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d,
 			(void *)pwrdm, &pwrdm_suspend_fops);
 
 	return 0;
@@ -264,7 +264,7 @@ static int __init pm_dbg_init(void)
 		return 0;
 
 	d = debugfs_create_dir("pm_debug", NULL);
-	if (IS_ERR(d))
+	if (IS_ERR_OR_NULL(d))
 		return PTR_ERR(d);
 
 	(void) debugfs_create_file("count", S_IRUGO,
-- 
1.7.5.4
