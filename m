From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 16 Dec 2013 14:11:58 +0800
Subject: [PATCH -next] mmc: s3cmci: fix return value check in
 s3cmci_debugfs_attach()
Message-ID: <CAPgLHd_RRUvHocV8nziQUcfQrBsN3ApzFu5+CDdz3ruDiiB50w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function debugfs_create_*() returns NULL
pointer not ERR_PTR() if debugfs is enabled. The IS_ERR() test
in the return value check should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/s3cmci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 2fce5ea..ca6e30f 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1586,7 +1586,7 @@ static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 	struct device *dev = &host->pdev->dev;
 
 	host->debug_root = debugfs_create_dir(dev_name(dev), NULL);
-	if (IS_ERR(host->debug_root)) {
+	if (!host->debug_root) {
 		dev_err(dev, "failed to create debugfs root\n");
 		return;
 	}
@@ -1595,14 +1595,14 @@ static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 						host->debug_root, host,
 						&s3cmci_fops_state);
 
-	if (IS_ERR(host->debug_state))
+	if (!host->debug_state)
 		dev_err(dev, "failed to create debug state file\n");
 
 	host->debug_regs = debugfs_create_file("regs", 0444,
 					       host->debug_root, host,
 					       &s3cmci_fops_regs);
 
-	if (IS_ERR(host->debug_regs))
+	if (!host->debug_regs)
 		dev_err(dev, "failed to create debug regs file\n");
 }
 
