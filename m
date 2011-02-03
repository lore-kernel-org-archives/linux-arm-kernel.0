From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Feb 2011 14:00:31 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110203003054.GA7068@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<20110130212939.GA384@n2100.arm.linux.org.uk>
	<AANLkTi=yj716us6bHFfGRwm2Q_iPEAJeQHDjB=3_pTe5@mail.gmail.com>
	<20110203003054.GA7068@n2100.arm.linux.org.uk>
Message-ID: <20110203140031.GB14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 03, 2011 at 12:30:54AM +0000, Russell King - ARM Linux wrote:
> It looks to me like the data counter decrements according to bytes
> transferred on the MMC bus.  When a FIFO overrun error occurs, we
> immediately handle this, disable the data path, and that prevents the
> remaining good FIFO data being read.  So, the corruption represented
> above is because we haven't read the pending data from the FIFO.
> 
> In the vast majority of cases, it seems there's little point as it won't
> get us up to a block boundary, so maybe the correct answer is on overruns
> to subtract the FIFO size, but not for underruns.  So something like the
> below.  I'll give it a spin tomorrow.

Right, this is what I've presently got, which appears to resolve
the issue for me.  Ack?

 drivers/mmc/host/mmci.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 577b03f..dcbe9c4 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -540,22 +540,34 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		if (dma_inprogress(host))
 			mmci_dma_data_error(host);
 
-		/* Calculate how far we are into the transfer */
+		/*
+		 * Calculate how far we are into the transfer.  Note that
+		 * the data counter gives the number of bytes transferred
+		 * on the MMC bus, not on the host side.  On reads, this
+		 * can be as much as a FIFO-worth of data ahead.  This
+		 * matters for FIFO overruns only.
+		 */
 		remain = readl(host->base + MMCIDATACNT);
 		success = data->blksz * data->blocks - remain;
 
-		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
+		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
+			status, success);
 		if (status & MCI_DATACRCFAIL) {
 			/* Last block was not successful */
-			data->bytes_xfered = round_down(success - 1, data->blksz);
+			success -= 1;
 			data->error = -EILSEQ;
 		} else if (status & MCI_DATATIMEOUT) {
-			data->bytes_xfered = round_down(success, data->blksz);
 			data->error = -ETIMEDOUT;
-		} else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
-			data->bytes_xfered = round_down(success, data->blksz);
+		} else if (status & MCI_TXUNDERRUN) {
+			data->error = -EIO;
+		} else if (status & MCI_RXOVERRUN) {
+			if (success > host->variant->fifosize)
+				success -= host->variant->fifosize;
+			else
+				success = 0;
 			data->error = -EIO;
 		}
+		data->bytes_xfered = round_down(success, data->blksz);
 	}
 
 	if (status & MCI_DATABLOCKEND)
