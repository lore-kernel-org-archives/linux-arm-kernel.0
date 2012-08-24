From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 24 Aug 2012 06:00:18 +0000 (UTC)
Subject: [PATCH] MMC: OMAP MSDI: fix broken PIO mode
Message-ID: <alpine.DEB.2.00.1208240555210.25436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


After commit 26b88520b80695a6fa5fd95b5d97c03f4daf87e0 ("mmc:
omap_hsmmc: remove private DMA API implementation"), the Nokia N800
here stopped booting:

[    2.086181] Waiting for root device /dev/mmcblk0p1...
[    2.324066] Unhandled fault: imprecise external abort (0x406) at 0x00000000
[    2.331451] Internal error: : 406 [#1] ARM
[    2.335784] Modules linked in:
[    2.339050] CPU: 0    Not tainted  (3.6.0-rc3 #60)
[    2.344146] PC is at default_idle+0x28/0x30
[    2.348602] LR is at trace_hardirqs_on_caller+0x15c/0x1b0

...

This turned out to be due to memory corruption caused by long-broken
PIO code in drivers/mmc/host/omap.c.  (Previously, this driver had
been using DMA; but the above commit caused the MMC driver to fall
back to PIO mode with an unmodified Kconfig.)

The PIO code, added with the rest of the driver in commit
730c9b7e6630f786fcec026fb11d2e6f2c90fdcb ("[MMC] Add OMAP MMC host
driver"), confused bytes with 16-bit words.  This bug caused memory
located after the PIO transfer buffer to be corrupted with transfers
larger than 32 bytes.  The driver also did not increment the buffer
pointer after the transfer occurred.  This bug resulted in data
corruption during any transfer larger than 64 bytes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Juha Yrj?l? <juha.yrjola@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 50e08f0..a5999a7 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -668,7 +668,7 @@ mmc_omap_clk_timer(unsigned long data)
 static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
-	int n;
+	int n, nwords;
 
 	if (host->buffer_bytes_left == 0) {
 		host->sg_idx++;
@@ -678,15 +678,23 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	n = 64;
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
+
+	nwords = n / 2;
+	nwords += n & 1; /* handle odd number of bytes to transfer */
+
 	host->buffer_bytes_left -= n;
 	host->total_bytes_left -= n;
 	host->data->bytes_xfered += n;
 
 	if (write) {
-		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer, n);
+		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA),
+			      host->buffer, nwords);
 	} else {
-		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer, n);
+		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA),
+			     host->buffer, nwords);
 	}
+
+	host->buffer += nwords;
 }
 
 static inline void mmc_omap_report_irq(u16 status)
-- 
1.7.10.4
