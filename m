From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 2 Sep 2015 18:42:20 +0100
Subject: [PATCH 3/7] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <20150819154007.GB13546@localhost>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-4-git-send-email-peter.griffin@linaro.org>
 <20150819154007.GB13546@localhost>
Message-ID: <20150902174220.GC15477@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for reviewing.

On Wed, 19 Aug 2015, Vinod Koul wrote:

> On Wed, Jul 08, 2015 at 05:11:24PM +0100, Peter Griffin wrote:
> > +static int
> > +st_fdma_elf_sanity_check(struct st_fdma_dev *fdev, const struct firmware *fw)
> > +{
> > +	const char *fw_name = fdev->pdata->fw_name;
> > +	struct elf32_hdr *ehdr;
> > +	char class;
> > +
> > +	if (!fw) {
> > +		dev_err(fdev->dev, "failed to load %s\n", fw_name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fw->size < sizeof(struct elf32_hdr)) {
> sizeof(*ehdr) ?

Ok fixed in v2.

> 
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
> > +		dev_err(fdev->dev, "Unsupported firmware endianness\n");
> would be worth printing the value for debug

Fixed in v2

> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fw->size < ehdr->e_shoff + sizeof(struct elf32_shdr)) {
> > +		dev_err(fdev->dev, "Image is too small\n");
> Again printing size helps when you get a log trace and have no idea why size
> was small. Similar one other places

Fixed in v2

> 
> 
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
> > +	return (mem_loaded != fdev->drvdata->num_mem) ? -EINVAL : 0;
> so you are not expecting any segment with PT_LOAD otherwise this check will
> fail as num_mem is assigned from e_phnum.

That is correct.

> Also perhaps EIO will be better return?

Updated to -EIO in v2.

> 
> > +}
> > +
> > +static void st_fdma_enable(struct st_fdma_dev *fdev)
> > +{
> > +	unsigned long hw_id, hw_ver, fw_rev;
> > +	u32 val;
> > +
> > +	/* disable CPU pipeline clock & reset cpu pipeline */
> > +	val = FDMA_CLK_GATE_DIS | FDMA_CLK_GATE_RESET;
> > +	fdma_write(fdev, val, CLK_GATE);
> 
> empty line here

Removed in v2.

> 
> > +	/* disable SLIM core STBus sync */
> > +	fdma_write(fdev, FDMA_STBUS_SYNC_DIS, STBUS_SYNC);
> > +	/* enable cpu pipeline clock */
> > +	fdma_write(fdev, !FDMA_CLK_GATE_DIS, CLK_GATE);
> > +
> > +	/* clear int & cmd mailbox */
> > +	fdma_write(fdev, ~0UL, INT_CLR);
> > +	fdma_write(fdev, ~0UL, CMD_CLR);
> 
> here too

Removed in v2.
> 
> > +static int st_fdma_get_fw(struct st_fdma_dev *fdev)
> > +{
> > +	int ret;
> > +
> > +	init_completion(&fdev->fw_ack);
> > +	atomic_set(&fdev->fw_loaded, 0);
> > +
> > +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
> > +				      fdev->pdata->fw_name, fdev->dev,
> > +				      GFP_KERNEL, fdev, st_fdma_fw_cb);
> 
> Isn't doing this in device probe too stringent and holding up load...

No I don't think so, as we are using the _nowait variant which is
asynchronous and sleeps for the smallest period possible so as not
to increase boot time of built-in code.

We could use GFP_ATOMIC which means request_firmware_nowait can't sleep
at all. Although no other drivers which use request_firmware_nowait
in their probe functions do that which I can see.

> 
> > +	fdesc = st_fdma_alloc_desc(fchan, sg_len);
> > +	if (!fdesc) {
> > +		dev_err(fchan->fdev->dev, "no memory for desc\n");
> > +		return NULL;
> > +	}
> > +
> > +	fdesc->iscyclic = false;
> > +
> > +	for_each_sg(sgl, sg, sg_len, i) {
> > +		hw_node = fdesc->node[i].desc;
> > +
> > +		hw_node->next = fdesc->node[(i + 1) % sg_len].pdesc;
> > +		hw_node->control = NODE_CTRL_REQ_MAP_DREQ(fchan->dreq_line);
> > +
> > +		if (direction == DMA_MEM_TO_DEV) {
> > +			hw_node->control |= NODE_CTRL_SRC_INCR;
> > +			hw_node->control |= NODE_CTRL_DST_STATIC;
> > +			hw_node->saddr = sg_dma_address(sg);
> > +			hw_node->daddr = fchan->cfg.dev_addr;
> > +		} else {
> > +			hw_node->control |= NODE_CTRL_SRC_STATIC;
> > +			hw_node->control |= NODE_CTRL_DST_INCR;
> > +			hw_node->saddr = fchan->cfg.dev_addr;
> > +			hw_node->daddr = sg_dma_address(sg);
> > +		}
> > +
> > +		hw_node->nbytes = sg_dma_len(sg);
> > +		hw_node->generic.length = sg_dma_len(sg);
> > +		hw_node->generic.sstride = 0;
> > +		hw_node->generic.dstride = 0;
> 
> This looks quite similar to previous one, I think some bits can be reused

Will abstract out common parts in v2.

> 
> > +static int st_fdma_slave_config(struct dma_chan *chan,
> > +				struct dma_slave_config *slave_cfg)
> > +{
> > +	u32 maxburst = 0, addr = 0;
> > +	enum dma_slave_buswidth width;
> > +	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
> > +	int ch_id = fchan->vchan.chan.chan_id;
> > +	struct st_fdma_dev *fdev = fchan->fdev;
> > +
> > +	if (slave_cfg->direction == DMA_DEV_TO_MEM) {
> 
> This is depreciated, you can't use direction here. Please save the fields and
> then use them in prep_ call

Ok, will save the fields and use in prep_ calls in v2.

> 
> Also this is quite big patch, consider splitting it up for faster review

Will split into smaller patches in v2.

regards,

Peter.
