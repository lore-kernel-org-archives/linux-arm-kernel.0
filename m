From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 23 Mar 2011 11:05:36 +0100
Subject: [PATCH 6/6] mmci: support for ST-Ericsson db8500v2
Message-ID: <1300874736-14952-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

ST-Ericsson modified ARM PrimeCell PL180 block has not got
an updated corresponding amba-id, althought the IP block has
changed in db8500v2. The change was done to the datactrl register.
Using the overrided subversion ID, account for this.

Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5bbb87d..0c72a77 100644
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
@@ -1298,9 +1314,14 @@ static struct amba_id mmci_ids[] = {
 	},
 	{
 		.id     = 0x00480180,
-		.mask   = 0x00ffffff,
+		.mask   = 0xf0ffffff,
 		.data	= &variant_ux500,
 	},
+	{
+		.id     = 0x10480180,
+		.mask   = 0xf0ffffff,
+		.data	= &variant_ux500v2,
+	},
 	{ 0, 0 },
 };
 
-- 
1.7.3.2
