From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 21 Apr 2016 12:04:21 +0100
Subject: [PATCH 04/18] dmaengine: st_fdma: Add xp70 firmware loading mechanism.
In-Reply-To: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1461236675-10176-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the code to load the xp70 fdma firmware
using the asynchronous request_firmware_nowait call
so as not to delay bootup of builtin code.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/st_fdma.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 9bf0100..5fcaf10 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -83,6 +83,162 @@ static struct st_fdma_desc *to_st_fdma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct st_fdma_desc, vdesc);
 }
 
+static void *st_fdma_seg_to_mem(struct st_fdma_dev *fdev, u64 da, int len)
+{
+	int i;
+	resource_size_t base = fdev->io_res->start;
+	const struct st_fdma_ram *fdma_mem = fdev->drvdata->fdma_mem;
+	void *ptr = NULL;
+
+	for (i = 0; i < fdev->drvdata->num_mem; i++) {
+		int mem_off = da - (base + fdma_mem[i].offset);
+
+		/* next mem if da is too small */
+		if (mem_off < 0)
+			continue;
+
+		/* next mem if da is too large */
+		if (mem_off + len > fdma_mem[i].size)
+			continue;
+
+		ptr = fdev->io_base + fdma_mem[i].offset + mem_off;
+		break;
+	}
+
+	return ptr;
+}
+
+static int
+st_fdma_elf_sanity_check(struct st_fdma_dev *fdev, const struct firmware *fw)
+{
+	const char *fw_name = fdev->fw_name;
+	struct elf32_hdr *ehdr;
+	char class;
+
+	if (!fw) {
+		dev_err(fdev->dev, "failed to load %s\n", fw_name);
+		return -EINVAL;
+	}
+
+	if (fw->size < sizeof(*ehdr)) {
+		dev_err(fdev->dev, "Image is too small\n");
+		return -EINVAL;
+	}
+
+	ehdr = (struct elf32_hdr *)fw->data;
+
+	/* We only support ELF32 at this point */
+	class = ehdr->e_ident[EI_CLASS];
+	if (class != ELFCLASS32) {
+		dev_err(fdev->dev, "Unsupported class: %d\n", class);
+		return -EINVAL;
+	}
+
+	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB) {
+		dev_err(fdev->dev, "Unsupported firmware endianness"
+			"(%d) expected (%d)\n", ehdr->e_ident[EI_DATA],
+			ELFDATA2LSB);
+		return -EINVAL;
+	}
+
+	if (fw->size < ehdr->e_shoff + sizeof(struct elf32_shdr)) {
+		dev_err(fdev->dev, "Image is too small (%u)\n", fw->size);
+		return -EINVAL;
+	}
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG)) {
+		dev_err(fdev->dev, "Image is corrupted (bad magic)\n");
+		return -EINVAL;
+	}
+
+	if (ehdr->e_phnum != fdev->drvdata->num_mem) {
+		dev_err(fdev->dev, "spurious nb of segments (%d) expected (%d)"
+			"\n", ehdr->e_phnum, fdev->drvdata->num_mem);
+		return -EINVAL;
+	}
+
+	if (ehdr->e_type != ET_EXEC) {
+		dev_err(fdev->dev, "Unsupported ELF header type (%d) expected"
+			" (%d)\n", ehdr->e_type, ET_EXEC);
+		return -EINVAL;
+	}
+
+	if (ehdr->e_machine != EM_SLIM) {
+		dev_err(fdev->dev, "Unsupported ELF header machine (%d) "
+			"expected (%d)\n", ehdr->e_machine, EM_SLIM);
+		return -EINVAL;
+	}
+	if (ehdr->e_phoff > fw->size) {
+		dev_err(fdev->dev, "Firmware size is too small\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+st_fdma_elf_load_segments(struct st_fdma_dev *fdev, const struct firmware *fw)
+{
+	struct device *dev = fdev->dev;
+	struct elf32_hdr *ehdr;
+	struct elf32_phdr *phdr;
+	int i, mem_loaded = 0;
+	const u8 *elf_data = fw->data;
+
+	ehdr = (struct elf32_hdr *)elf_data;
+	phdr = (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
+
+	/*
+	 * go through the available ELF segments
+	 * the program header's paddr member to contain device addresses.
+	 * We then go through the physically contiguous memory regions which we
+	 * allocated (and mapped) earlier on the probe,
+	 * and "translate" device address to kernel addresses,
+	 * so we can copy the segments where they are expected.
+	 */
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
+		u32 da = phdr->p_paddr;
+		u32 memsz = phdr->p_memsz;
+		u32 filesz = phdr->p_filesz;
+		u32 offset = phdr->p_offset;
+		void *dst;
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		dev_dbg(dev, "phdr: type %d da %#x ofst:%#x memsz %#x filesz %#x\n",
+			phdr->p_type, da, offset, memsz, filesz);
+
+		if (filesz > memsz) {
+			dev_err(dev, "bad phdr filesz 0x%x memsz 0x%x\n",
+				filesz, memsz);
+			break;
+		}
+
+		if (offset + filesz > fw->size) {
+			dev_err(dev, "truncated fw: need 0x%x avail 0x%zx\n",
+				offset + filesz, fw->size);
+			break;
+		}
+
+		dst = st_fdma_seg_to_mem(fdev, da, memsz);
+		if (!dst) {
+			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
+			break;
+		}
+
+		if (phdr->p_filesz)
+			memcpy(dst, elf_data + phdr->p_offset, filesz);
+
+		if (memsz > filesz)
+			memset(dst + filesz, 0, memsz - filesz);
+
+		mem_loaded++;
+	}
+
+	return (mem_loaded != fdev->drvdata->num_mem) ? -EIO : 0;
+}
+
 static void st_fdma_enable(struct st_fdma_dev *fdev)
 {
 	unsigned long hw_id, hw_ver, fw_rev;
@@ -125,6 +281,37 @@ static int st_fdma_disable(struct st_fdma_dev *fdev)
 	return readl(fdev->io_base + FDMA_EN_OFST);
 }
 
+static int st_fdma_get_fw(struct st_fdma_dev *fdev)
+{
+	const struct firmware *fw;
+	int ret;
+
+	atomic_set(&fdev->fw_loaded, 0);
+
+	dev_info(fdev->dev, "Loading firmware: %s\n", fdev->fw_name);
+
+	ret = request_firmware(&fw, fdev->fw_name, fdev->dev);
+	if (ret) {
+		dev_err(fdev->dev, "request_firmware err: %d\n", ret);
+		return ret;
+	}
+
+	ret = st_fdma_elf_sanity_check(fdev, fw);
+	if (ret)
+		goto out;
+
+	st_fdma_disable(fdev);
+	ret = st_fdma_elf_load_segments(fdev, fw);
+	if (ret)
+		goto out;
+
+	st_fdma_enable(fdev);
+	atomic_set(&fdev->fw_loaded, 1);
+out:
+	release_firmware(fw);
+	return ret;
+}
+
 static int st_fdma_dreq_get(struct st_fdma_chan *fchan)
 {
 	struct st_fdma_dev *fdev = fchan->fdev;
@@ -738,6 +925,15 @@ static int st_fdma_slave_config(struct dma_chan *chan,
 				struct dma_slave_config *slave_cfg)
 {
 	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
+	int ret;
+
+	if (!atomic_read(&fchan->fdev->fw_loaded)) {
+		ret = st_fdma_get_fw(fchan->fdev);
+		if (ret)
+			dev_err(fchan->fdev->dev, "%s: fdma fw load failed\n"
+				, __func__);
+	}
+
 	memcpy(&fchan->scfg, slave_cfg, sizeof(fchan->scfg));
 	return 0;
 }
-- 
1.9.1
