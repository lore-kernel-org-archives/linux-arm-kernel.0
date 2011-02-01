From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 11:58:32 +0000
Subject: [PATCH] mmci: restrict DMA usage to large, even multiblock
	transfers
In-Reply-To: <20110201114522.GD31216@n2100.arm.linux.org.uk>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
	<20110201105408.GA31216@n2100.arm.linux.org.uk>
	<4D47EFB6.5090509@stericsson.com>
	<20110201114522.GD31216@n2100.arm.linux.org.uk>
Message-ID: <20110201115832.GF31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 11:45:22AM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 12:34:14PM +0100, Ulf Hansson wrote:
> > Getting FIFO overrun/underruns is then as of today already the case when  
> > running PIO for ARM primecell. To prevent this; you probably now that  
> > already, hardware flow control is implemented in ST version of the ARM  
> > primecell.
> 
> That really doesn't matter.  This driver is not specific to the ST
> version.  It has to work on other versions as well.
> 
> I would like to see some further discussion on the unresolved issue of
> the burst size setting - the discussion between myself and Linus died
> without any apparant conclusion.  Linus tried to get some knowledgable
> people from ST involved but no one ever followed up.
> 
> What I gathered from the discussion was that the additional DMA enable
> bit found in ST variants should not be set as this changes the behaviour
> of the DMA requests to be incompatible with the DMA controller
> requirements.  With that bit clear, I see no problem with leaving the
> burst threshold set at the half FIFO size.
> 
> That then makes avoiding DMA for requests below a specific size an
> optimization issue and nothing more.

So... I think this patch will work fine on ST variants, returning the
DMA request signals back to their classic meaning.  That being LSREQ
is only activated on the _final_ transfer rather than the last 8
transfers, which as Linus describes makes your DMA controller complete
on the 8th-to-last transfer.

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7052b75..0acc2ed 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -44,7 +44,6 @@ static unsigned int fmax = 515633;
  * struct variant_data - MMCI variant-specific quirks
  * @clkreg: default value for MCICLOCK register
  * @clkreg_enable: enable value for MMCICLOCK register
- * @dmareg_enable: enable value for MMCIDATACTRL register
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -56,7 +55,6 @@ static unsigned int fmax = 515633;
 struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
-	unsigned int		dmareg_enable;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
@@ -83,7 +81,6 @@ static struct variant_data variant_ux500 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
-	.dmareg_enable		= 1 << 12, /* DMAREQCTRL */
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
@@ -367,6 +364,10 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	if (!chan)
 		return -EINVAL;
 
+	/* If less than or equal to the fifo size, don't bother with DMA */ 
+	if (host->size <= variant->fifosize)
+		return -EINVAL;
+
 	device = chan->device;
 	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len, conf.direction);
 	if (nr_sg == 0)
@@ -388,7 +389,6 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	dma_async_issue_pending(chan);
 
 	datactrl |= MCI_DPSM_DMAENABLE;
-	datactrl |= variant->dmareg_enable;
 
 	/* Trigger the DMA transfer */
 	writel(datactrl, host->base + MMCIDATACTRL);
