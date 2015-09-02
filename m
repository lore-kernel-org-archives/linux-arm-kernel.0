From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:45 -0700
Subject: [PATCH v2 2/8] soc: qcom: smem: Handle big endian CPUs
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1441234011-4259-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The contents of smem are always in little endian, but the smem
driver is not capable of being used on big endian CPUs. Annotate
the little endian data members and update the code to do the
proper byte swapping.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v1:
 * Rebased on top of qcom_smem_get() returning a pointer

 drivers/soc/qcom/smem.c | 229 +++++++++++++++++++++++++++++-------------------
 1 file changed, 138 insertions(+), 91 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e6d0dae63845..74017114ce6e 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -92,9 +92,9 @@
   * @params:	parameters to the command
   */
 struct smem_proc_comm {
-	u32 command;
-	u32 status;
-	u32 params[2];
+	__le32 command;
+	__le32 status;
+	__le32 params[2];
 };
 
 /**
@@ -106,10 +106,10 @@ struct smem_proc_comm {
  *		the default region. bits 0,1 are reserved
  */
 struct smem_global_entry {
-	u32 allocated;
-	u32 offset;
-	u32 size;
-	u32 aux_base; /* bits 1:0 reserved */
+	__le32 allocated;
+	__le32 offset;
+	__le32 size;
+	__le32 aux_base; /* bits 1:0 reserved */
 };
 #define AUX_BASE_MASK		0xfffffffc
 
@@ -125,11 +125,11 @@ struct smem_global_entry {
  */
 struct smem_header {
 	struct smem_proc_comm proc_comm[4];
-	u32 version[32];
-	u32 initialized;
-	u32 free_offset;
-	u32 available;
-	u32 reserved;
+	__le32 version[32];
+	__le32 initialized;
+	__le32 free_offset;
+	__le32 available;
+	__le32 reserved;
 	struct smem_global_entry toc[SMEM_ITEM_COUNT];
 };
 
@@ -143,12 +143,12 @@ struct smem_header {
  * @reserved:	reserved entries for later use
  */
 struct smem_ptable_entry {
-	u32 offset;
-	u32 size;
-	u32 flags;
-	u16 host0;
-	u16 host1;
-	u32 reserved[8];
+	__le32 offset;
+	__le32 size;
+	__le32 flags;
+	__le16 host0;
+	__le16 host1;
+	__le32 reserved[8];
 };
 
 /**
@@ -160,13 +160,14 @@ struct smem_ptable_entry {
  * @entry:	list of @smem_ptable_entry for the @num_entries partitions
  */
 struct smem_ptable {
-	u32 magic;
-	u32 version;
-	u32 num_entries;
-	u32 reserved[5];
+	u8 magic[4];
+	__le32 version;
+	__le32 num_entries;
+	__le32 reserved[5];
 	struct smem_ptable_entry entry[];
 };
-#define SMEM_PTABLE_MAGIC	0x434f5424 /* "$TOC" */
+
+static const u8 SMEM_PTABLE_MAGIC[] = { 0x24, 0x54, 0x4f, 0x43 }; /* "$TOC" */
 
 /**
  * struct smem_partition_header - header of the partitions
@@ -181,15 +182,16 @@ struct smem_ptable {
  * @reserved:	for now reserved entries
  */
 struct smem_partition_header {
-	u32 magic;
-	u16 host0;
-	u16 host1;
-	u32 size;
-	u32 offset_free_uncached;
-	u32 offset_free_cached;
-	u32 reserved[3];
+	u8 magic[4];
+	__le16 host0;
+	__le16 host1;
+	__le32 size;
+	__le32 offset_free_uncached;
+	__le32 offset_free_cached;
+	__le32 reserved[3];
 };
-#define SMEM_PART_MAGIC		0x54525024 /* "$PRT" */
+
+static const u8 SMEM_PART_MAGIC[] = { 0x24, 0x50, 0x52, 0x54 };
 
 /**
  * struct smem_private_entry - header of each item in the private partition
@@ -201,12 +203,12 @@ struct smem_partition_header {
  * @reserved:	for now reserved entry
  */
 struct smem_private_entry {
-	u16 canary;
-	u16 item;
-	u32 size; /* includes padding bytes */
-	u16 padding_data;
-	u16 padding_hdr;
-	u32 reserved;
+	u16 canary; /* bytes are the same so no swapping needed */
+	__le16 item;
+	__le32 size; /* includes padding bytes */
+	__le16 padding_data;
+	__le16 padding_hdr;
+	__le32 reserved;
 };
 #define SMEM_PRIVATE_CANARY	0xa5a5
 
@@ -242,6 +244,45 @@ struct qcom_smem {
 	struct smem_region regions[0];
 };
 
+static struct smem_private_entry *
+phdr_to_last_private_entry(struct smem_partition_header *phdr)
+{
+	void *p = phdr;
+
+	return p + le32_to_cpu(phdr->offset_free_uncached);
+}
+
+static void *phdr_to_first_cached_entry(struct smem_partition_header *phdr)
+{
+	void *p = phdr;
+
+	return p + le32_to_cpu(phdr->offset_free_cached);
+}
+
+static struct smem_private_entry *
+phdr_to_first_private_entry(struct smem_partition_header *phdr)
+{
+	void *p = phdr;
+
+	return p + sizeof(*phdr);
+}
+
+static struct smem_private_entry *
+private_entry_next(struct smem_private_entry *e)
+{
+	void *p = e;
+
+	return p + sizeof(*e) + le16_to_cpu(e->padding_hdr) +
+	       le32_to_cpu(e->size);
+}
+
+static void *entry_to_item(struct smem_private_entry *e)
+{
+	void *p = e;
+
+	return p + sizeof(*e) + le16_to_cpu(e->padding_hdr);
+}
+
 /* Pointer to the one and only smem handle */
 static struct qcom_smem *__smem;
 
@@ -254,16 +295,16 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 				   size_t size)
 {
 	struct smem_partition_header *phdr;
-	struct smem_private_entry *hdr;
+	struct smem_private_entry *hdr, *end;
 	size_t alloc_size;
-	void *p;
+	void *cached;
 
 	phdr = smem->partitions[host];
+	hdr = phdr_to_first_private_entry(phdr);
+	end = phdr_to_last_private_entry(phdr);
+	cached = phdr_to_first_cached_entry(phdr);
 
-	p = (void *)phdr + sizeof(*phdr);
-	while (p < (void *)phdr + phdr->offset_free_uncached) {
-		hdr = p;
-
+	while (hdr < end) {
 		if (hdr->canary != SMEM_PRIVATE_CANARY) {
 			dev_err(smem->dev,
 				"Found invalid canary in host %d partition\n",
@@ -271,24 +312,23 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (hdr->item == item)
+		if (le16_to_cpu(hdr->item) == item)
 			return -EEXIST;
 
-		p += sizeof(*hdr) + hdr->padding_hdr + hdr->size;
+		hdr = private_entry_next(hdr);
 	}
 
 	/* Check that we don't grow into the cached region */
 	alloc_size = sizeof(*hdr) + ALIGN(size, 8);
-	if (p + alloc_size >= (void *)phdr + phdr->offset_free_cached) {
+	if ((void *)hdr + alloc_size >= cached) {
 		dev_err(smem->dev, "Out of memory\n");
 		return -ENOSPC;
 	}
 
-	hdr = p;
 	hdr->canary = SMEM_PRIVATE_CANARY;
-	hdr->item = item;
-	hdr->size = ALIGN(size, 8);
-	hdr->padding_data = hdr->size - size;
+	hdr->item = cpu_to_le16(item);
+	hdr->size = cpu_to_le32(ALIGN(size, 8));
+	hdr->padding_data = cpu_to_le16(le32_to_cpu(hdr->size) - size);
 	hdr->padding_hdr = 0;
 
 	/*
@@ -297,7 +337,7 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	 * gets a consistent view of the linked list.
 	 */
 	wmb();
-	phdr->offset_free_uncached += alloc_size;
+	le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
 
 	return 0;
 }
@@ -318,11 +358,11 @@ static int qcom_smem_alloc_global(struct qcom_smem *smem,
 		return -EEXIST;
 
 	size = ALIGN(size, 8);
-	if (WARN_ON(size > header->available))
+	if (WARN_ON(size > le32_to_cpu(header->available)))
 		return -ENOMEM;
 
 	entry->offset = header->free_offset;
-	entry->size = size;
+	entry->size = cpu_to_le32(size);
 
 	/*
 	 * Ensure the header is consistent before we mark the item allocated,
@@ -330,10 +370,10 @@ static int qcom_smem_alloc_global(struct qcom_smem *smem,
 	 * even though they do not take the spinlock on read.
 	 */
 	wmb();
-	entry->allocated = 1;
+	entry->allocated = cpu_to_le32(1);
 
-	header->free_offset += size;
-	header->available -= size;
+	le32_add_cpu(&header->free_offset, size);
+	le32_add_cpu(&header->available, -size);
 
 	return 0;
 }
@@ -396,15 +436,15 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 	if (!entry->allocated)
 		return ERR_PTR(-ENXIO);
 
-	aux_base = entry->aux_base & AUX_BASE_MASK;
+	aux_base = le32_to_cpu(entry->aux_base) & AUX_BASE_MASK;
 
 	for (i = 0; i < smem->num_regions; i++) {
 		area = &smem->regions[i];
 
 		if (area->aux_base == aux_base || !aux_base) {
 			if (size != NULL)
-				*size = entry->size;
-			return area->virt_base + entry->offset;
+				*size = le32_to_cpu(entry->size);
+			return area->virt_base + le32_to_cpu(entry->offset);
 		}
 	}
 
@@ -417,30 +457,29 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 				   size_t *size)
 {
 	struct smem_partition_header *phdr;
-	struct smem_private_entry *hdr;
-	void *p;
+	struct smem_private_entry *e, *end;
 
 	phdr = smem->partitions[host];
+	e = phdr_to_first_private_entry(phdr);
+	end = phdr_to_last_private_entry(phdr);
 
-	p = (void *)phdr + sizeof(*phdr);
-	while (p < (void *)phdr + phdr->offset_free_uncached) {
-		hdr = p;
-
-		if (hdr->canary != SMEM_PRIVATE_CANARY) {
+	while (e < end) {
+		if (e->canary != SMEM_PRIVATE_CANARY) {
 			dev_err(smem->dev,
 				"Found invalid canary in host %d partition\n",
 				host);
 			return ERR_PTR(-EINVAL);
 		}
 
-		if (hdr->item == item) {
+		if (le16_to_cpu(e->item) == item) {
 			if (size != NULL)
-				*size = hdr->size - hdr->padding_data;
+				*size = le32_to_cpu(e->size) -
+					le16_to_cpu(e->padding_data);
 
-			return p + sizeof(*hdr) + hdr->padding_hdr;
+			return entry_to_item(e);
 		}
 
-		p += sizeof(*hdr) + hdr->padding_hdr + hdr->size;
+		e = private_entry_next(e);
 	}
 
 	return ERR_PTR(-ENOENT);
@@ -500,10 +539,11 @@ int qcom_smem_get_free_space(unsigned host)
 
 	if (host < SMEM_HOST_COUNT && __smem->partitions[host]) {
 		phdr = __smem->partitions[host];
-		ret = phdr->offset_free_cached - phdr->offset_free_uncached;
+		ret = le32_to_cpu(phdr->offset_free_cached) -
+		      le32_to_cpu(phdr->offset_free_uncached);
 	} else {
 		header = __smem->regions[0].virt_base;
-		ret = header->available;
+		ret = le32_to_cpu(header->available);
 	}
 
 	return ret;
@@ -512,7 +552,7 @@ EXPORT_SYMBOL(qcom_smem_get_free_space);
 
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
-	unsigned *versions;
+	__le32 *versions;
 	size_t size;
 
 	versions = qcom_smem_get_global(smem, SMEM_ITEM_VERSION, &size);
@@ -526,7 +566,7 @@ static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	return versions[SMEM_MASTER_SBL_VERSION_INDEX];
+	return le32_to_cpu(versions[SMEM_MASTER_SBL_VERSION_INDEX]);
 }
 
 static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
@@ -536,35 +576,38 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
 	unsigned remote_host;
+	u32 version, host0, host1;
 	int i;
 
 	ptable = smem->regions[0].virt_base + smem->regions[0].size - SZ_4K;
-	if (ptable->magic != SMEM_PTABLE_MAGIC)
+	if (memcmp(ptable->magic, SMEM_PTABLE_MAGIC, sizeof(ptable->magic)))
 		return 0;
 
-	if (ptable->version != 1) {
+	version = le32_to_cpu(ptable->version);
+	if (version != 1) {
 		dev_err(smem->dev,
-			"Unsupported partition header version %d\n",
-			ptable->version);
+			"Unsupported partition header version %d\n", version);
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ptable->num_entries; i++) {
+	for (i = 0; i < le32_to_cpu(ptable->num_entries); i++) {
 		entry = &ptable->entry[i];
+		host0 = le16_to_cpu(entry->host0);
+		host1 = le16_to_cpu(entry->host1);
 
-		if (entry->host0 != local_host && entry->host1 != local_host)
+		if (host0 != local_host && host1 != local_host)
 			continue;
 
-		if (!entry->offset)
+		if (!le32_to_cpu(entry->offset))
 			continue;
 
-		if (!entry->size)
+		if (!le32_to_cpu(entry->size))
 			continue;
 
-		if (entry->host0 == local_host)
-			remote_host = entry->host1;
+		if (host0 == local_host)
+			remote_host = host1;
 		else
-			remote_host = entry->host0;
+			remote_host = host0;
 
 		if (remote_host >= SMEM_HOST_COUNT) {
 			dev_err(smem->dev,
@@ -580,21 +623,24 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		header = smem->regions[0].virt_base + entry->offset;
+		header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
+		host0 = le16_to_cpu(header->host0);
+		host1 = le16_to_cpu(header->host1);
 
-		if (header->magic != SMEM_PART_MAGIC) {
+		if (memcmp(header->magic, SMEM_PART_MAGIC,
+			    sizeof(header->magic))) {
 			dev_err(smem->dev,
 				"Partition %d has invalid magic\n", i);
 			return -EINVAL;
 		}
 
-		if (header->host0 != local_host && header->host1 != local_host) {
+		if (host0 != local_host && host1 != local_host) {
 			dev_err(smem->dev,
 				"Partition %d hosts are invalid\n", i);
 			return -EINVAL;
 		}
 
-		if (header->host0 != remote_host && header->host1 != remote_host) {
+		if (host0 != remote_host && host1 != remote_host) {
 			dev_err(smem->dev,
 				"Partition %d hosts are invalid\n", i);
 			return -EINVAL;
@@ -606,7 +652,7 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (header->offset_free_uncached > header->size) {
+		if (le32_to_cpu(header->offset_free_uncached) > le32_to_cpu(header->size)) {
 			dev_err(smem->dev,
 				"Partition %d has invalid free pointer\n", i);
 			return -EINVAL;
@@ -690,7 +736,8 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	}
 
 	header = smem->regions[0].virt_base;
-	if (header->initialized != 1 || header->reserved) {
+	if (le32_to_cpu(header->initialized) != 1 ||
+	    le32_to_cpu(header->reserved)) {
 		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
 		return -EINVAL;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
