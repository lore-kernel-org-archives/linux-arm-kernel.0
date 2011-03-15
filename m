From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Tue, 15 Mar 2011 15:41:55 +0100
Subject: [PATCH 3/4] mmci/pl180: Support for db8500v2. ST-Ericsson modified
	ARM PrimeCell PL180 block has not got an updated corresponding
	amba-id,
	althought the IP block has changed in db8500v2. The change was done to
	the datactrl register.
In-Reply-To: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <1300200116-12185-4-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
---
 drivers/mmc/host/mmci.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1dfd099..0b92c87 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -51,6 +51,7 @@ static unsigned int fmax = 515633;
  *		  is asserted (likewise for RX)
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
+ * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -60,6 +61,7 @@ struct variant_data {
 	unsigned int		fifohalfsize;
 	bool			sdio;
 	bool			st_clkdiv;
+	bool			blksz_datactrl16;
 };
 
 static struct variant_data variant_arm = {
@@ -86,6 +88,17 @@ static struct variant_data variant_ux500 = {
 	.st_clkdiv		= true,
 };
 
+static struct variant_data variant_ux500v2 = {
+	.fifosize		= 30 * 4,
+	.fifohalfsize		= 8 * 4,
+	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.datalength_bits	= 24,
+	.sdio			= true,
+	.st_clkdiv		= true,
+	.blksz_datactrl16	= true,
+};
+
 /*
  * This must be called with host->lock held
  */
@@ -457,7 +470,10 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	blksz_bits = ffs(data->blksz) - 1;
 	BUG_ON(1 << blksz_bits != data->blksz);
 
-	datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
+	if (variant->blksz_datactrl16)
+		datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
+	else
+		datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
 
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
@@ -1289,6 +1305,12 @@ static struct amba_id mmci_ids[] = {
 		.mask   = 0x00ffffff,
 		.data	= &variant_ux500,
 	},
+	{
+		.id     = 0x00480180,
+		.mask   = 0x00ffffff,
+		.data	= &variant_ux500v2,
+		.name	= "db8500v2-sdi",
+	},
 	{ 0, 0 },
 };
 
-- 
1.7.3.1
