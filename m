From: mayhs11saini@gmail.com (Shyam Saini)
Date: Mon, 10 Oct 2016 07:06:59 +0530
Subject: [PATCH 1/1] mfd: Remove unused variable using Coccinelle
Message-ID: <1476063419-13866-1-git-send-email-mayhs11saini@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable err is initialized but never used otherwise.

The semantic patch that makes this change is as follows:

// <smpl>
@@
type T;
identifier i;
constant C;
@@

(
extern T i;
|
- T i;
  <+... when != i
- i = C;
  ...+>
)
// </smpl>

Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
---
 drivers/mfd/ab3100-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 6a5a988..3ebb2f0 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -584,8 +584,6 @@ static struct dentry *ab3100_set_reg_file;
 
 static void ab3100_setup_debugfs(struct ab3100 *ab3100)
 {
-	int err;
-
 	ab3100_dir = debugfs_create_dir("ab3100", NULL);
 	if (!ab3100_dir)
 		goto exit_no_debugfs;
@@ -594,7 +592,6 @@ static void ab3100_setup_debugfs(struct ab3100 *ab3100)
 				S_IRUGO, ab3100_dir, ab3100,
 				&ab3100_registers_fops);
 	if (!ab3100_reg_file) {
-		err = -ENOMEM;
 		goto exit_destroy_dir;
 	}
 
@@ -604,7 +601,6 @@ static void ab3100_setup_debugfs(struct ab3100 *ab3100)
 				S_IWUSR, ab3100_dir, &ab3100_get_priv,
 				&ab3100_get_set_reg_fops);
 	if (!ab3100_get_reg_file) {
-		err = -ENOMEM;
 		goto exit_destroy_reg;
 	}
 
@@ -614,7 +610,6 @@ static void ab3100_setup_debugfs(struct ab3100 *ab3100)
 				S_IWUSR, ab3100_dir, &ab3100_set_priv,
 				&ab3100_get_set_reg_fops);
 	if (!ab3100_set_reg_file) {
-		err = -ENOMEM;
 		goto exit_destroy_get_reg;
 	}
 	return;
-- 
2.7.4
