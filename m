From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Nov 2012 15:48:01 +1100
Subject: linux-next: manual merge of the arm-soc tree with the  tree
Message-ID: <20121127154801.42dea58ad974f4792bc85edf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-spear13xx/spear13xx.c between commit b47394911c26 ("ARM:
SPEAr13xx: Pass DW DMAC platform data from DT") from the slave-dma tree
and commit 3e270ba6e915 ("ARM: SPEAr13xx: Remove fields not required for
ssp controller") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-spear13xx/spear13xx.c
index 0e166fa,c4af775..0000000
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@@ -25,14 -25,60 +25,12 @@@
  #include <mach/generic.h>
  #include <mach/spear.h>
  
 -/* common dw_dma filter routine to be used by peripherals */
 -bool dw_dma_filter(struct dma_chan *chan, void *slave)
 -{
 -	struct dw_dma_slave *dws = (struct dw_dma_slave *)slave;
 -
 -	if (chan->device->dev == dws->dma_dev) {
 -		chan->private = slave;
 -		return true;
 -	} else {
 -		return false;
 -	}
 -}
 -
  /* ssp device registration */
 -static struct dw_dma_slave ssp_dma_param[] = {
 -	{
 -		/* Tx */
 -		.cfg_hi = DWC_CFGH_DST_PER(DMA_REQ_SSP0_TX),
 -		.cfg_lo = 0,
 -		.src_master = DMA_MASTER_MEMORY,
 -		.dst_master = DMA_MASTER_SSP0,
 -	}, {
 -		/* Rx */
 -		.cfg_hi = DWC_CFGH_SRC_PER(DMA_REQ_SSP0_RX),
 -		.cfg_lo = 0,
 -		.src_master = DMA_MASTER_SSP0,
 -		.dst_master = DMA_MASTER_MEMORY,
 -	}
 -};
 -
  struct pl022_ssp_controller pl022_plat_data = {
- 	.bus_id = 0,
  	.enable_dma = 1,
 -	.dma_filter = dw_dma_filter,
 -	.dma_rx_param = &ssp_dma_param[1],
 -	.dma_tx_param = &ssp_dma_param[0],
 -};
 -
 -/* CF device registration */
 -struct dw_dma_slave cf_dma_priv = {
 -	.cfg_hi = 0,
 -	.cfg_lo = 0,
 -	.src_master = 0,
 -	.dst_master = 0,
 -};
 -
 -/* dmac device registeration */
 -struct dw_dma_platform_data dmac_plat_data = {
 -	.nr_channels = 8,
 -	.chan_allocation_order = CHAN_ALLOCATION_DESCENDING,
 -	.chan_priority = CHAN_PRIORITY_DESCENDING,
 -	.block_size = 4095U,
 -	.nr_masters = 2,
 -	.data_width = { 3, 3, 0, 0 },
 +	.dma_filter = dw_dma_generic_filter,
 +	.dma_rx_param = "ssp0_rx",
 +	.dma_tx_param = "ssp0_tx",
- 	.num_chipselect = 3,
  };
  
  void __init spear13xx_l2x0_init(void)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/d1a62090/attachment.sig>
