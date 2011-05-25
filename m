From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 25 May 2011 23:57:26 +0200
Subject: [PATCH v4 05/12] mmc: mmc_test: add debugfs file to list all tests
In-Reply-To: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
References: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
Message-ID: <1306360653-6196-6-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a debugfs file "testlist" to print all available tests

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/card/mmc_test.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index abc1a63..1853ebf 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2447,6 +2447,32 @@ static const struct file_operations mmc_test_fops_test = {
 	.release	= single_release,
 };
 
+static int mtf_testlist_show(struct seq_file *sf, void *data)
+{
+	int i;
+
+	mutex_lock(&mmc_test_lock);
+
+	for (i = 0; i < ARRAY_SIZE(mmc_test_cases); i++)
+		seq_printf(sf, "%d:\t%s\n", i+1, mmc_test_cases[i].name);
+
+	mutex_unlock(&mmc_test_lock);
+
+	return 0;
+}
+
+static int mtf_testlist_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mtf_testlist_show, inode->i_private);
+}
+
+static const struct file_operations mmc_test_fops_testlist = {
+	.open		= mtf_testlist_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static void mmc_test_free_file_test(struct mmc_card *card)
 {
 	struct mmc_test_dbgfs_file *df, *dfs;
@@ -2478,7 +2504,18 @@ static int mmc_test_register_file_test(struct mmc_card *card)
 
 	if (IS_ERR_OR_NULL(file)) {
 		dev_err(&card->dev,
-			"Can't create file. Perhaps debugfs is disabled.\n");
+			"Can't create test. Perhaps debugfs is disabled.\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (card->debugfs_root)
+		file = debugfs_create_file("testlist", S_IRUGO,
+			card->debugfs_root, card, &mmc_test_fops_testlist);
+
+	if (IS_ERR_OR_NULL(file)) {
+		dev_err(&card->dev,
+			"Can't create testlist. Perhaps debugfs is disabled.\n");
 		ret = -ENODEV;
 		goto err;
 	}
-- 
1.7.4.1
