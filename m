From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 18:28:26 +0000
Subject: [PATCH] drivers: mmc: msm: update to new arm pfn_to_dma API
In-Reply-To: <1295373844-27713-1-git-send-email-dwalker@codeaurora.org>
References: <1295373844-27713-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20110118182826.GI16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 10:04:04AM -0800, Daniel Walker wrote:
> The page_to_dma() API call was removed. It caused this build
> failure,

Because it's an API internal interface.  Don't use it.  Why is this
driver poking about in API internals all over the place?

        for (i = 0; i < host->dma.num_ents; i++) {

This goes behind the scatterlist's back.  scatterlists may not remain
contiguous in the future.  Use the proper API.

                box->cmd = CMD_MODE_BOX;

        /* Initialize sg dma address */
        sg->dma_address = page_to_dma(mmc_dev(host->mmc), sg_page(sg))
                                + sg->offset;

        if (i == (host->dma.num_ents - 1))
                        box->cmd |= CMD_LC;

The lines above are wrongly indented.

                rows = (sg_dma_len(sg) % MCI_FIFOSIZE) ?
                        (sg_dma_len(sg) / MCI_FIFOSIZE) + 1 :
                        (sg_dma_len(sg) / MCI_FIFOSIZE) ;

                if (data->flags & MMC_DATA_READ) {
                        box->src_row_addr = msmsdcc_fifo_addr(host);
                        box->dst_row_addr = sg_dma_address(sg);

                        box->src_dst_len = (MCI_FIFOSIZE << 16) |
                                           (MCI_FIFOSIZE);
                        box->row_offset = MCI_FIFOSIZE;

                        box->num_rows = rows * ((1 << 16) + 1);
                        box->cmd |= CMD_SRC_CRCI(crci);
                } else {
                        box->src_row_addr = sg_dma_address(sg);
                        box->dst_row_addr = msmsdcc_fifo_addr(host);

                        box->src_dst_len = (MCI_FIFOSIZE << 16) |
                                           (MCI_FIFOSIZE);
                        box->row_offset = (MCI_FIFOSIZE << 16);

                        box->num_rows = rows * ((1 << 16) + 1);
                        box->cmd |= CMD_DST_CRCI(crci);
                }
                box++;
                sg++;
        }

        /* location of command block must be 64 bit aligned */
        BUG_ON(host->dma.cmd_busaddr & 0x07);

        nc->cmdptr = (host->dma.cmd_busaddr >> 3) | CMD_PTR_LP;
        host->dma.hdr.cmdptr = DMOV_CMD_PTR_LIST |
                               DMOV_CMD_ADDR(host->dma.cmdptr_busaddr);
        host->dma.hdr.complete_func = msmsdcc_dma_complete_func;

        n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
                        host->dma.num_ents, host->dma.dir);
/* dsb inside dma_map_sg will write nc out to mem as well */

That is completely broken.  Please use the official APIs - it's not
hard.  Here's how to do it correctly:

	/* location of command block must be 64 bit aligned */
	BUG_ON(host->dma.cmd_busaddr & 0x07);

	nc->cmdptr = (host->dma.cmd_busaddr >> 3) | CMD_PTR_LP;
	host->dma.hdr.cmdptr = DMOV_CMD_PTR_LIST |
			       DMOV_CMD_ADDR(host->dma.cmdptr_busaddr);
	host->dma.hdr.complete_func = msmsdcc_dma_complete_func;

	n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
			host->dma.num_ents, host->dma.dir);
	if (n == 0)
		/* you handle mapping error here */
		/* a mapping error is not n != host->dma.num_ents */

	for_each_sg(host->dma.sg, sg, n, i) {
		if (i == n - 1)
			box->cmd |= CMD_LC;
		rows = (sg_dma_len(sg) % MCI_FIFOSIZE) ?
			(sg_dma_len(sg) / MCI_FIFOSIZE) + 1 :
			(sg_dma_len(sg) / MCI_FIFOSIZE) ;

		if (data->flags & MMC_DATA_READ) {
			box->src_row_addr = msmsdcc_fifo_addr(host);
			box->dst_row_addr = sg_dma_address(sg);

			box->src_dst_len = (MCI_FIFOSIZE << 16) |
					   (MCI_FIFOSIZE);
			box->row_offset = MCI_FIFOSIZE;

			box->num_rows = rows * ((1 << 16) + 1);
			box->cmd |= CMD_SRC_CRCI(crci);
		} else {
			box->src_row_addr = sg_dma_address(sg);
			box->dst_row_addr = msmsdcc_fifo_addr(host);

			box->src_dst_len = (MCI_FIFOSIZE << 16) |
					   (MCI_FIFOSIZE);
			box->row_offset = (MCI_FIFOSIZE << 16);

			box->num_rows = rows * ((1 << 16) + 1);
			box->cmd |= CMD_DST_CRCI(crci);
		}
		box++;
	}

and when you use writel() etc afterwards, those non-cacheable writes to
box-> will be ordered with your device write.

So that's a NAK for your original patch.
