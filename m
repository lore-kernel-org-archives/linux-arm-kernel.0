From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:36:58 -0700
Subject: [PATCH v2 2/9] remoteproc: core: Make the loaded resource table
 optional
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-3-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Remote processors like the ones found in the Qualcomm SoCs does not have
a resource table passed to them, so make it optional by only populating
it if it does exist.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/remoteproc/remoteproc_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3d7d58a109d8..c04a786dc051 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -856,12 +856,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	 * copy this information to device memory.
 	 */
 	loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
-	if (!loaded_table) {
-		ret = -EINVAL;
-		goto clean_up;
-	}
-
-	memcpy(loaded_table, rproc->cached_table, tablesz);
+	if (loaded_table)
+		memcpy(loaded_table, rproc->cached_table, tablesz);
 
 	/* power up the remote processor */
 	ret = rproc->ops->start(rproc);
-- 
2.5.0
