From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 22:30:48 +0530
Subject: [PATCH 04/18] dmaengine: st_fdma: Add xp70 firmware loading
 mechanism.
In-Reply-To: <1461236675-10176-5-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-5-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160426170048.GS2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 12:04:21PM +0100, Peter Griffin wrote:
> +static int
> +st_fdma_elf_sanity_check(struct st_fdma_dev *fdev, const struct firmware *fw)
> +{
> +	const char *fw_name = fdev->fw_name;
> +	struct elf32_hdr *ehdr;
> +	char class;
> +
> +	if (!fw) {
> +		dev_err(fdev->dev, "failed to load %s\n", fw_name);
> +		return -EINVAL;
> +	}
> +
> +	if (fw->size < sizeof(*ehdr)) {
> +		dev_err(fdev->dev, "Image is too small\n");
> +		return -EINVAL;
> +	}
> +
> +	ehdr = (struct elf32_hdr *)fw->data;
> +
> +	/* We only support ELF32 at this point */
> +	class = ehdr->e_ident[EI_CLASS];
> +	if (class != ELFCLASS32) {
> +		dev_err(fdev->dev, "Unsupported class: %d\n", class);
> +		return -EINVAL;
> +	}
> +
> +	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB) {
> +		dev_err(fdev->dev, "Unsupported firmware endianness"
> +			"(%d) expected (%d)\n", ehdr->e_ident[EI_DATA],
> +			ELFDATA2LSB);
> +		return -EINVAL;
> +	}
> +
> +	if (fw->size < ehdr->e_shoff + sizeof(struct elf32_shdr)) {
> +		dev_err(fdev->dev, "Image is too small (%u)\n", fw->size);
> +		return -EINVAL;
> +	}
> +
> +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG)) {
> +		dev_err(fdev->dev, "Image is corrupted (bad magic)\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ehdr->e_phnum != fdev->drvdata->num_mem) {
> +		dev_err(fdev->dev, "spurious nb of segments (%d) expected (%d)"
> +			"\n", ehdr->e_phnum, fdev->drvdata->num_mem);
> +		return -EINVAL;
> +	}
> +
> +	if (ehdr->e_type != ET_EXEC) {
> +		dev_err(fdev->dev, "Unsupported ELF header type (%d) expected"
> +			" (%d)\n", ehdr->e_type, ET_EXEC);
> +		return -EINVAL;
> +	}
> +
> +	if (ehdr->e_machine != EM_SLIM) {
> +		dev_err(fdev->dev, "Unsupported ELF header machine (%d) "
> +			"expected (%d)\n", ehdr->e_machine, EM_SLIM);
> +		return -EINVAL;
> +	}
> +	if (ehdr->e_phoff > fw->size) {
> +		dev_err(fdev->dev, "Firmware size is too small\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +st_fdma_elf_load_segments(struct st_fdma_dev *fdev, const struct firmware *fw)
> +{
> +	struct device *dev = fdev->dev;
> +	struct elf32_hdr *ehdr;
> +	struct elf32_phdr *phdr;
> +	int i, mem_loaded = 0;
> +	const u8 *elf_data = fw->data;
> +
> +	ehdr = (struct elf32_hdr *)elf_data;
> +	phdr = (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
> +
> +	/*
> +	 * go through the available ELF segments
> +	 * the program header's paddr member to contain device addresses.
> +	 * We then go through the physically contiguous memory regions which we
> +	 * allocated (and mapped) earlier on the probe,
> +	 * and "translate" device address to kernel addresses,
> +	 * so we can copy the segments where they are expected.
> +	 */
> +	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
> +		u32 da = phdr->p_paddr;
> +		u32 memsz = phdr->p_memsz;
> +		u32 filesz = phdr->p_filesz;
> +		u32 offset = phdr->p_offset;
> +		void *dst;
> +
> +		if (phdr->p_type != PT_LOAD)
> +			continue;
> +
> +		dev_dbg(dev, "phdr: type %d da %#x ofst:%#x memsz %#x filesz %#x\n",
> +			phdr->p_type, da, offset, memsz, filesz);
> +
> +		if (filesz > memsz) {
> +			dev_err(dev, "bad phdr filesz 0x%x memsz 0x%x\n",
> +				filesz, memsz);
> +			break;
> +		}
> +
> +		if (offset + filesz > fw->size) {
> +			dev_err(dev, "truncated fw: need 0x%x avail 0x%zx\n",
> +				offset + filesz, fw->size);
> +			break;
> +		}
> +
> +		dst = st_fdma_seg_to_mem(fdev, da, memsz);
> +		if (!dst) {
> +			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
> +			break;
> +		}
> +
> +		if (phdr->p_filesz)
> +			memcpy(dst, elf_data + phdr->p_offset, filesz);
> +
> +		if (memsz > filesz)
> +			memset(dst + filesz, 0, memsz - filesz);
> +
> +		mem_loaded++;
> +	}
> +
> +	return (mem_loaded != fdev->drvdata->num_mem) ? -EIO : 0;
> +}

Above two seem to be generic code and should be moved to core, this way
other drivers using ELF firmware binaries can reuse...

> @@ -738,6 +925,15 @@ static int st_fdma_slave_config(struct dma_chan *chan,
>  				struct dma_slave_config *slave_cfg)
>  {
>  	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
> +	int ret;
> +
> +	if (!atomic_read(&fchan->fdev->fw_loaded)) {
> +		ret = st_fdma_get_fw(fchan->fdev);

this seems quite an odd place to load firmware, can you explain why

-- 
~Vinod
