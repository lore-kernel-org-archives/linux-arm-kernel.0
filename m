From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 17 Oct 2016 16:23:35 +0000
Subject: [PATCH -next] remoteproc: st: Fix error return code in
 st_rproc_probe()
Message-ID: <1476721415-20224-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return a negative error code from the st_rproc_state() error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/remoteproc/st_remoteproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index ae8963f..da4e152 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -245,8 +245,10 @@ static int st_rproc_probe(struct platform_device *pdev)
 		goto free_rproc;
 
 	enabled = st_rproc_state(pdev);
-	if (enabled < 0)
+	if (enabled < 0) {
+		ret = enabled;
 		goto free_rproc;
+	}
 
 	if (enabled) {
 		atomic_inc(&rproc->power);
