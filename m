From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 11 May 2016 08:57:40 +0100
Subject: [PATCH 04/18] dmaengine: st_fdma: Add xp70 firmware loading
 mechanism.
In-Reply-To: <20160426170048.GS2274@localhost>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-5-git-send-email-peter.griffin@linaro.org>
 <20160426170048.GS2274@localhost>
Message-ID: <20160511075740.GB25540@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Tue, 26 Apr 2016, Vinod Koul wrote:

> On Thu, Apr 21, 2016 at 12:04:21PM +0100, Peter Griffin wrote:
> > +static int
> > +st_fdma_elf_sanity_check(struct st_fdma_dev *fdev, const struct firmware *fw)
> > +{
> > +	const char *fw_name = fdev->fw_name;
> > +	struct elf32_hdr *ehdr;
> > +	char class;
> > +
> > +	if (!fw) {
> > +		dev_err(fdev->dev, "failed to load %s\n", fw_name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fw->size < sizeof(*ehdr)) {
> > +		dev_err(fdev->dev, "Image is too small\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ehdr = (struct elf32_hdr *)fw->data;
> > +
> > +	/* We only support ELF32 at this point */
> > +	class = ehdr->e_ident[EI_CLASS];
> > +	if (class != ELFCLASS32) {
> > +		dev_err(fdev->dev, "Unsupported class: %d\n", class);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB) {
> > +		dev_err(fdev->dev, "Unsupported firmware endianness"
> > +			"(%d) expected (%d)\n", ehdr->e_ident[EI_DATA],
> > +			ELFDATA2LSB);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fw->size < ehdr->e_shoff + sizeof(struct elf32_shdr)) {
> > +		dev_err(fdev->dev, "Image is too small (%u)\n", fw->size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG)) {
> > +		dev_err(fdev->dev, "Image is corrupted (bad magic)\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ehdr->e_phnum != fdev->drvdata->num_mem) {
> > +		dev_err(fdev->dev, "spurious nb of segments (%d) expected (%d)"
> > +			"\n", ehdr->e_phnum, fdev->drvdata->num_mem);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ehdr->e_type != ET_EXEC) {
> > +		dev_err(fdev->dev, "Unsupported ELF header type (%d) expected"
> > +			" (%d)\n", ehdr->e_type, ET_EXEC);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ehdr->e_machine != EM_SLIM) {
> > +		dev_err(fdev->dev, "Unsupported ELF header machine (%d) "
> > +			"expected (%d)\n", ehdr->e_machine, EM_SLIM);
> > +		return -EINVAL;
> > +	}
> > +	if (ehdr->e_phoff > fw->size) {
> > +		dev_err(fdev->dev, "Firmware size is too small\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +st_fdma_elf_load_segments(struct st_fdma_dev *fdev, const struct firmware *fw)
> > +{
> > +	struct device *dev = fdev->dev;
> > +	struct elf32_hdr *ehdr;
> > +	struct elf32_phdr *phdr;
> > +	int i, mem_loaded = 0;
> > +	const u8 *elf_data = fw->data;
> > +
> > +	ehdr = (struct elf32_hdr *)elf_data;
> > +	phdr = (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
> > +
> > +	/*
> > +	 * go through the available ELF segments
> > +	 * the program header's paddr member to contain device addresses.
> > +	 * We then go through the physically contiguous memory regions which we
> > +	 * allocated (and mapped) earlier on the probe,
> > +	 * and "translate" device address to kernel addresses,
> > +	 * so we can copy the segments where they are expected.
> > +	 */
> > +	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
> > +		u32 da = phdr->p_paddr;
> > +		u32 memsz = phdr->p_memsz;
> > +		u32 filesz = phdr->p_filesz;
> > +		u32 offset = phdr->p_offset;
> > +		void *dst;
> > +
> > +		if (phdr->p_type != PT_LOAD)
> > +			continue;
> > +
> > +		dev_dbg(dev, "phdr: type %d da %#x ofst:%#x memsz %#x filesz %#x\n",
> > +			phdr->p_type, da, offset, memsz, filesz);
> > +
> > +		if (filesz > memsz) {
> > +			dev_err(dev, "bad phdr filesz 0x%x memsz 0x%x\n",
> > +				filesz, memsz);
> > +			break;
> > +		}
> > +
> > +		if (offset + filesz > fw->size) {
> > +			dev_err(dev, "truncated fw: need 0x%x avail 0x%zx\n",
> > +				offset + filesz, fw->size);
> > +			break;
> > +		}
> > +
> > +		dst = st_fdma_seg_to_mem(fdev, da, memsz);
> > +		if (!dst) {
> > +			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
> > +			break;
> > +		}
> > +
> > +		if (phdr->p_filesz)
> > +			memcpy(dst, elf_data + phdr->p_offset, filesz);
> > +
> > +		if (memsz > filesz)
> > +			memset(dst + filesz, 0, memsz - filesz);
> > +
> > +		mem_loaded++;
> > +	}
> > +
> > +	return (mem_loaded != fdev->drvdata->num_mem) ? -EIO : 0;
> > +}
> 
> Above two seem to be generic code and should be moved to core, this way
> other drivers using ELF firmware binaries can reuse...

Do you mean add to dmaengine.c?

Certainly st_fdma_elf_sanity_check is fairly generic. st_fdma_elf_load_segments
is less so, especially st_fdma_seg_to_mem().

> 
> > @@ -738,6 +925,15 @@ static int st_fdma_slave_config(struct dma_chan *chan,
> >  				struct dma_slave_config *slave_cfg)
> >  {
> >  	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
> > +	int ret;
> > +
> > +	if (!atomic_read(&fchan->fdev->fw_loaded)) {
> > +		ret = st_fdma_get_fw(fchan->fdev);
> 
> this seems quite an odd place to load firmware, can you explain why
> 

Good question :) I've been round the houses a bit on the firmware loading.

I will try and document here what I've tried and the different advantages /
disadvantages I've encountered.

In V3 patches, I used the device_config() hook. This can sleep (I think..it isn't
documented here [1]). This hook happens very close to the dma starting and the
rootfs / firmware is likely to be present. However I've sinced learnt that it
doesn't get  called in the memcpy case so is not a sufficient solution.

In part putting it here was to try and get firmware loading out of probe() based
on your feedback to v1 [2].

In V1 patches: - I was using request_firmware_nowait() in probe() in conjunction with
the CONFIG_FW_LOADER_USER_HELPER kernel option. I've since also learnt that this
kernel option is deprecated and shouldn't be used.

Your feedback in v1 was to move firmware loading to device open [2]. However
what classes is  device open in the dmaengine context is not obvious.

===

device_alloc_chan_resources() hook

This is probably the hook closest to a device open in dmaengine context.
This hook can sleep so request_firmware can be called. However if all drivers
are built-in firmware loading still fails as ALSA drivers calls
devm_snd_dmaengine_pcm_register() which requests dma channels during *its* probe().
This happens way before the rootfs is present and thus firmware loading still
fails, and is still being done indirectly from a probe() anyway.

I had some discussion with Mark and Arnd on IRC, about the possibility of ALSA
not rquesting DMA channels during their probe(). Marks opinion I believe was
this wasn't a good solution as ALSA would be presenting devices to userspace 
that potentially don't exist & can't work.
 
===

*_prep_*() hooks

+ Always get called before a DMA is started

- *prep* hooks can be called from atomic context so can't sleep [1] and can't use
  request_firmware().
- I tried using request_firmwqare_nowait() with GFP_ATOMIC flag firmware. This
  half works but firmware loading doesn't complete before the DMA is started which
  means it often fails on the first DMA attempt.

 ===

Suggested solution for v4 patches: -

Both Arnd, Mark and Lee initial suggestion on irc was that if the device is useless
without firmware, and the firmware isn't available then the driver should call
request_firmware() in probe() and -EPROBE_DEFER if not available.

This solution works well, in both the built-in and modules case. As the deffered
fdma driver re-probes after the rootfs has been mounted when the firmware is
available. The other ALSA depedencies then also re-probe and everything works
nicely (and you can be assured that the devices will actually work at this point).

This fdma driver and the ALSA ones will be enabled in multi_v7_defconfig as modules,
so it is only likely to be used as a module. However using -EPROBE_DEFER
mechanism, has the nice quality that if it is compiled as built-in you still end
up with a working system (albeit with a longer boot time).

Failing that the only other solution I can see is extending the dmaengine API to
provide another hook which can sleep, and must be called before a DMA
transation is started. Note that firmware isn't actually *required* until we
start the dma transaction, but the device is useless without this firmware. In fact
its "registers" are really just offsets into its DMEM so in theory even the
registers are totally firmware dependent.

Also I notice the only other dmaengine driver imx-sdma.c using firmware calls
request_firmware_nowait from its probe().

Are you happy with my proposed solutiion for v4? If not how would you like me to
implement this?

regards,

Peter.

[1] https://www.kernel.org/doc/Documentation/dmaengine/provider.txt

[2] https://lkml.org/lkml/2015/10/13/278
