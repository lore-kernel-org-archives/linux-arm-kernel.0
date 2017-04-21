From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 21 Apr 2017 02:31:56 +0200
Subject: [PATCH 1/4] mmc: pxamci: Use the right flags for DMA callback init
In-Reply-To: <fbc663e3-4de5-7370-afa8-0f8747f50ca7@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
 <fbc663e3-4de5-7370-afa8-0f8747f50ca7@tul.cz>
Message-ID: <f79f04c4-e1c4-0b33-d381-9041aa69db2e@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 19.4.2017 v 01:16 Petr Cvek napsal(a):
> The MMC_DATA_READ and the MMC_DATA_WRITE flags for the mmc request are not
> mutually exclusive (two different bits). Change the callback initialization
> code to use the proper one.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

It seems I forgot to patch a code in the pxamci_setup_data():

	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
	config.src_addr = host->res->start + MMC_RXFIFO;
	config.dst_addr = host->res->start + MMC_TXFIFO;
	config.src_maxburst = 32;
	config.dst_maxburst = 32;

	if (data->flags & MMC_DATA_READ) {
		host->dma_dir = DMA_FROM_DEVICE;
		direction = DMA_DEV_TO_MEM;
		chan = host->dma_chan_rx;
	} else {
		host->dma_dir = DMA_TO_DEVICE;
		direction = DMA_MEM_TO_DEV;
		chan = host->dma_chan_tx;
	}

I will add it in v2 series.

Just curious: why does the MMC_DATA_READ/MMC_DATA_WRITE flag occupies two bits anyway is there a hardware which can do both request at the same time?

BTW that config.* block should be IMO split and moved into that if(){} too (as the PXA27x do only one DMA direction at the time).

Petr
