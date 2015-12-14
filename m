From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Dec 2015 09:42:38 +0000
Subject: [PATCH 1/4] nvmem: core: return error for non word aligned access
In-Reply-To: <1450086024-18297-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1450086024-18297-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1450086158-18756-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nvmem providers have restrictions on register strides, so return error
when users attempt to read/write buffers with sizes which are less
than word size.

Without this patch the userspace would continue to try as it does not
get any error from the nvmem core, resulting in a hang or endless loop
in userspace.

Reported-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6fd4e5a..9d11d98 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -70,6 +70,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (pos >= nvmem->size)
 		return 0;
 
+	if (count < nvmem->word_size)
+		return -EINVAL;
+
 	if (pos + count > nvmem->size)
 		count = nvmem->size - pos;
 
@@ -95,6 +98,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (pos >= nvmem->size)
 		return 0;
 
+	if (count < nvmem->word_size)
+		return -EINVAL;
+
 	if (pos + count > nvmem->size)
 		count = nvmem->size - pos;
 
-- 
1.9.1
