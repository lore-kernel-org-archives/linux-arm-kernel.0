From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Mon, 16 Nov 2015 14:11:55 -0300
Subject: [PATCH v3 0/4] Add support for NXP LPC18xx EEPROM using nvmem
In-Reply-To: <1447690798-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1447690798-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <564A0E5B.7090105@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


El 16/11/15 a las 13:19, Ariel D'Alessandro escribi?:
> This patch series adds support for NXP LPC18xx EEPROM memory found in
> NXP LPC185x/3x and LPC435x/3x/2x/1x devices.
> 
> This patchset is based on tag next-20151116 of the linux-next
> repository. It has been successfully tested on a LPC4337 CIAA-NXP
> Board.

Forgot to say that there's a known issue related to the nvmem core. It
will be solved when the following patch gets submitted and applied.

-------------------------------->cut<----------------------------------
>From 8cae10eff8ea8da9c5a8058ff75abeeddd8a8224 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 26 Oct 2015 13:30:24 +0000
Subject: [PATCH] nvmem: core: return error for non word aligned bytes

nvmem providers have restrictions on register strides, so return error
code when users attempt to read/write buffers with sizes which are not
aligned to the word boundary.

Without this patch the userspace would continue to try as it does not
get any error from the nvmem core, resulting in a hang.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6fd4e5a..9d11d98 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -70,6 +70,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp,
struct kobject *kobj,
     if (pos >= nvmem->size)
         return 0;

+    if (count < nvmem->word_size)
+        return -EINVAL;
+
     if (pos + count > nvmem->size)
         count = nvmem->size - pos;

@@ -95,6 +98,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp,
struct kobject *kobj,
     if (pos >= nvmem->size)
         return 0;

+    if (count < nvmem->word_size)
+        return -EINVAL;
+
     if (pos + count > nvmem->size)
         count = nvmem->size - pos;

-- 
1.9.1

-------------------------------->cut<----------------------------------

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
