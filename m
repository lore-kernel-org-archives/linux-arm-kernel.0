From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  1 Sep 2015 11:48:14 +0100
Subject: [PATCH v4 6/6] [media] c8sectpfe: Simplify for loop in
 load_slim_core_fw
In-Reply-To: <1441104494-10468-1-git-send-email-peter.griffin@linaro.org>
References: <1441104494-10468-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441104494-10468-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index e19c6b4..782174a 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -1096,7 +1096,7 @@ static int load_slim_core_fw(const struct firmware *fw, void *context)
 	Elf32_Ehdr *ehdr;
 	Elf32_Phdr *phdr;
 	u8 __iomem *dst;
-	int err, i;
+	int err = 0, i;
 
 	if (!fw || !context)
 		return -EINVAL;
@@ -1105,7 +1105,7 @@ static int load_slim_core_fw(const struct firmware *fw, void *context)
 	phdr = (Elf32_Phdr *)(fw->data + ehdr->e_phoff);
 
 	/* go through the available ELF segments */
-	for (i = 0; i < ehdr->e_phnum && !err; i++, phdr++) {
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
 
 		/* Only consider LOAD segments */
 		if (phdr->p_type != PT_LOAD)
@@ -1118,7 +1118,7 @@ static int load_slim_core_fw(const struct firmware *fw, void *context)
 			dev_err(fei->dev,
 				"Segment %d is outside of firmware file\n", i);
 			err = -EINVAL;
-			break;
+			goto err;
 		}
 
 		/*
@@ -1146,6 +1146,7 @@ static int load_slim_core_fw(const struct firmware *fw, void *context)
 		}
 	}
 
+err:
 	release_firmware(fw);
 	return err;
 }
-- 
1.9.1
