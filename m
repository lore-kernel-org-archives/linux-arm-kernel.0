From: wufan@codeaurora.org (Fan Wu)
Date: Tue,  4 Sep 2018 03:50:55 +0000
Subject: [PATCH v3] EDAC, ghes: use CPER module handles to locate DIMMs
Message-ID: <1536033055-25522-1-git-send-email-wufan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For platforms whose firmwares provide valid module handles
(SMBIOS type 17) in error records, this patch uses the module
handles to locate corresponding DIMMs and enables per-DIMM
error counter update.

Signed-off-by: Fan Wu <wufan@codeaurora.org>
Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
Tested-by: Toshi Kani <toshi.kani@hpe.com>
Reviewed-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: tanxiaofei <tanxiaofei@huawei.com>
---

Changes from v2:
* Fixed coding style glitch
* Added Tested-by/Reviewed-by

Changes from v1:
*  Changed the new function name to get_dimm_smbios_index
*  Removed unnecessary checks inside get_dimm_smbios_index
*  Reverted the change of the DMI handle print
*  Updated commit message

---
 drivers/edac/ghes_edac.c | 23 +++++++++++++++++++++++
 include/linux/edac.h     |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 473aeec..ba46160 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -81,6 +81,18 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
+static int get_dimm_smbios_index(u16 handle)
+{
+	int i;
+	struct mem_ctl_info *mci = ghes_pvt->mci;
+
+	for (i = 0; i < mci->tot_dimms; i++) {
+		if (mci->dimms[i]->smbios_handle == handle)
+			return i;
+	}
+	return -1;
+}
+
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 {
 	struct ghes_edac_dimm_fill *dimm_fill = arg;
@@ -177,6 +189,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 				entry->total_width, entry->data_width);
 		}
 
+		dimm->smbios_handle = entry->handle;
+
 		dimm_fill->count++;
 	}
 }
@@ -327,12 +341,21 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		const char *bank = NULL, *device = NULL;
+		int index = -1;
+
 		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
 		if (bank != NULL && device != NULL)
 			p += sprintf(p, "DIMM location:%s %s ", bank, device);
 		else
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
+
+		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
+		if (index >= 0) {
+			e->top_layer = index;
+			e->enable_per_layer_report = true;
+		}
+
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
diff --git a/include/linux/edac.h b/include/linux/edac.h
index bffb978..a45ce1f 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -451,6 +451,8 @@ struct dimm_info {
 	u32 nr_pages;			/* number of pages on this dimm */
 
 	unsigned csrow, cschannel;	/* Points to the old API data */
+
+	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
 };
 
 /**
-- 
2.7.4
