From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 23:33:48 +0100
Subject: [PATCH 12/13] ARM: OMAP3+: SmartReflex: fix the use of
 debugfs_create_* API
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Message-ID: <1330554829-11347-13-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debugfs_create_* API returns a return code or NULL
in the return ptr in case of problem.
Fix the smartreflex code to take this into account.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d0867b6..eaefb1a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -989,7 +989,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
 	if (!sr_dbg_dir) {
 		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
-		if (!sr_dbg_dir) {
+		if (IS_ERR_OR_NULL(sr_dbg_dir)) {
 			ret = PTR_ERR(sr_dbg_dir);
 			pr_err("%s:sr debugfs dir creation failed(%d)\n",
 				__func__, ret);
@@ -1006,7 +1006,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	}
 	sr_info->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
 	kfree(name);
-	if (IS_ERR(sr_info->dbg_dir)) {
+	if (IS_ERR_OR_NULL(sr_info->dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
 		ret = PTR_ERR(sr_info->dbg_dir);
@@ -1023,7 +1023,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			&sr_info->err_minlimit);
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
-	if (IS_ERR(nvalue_dir)) {
+	if (IS_ERR_OR_NULL(nvalue_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
 		ret = PTR_ERR(nvalue_dir);
-- 
1.7.5.4
