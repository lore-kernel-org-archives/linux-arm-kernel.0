From: alex.elder@linaro.org (Alex Elder)
Date: Mon, 09 Sep 2013 18:20:23 -0500
Subject: [PATCH] clk: clean up everything on debugfs error
Message-ID: <522E57B7.6010603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_COMMON_CLK_DEBUG is defined, clk_debug_create_one() is
called to populate a debugfs directory with a few entries that are
common for all clock types.

If an error happens after creating the first one debugfs_remove() is
called on the clock's directory.  The problem with this is that no
cleanup is done on the debugfs files already created in that
directory, so the directory never actually gets removed.   This
problem is silently ignored.

Fix this by calling debugfs_remove_recursive() instead.  Reset the
clk->dentry field to null afterward, to ensure it can't be mistaken
as a valid pointer.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/clk/clk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 54a191c..727ae7b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -272,7 +272,8 @@ static int clk_debug_create_one(struct clk *clk,
struct dentry *pdentry)
 	goto out;

 err_out:
-	debugfs_remove(clk->dentry);
+	debugfs_remove_recursive(clk->dentry);
+	clk->dentry = NULL;
 out:
 	return ret;
 }
-- 
1.7.9.5
