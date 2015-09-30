From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:33:56 +0100
Subject: [PATCH 1/4] nvmem: core: fix the out-of-range leak in read/write()
In-Reply-To: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1443616436-17565-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ZhengShunQian <zhengsq@rock-chips.com>

The position to read/write must be less than max
register size.

Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d3c6676..f4af8e5 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -67,7 +67,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	int rc;
 
 	/* Stop the user from reading */
-	if (pos > nvmem->size)
+	if (pos >= nvmem->size)
 		return 0;
 
 	if (pos + count > nvmem->size)
@@ -92,7 +92,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	int rc;
 
 	/* Stop the user from writing */
-	if (pos > nvmem->size)
+	if (pos >= nvmem->size)
 		return 0;
 
 	if (pos + count > nvmem->size)
-- 
1.9.1
