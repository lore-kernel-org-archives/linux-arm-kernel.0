From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue,  6 Jun 2017 18:44:41 -0700
Subject: [PATCH] remoteproc: qcom: mdt_loader: Fix rproc_da_to_va
Message-ID: <1496799881-11097-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactoring MDT loader broke rproc_da_to_va() for Qualcomm images.  This
causes an incorrect computation of offset and returns an incorrect
virtual address for the relocatable segment(s).

Fix this by adding an "out" parameter to qcom_mdt_loader() and setting
the correct segment base address in that parameter.

Fixes: 7f0dd07a9b29 ("remoteproc: qcom: mdt_loader: Refactor MDT loader")
CC: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 drivers/remoteproc/qcom_adsp_pil.c  | 3 ++-
 drivers/remoteproc/qcom_wcnss.c     | 3 ++-
 drivers/soc/qcom/mdt_loader.c       | 5 ++++-
 include/linux/soc/qcom/mdt_loader.h | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
index 49fe2f8..335066e 100644
--- a/drivers/remoteproc/qcom_adsp_pil.c
+++ b/drivers/remoteproc/qcom_adsp_pil.c
@@ -79,7 +79,8 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
 
 	return qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
-			     adsp->mem_region, adsp->mem_phys, adsp->mem_size);
+			     adsp->mem_region, adsp->mem_phys,
+			     adsp->mem_size, &adsp->mem_reloc);
 }
 
 static const struct rproc_fw_ops adsp_fw_ops = {
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index a39a1a9..253f152e 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -153,7 +153,8 @@ static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
 
 	return qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
-			     wcnss->mem_region, wcnss->mem_phys, wcnss->mem_size);
+			     wcnss->mem_region, wcnss->mem_phys,
+			     wcnss->mem_size, &wcnss->mem_reloc);
 }
 
 static const struct rproc_fw_ops wcnss_fw_ops = {
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index bd63df0..b4a30fc 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -83,12 +83,13 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
  * @mem_region:	allocated memory region to load firmware into
  * @mem_phys:	physical address of allocated memory region
  * @mem_size:	size of the allocated memory region
+ * @img_base:   base address of the firmware image
  *
  * Returns 0 on success, negative errno otherwise.
  */
 int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		  const char *firmware, int pas_id, void *mem_region,
-		  phys_addr_t mem_phys, size_t mem_size)
+		  phys_addr_t mem_phys, size_t mem_size, phys_addr_t *img_base)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
@@ -193,6 +194,8 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			memset(ptr + phdr->p_filesz, 0, phdr->p_memsz - phdr->p_filesz);
 	}
 
+	if (img_base)
+		*img_base = mem_reloc;
 out:
 	kfree(fw_name);
 
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index f423001..ea021b3 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -13,6 +13,6 @@
 ssize_t qcom_mdt_get_size(const struct firmware *fw);
 int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		  const char *fw_name, int pas_id, void *mem_region,
-		  phys_addr_t mem_phys, size_t mem_size);
+		  phys_addr_t mem_phys, size_t mem_size, phys_addr_t *img_base);
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
