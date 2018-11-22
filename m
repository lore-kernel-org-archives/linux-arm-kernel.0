From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Nov 2018 16:57:59 +0000
Subject: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
In-Reply-To: <1542900920.26115.92.camel@atviedlbe741.rss.d3s.at.thales>
References: <1542872133.26115.4.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122092928.GF30658@n2100.armlinux.org.uk>
 <1542889465.26115.54.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122125100.GG30658@n2100.armlinux.org.uk>
 <1542900920.26115.92.camel@atviedlbe741.rss.d3s.at.thales>
Message-ID: <20181122165759.GH30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 03:36:13PM +0000, JABLONSKY Jan wrote:
> Yes, you have right,
> 
> Synopsys DesignWare Multimedia Card Interface driver dw_mmc
> 
> SoC is using internal DMA controller (IDMAC)
> A Few days ago, I also analyzed driver and proper using of DMA-API.
> I found in dw_mci_dmac_complete_dma callback function, that invalidation of caches is performed only in the case 
> of external DMA.
> https://lore.kernel.org/patchwork/patch/1015401/
> 
> there is some significant progress, but the problem still occurs 

>From that patch, should I assume you're not using a separate DMAengine,
i.o.w., host->use_dma is TRANS_MODE_IDMAC ?

Now, setting up the DMA table:

        for (i = 0; i < sg_len; i++) {
                unsigned int length = sg_dma_len(&data->sg[i]);

                u32 mem_addr = sg_dma_address(&data->sg[i]);

is wrong.  scatterlists do not have to be contiguous arrays, they
can be fragmented, and the only way to walk a scatterlist correctly
is to use for_each_sg(), iow:

	struct scatterlist *sg;

	for_each_sg(data->sg, sg, sg_len, i) {
		unsigned int length = sg_dma_len(sg);
		u32 mem_addr = sg_dma_address(sg);

The 64-bit path needs similarly fixing.  It's interesting that the
driver uses for_each_sg() in some places already but not for setting
up these tables.  It should always use for_each_sg().

dw_mci_dma_cleanup() does this:

                dma_unmap_sg(host->dev,
                             data->sg,
                             data->sg_len,
                             mmc_get_dma_dir(data));

Note that it uses host->dev.  Other DMA functions use the same.
However, dw_mci_dmac_complete_dma() uses a different variable:

                /* Invalidate cache after read */
                dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
                                    data->sg,
                                    data->sg_len,
                                    DMA_FROM_DEVICE);

It just happens that mmc_dev(host->slot->mmc) is the same as
host->dev, but this is really bad programming style - it looks
like pure obfuscation to me.

In any case, since the driver supports DMAengine, this is incorrect -
when using DMAengine, the buffer needs to be mapped and unmapped
using the DMAengine struct device, not the host controller's struct
device.  So, using host->dev and mmc_dev(host->slot->mmc) is
incorrect in this driver.


Next, the comment "/* Invalidate cache after read */" suggests that
something is very wrong - the cache handling happens when the buffer
is unmapped.  That happens at two points in this driver - either via

	host->dma_ops->cleanup(host);

if the buffer was mapped by dw_mci_submit_data_dma(), or by
dw_mci_post_req() if it was mapped by dw_mci_pre_req().  Similar
applies to:

        /* Flush cache before write */
        if (host->data->flags & MMC_DATA_WRITE)
                dma_sync_sg_for_device(mmc_dev(host->slot->mmc), sgl,
                                       sg_elems, DMA_TO_DEVICE);

in dw_mci_edmac_start_dma() - those dma_sync_*() calls really should
not be necessary.

I'd get rid of those dma_sync_*() calls and try to validate that
the buffer has been properly mapped to the _correct_ device, and
check that it is properly unmapped after the transfer has completed.
IOW, it's mapped to the MMC device if using dw_mci_idmac_ops (iow,
host->dev) and the DMAengine device if using dw_mci_edmac_ops (iow,
host->dms->ch->device->dev).

Note that there's an additional issue when using DMA engine - that
is an ordering problem, where the MMC controller may report that
the transfer has completed before the DMA engine has finished
transferring the data to memory - I see nothing in this driver
that caters to that issue.  I don't think that's your problem,
because I think you're using the internal MMC controller DMA.

> Perform a combination of Clean and Invalidate operations that ensures coherency from
> the outside in, and from the inside out.
>
> CleanLevel1 Address ; This is broadcast within the cluster
> DSB ; Ensure completion of the clean as far as Level 2
> Clean&InvalLevel2 Address ; forces the address out past level 2
> SYNC ; Ensures completion of the L2 inval
> Clean&InvalLevel1 Address ; This is broadcast within the cluster
> DSB ; Ensure completion of the clean&inval as far as Level 2 (no data lost)
>
> With mentioned sequence, I really can see big difference.
> But anyway, I understand what you mean, I will continue with the analysis

What we end up doing is:

- On buffer mapping for DMA_FROM_DEVICE (DMA from device to memory):
  - invalidate L1 cache
  - dsb
  - invalidate L2 cache
  - sync L2
  This is to ensure that no writebacks occur while the DMA is progressing.
... DMA happens ...
- On buffer unmapping for DMA_FROM_DEVICE:
  - invalidate L2 cache
  - sync L2
  - invalidate L1 cache
  - dsb
  This is to ensure that any speculatively read cache lines are killed
  prior to the CPU reading the new data in the buffer.

This reflects the L1/L2/L1 sequence talked about above without excessive
expense - these cache maintanence operations are _very_ expensive.  Note
that the CPU _may_ speculatively prefetch while the DMA happens, it may
also speculatively prefetch between and during each of the steps in the
documentation quote above.

Note that the CPU is _not_ allowed to write in any way to the memory
buffer while it is mapped for an active DMA operation - that _will_
definitely lead to corrupted data.

- On buffer mapping for DMA_TO_DEVICE (DMA from memory to device):
  - clean L1 cache
  - dsb
  - clean L2 cache
  - sync L2
... DMA happens ...
- On buffer unmapping for DMA_TO_DEVICE:
  - nothing is necessary, since we must have made the data visible to
    DMA in the mapping case.

Note that there's a requirement that the MMIO or other write that
triggers the DMA operation _must_ have an appropriate barrier (eg,
dsb) between all previous writes and the write that starts the DMA.
That means the non-relaxed write[bwl]() functions must be used, or
the driver muse use an explicit barrier and document that.

Hope this helps.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
