From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Tue, 15 Mar 2011 15:41:54 +0100
Subject: [PATCH 2/4] amba-pl022: Add loopback support for the SPI on 5500
In-Reply-To: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <1300200116-12185-3-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prajadevi H <prajadevi.h@stericsson.com>

Add new amba-pl022 vendor for the DB5500 pl023,
as the pl023 on db8500 and db5500 vary.

Signed-off-by: Prajadevi H <prajadevi.h@stericsson.com>
---
 drivers/spi/amba-pl022.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 5c2b092..413eaf0 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -324,6 +324,7 @@ struct vendor_data {
 	bool unidir;
 	bool extended_cr;
 	bool pl023;
+	bool loopback;
 };
 
 /**
@@ -1983,7 +1984,7 @@ static int pl022_setup(struct spi_device *spi)
 
 	SSP_WRITE_BITS(chip->cr0, clk_freq.scr, SSP_CR0_MASK_SCR, 8);
 	/* Loopback is available on all versions except PL023 */
-	if (!pl022->vendor->pl023) {
+	if (pl022->vendor->loopback) {
 		if (spi->mode & SPI_LOOP)
 			tmp = LOOPBACK_ENABLED;
 		else
@@ -2233,6 +2234,7 @@ static struct vendor_data vendor_arm = {
 	.unidir = false,
 	.extended_cr = false,
 	.pl023 = false,
+	.loopback = true,
 };
 
 
@@ -2242,6 +2244,7 @@ static struct vendor_data vendor_st = {
 	.unidir = false,
 	.extended_cr = true,
 	.pl023 = false,
+	.loopback = true,
 };
 
 static struct vendor_data vendor_st_pl023 = {
@@ -2250,6 +2253,16 @@ static struct vendor_data vendor_st_pl023 = {
 	.unidir = false,
 	.extended_cr = true,
 	.pl023 = true,
+	.loopback = false,
+};
+
+static struct vendor_data vendor_db5500_pl023 = {
+	.fifodepth = 32,
+	.max_bpw = 32,
+	.unidir = false,
+	.extended_cr = true,
+	.pl023 = true,
+	.loopback = true,
 };
 
 static struct amba_id pl022_ids[] = {
@@ -2283,6 +2296,12 @@ static struct amba_id pl022_ids[] = {
 		.mask   = 0xffffffff,
 		.data   = &vendor_st_pl023,
 	},
+	{
+		.id	= 0x00080023,
+		.mask	= 0xffffffff,
+		.data	= &vendor_db5500_pl023,
+		.name	= "db5500-spi",
+	},
 	{ 0, 0 },
 };
 
-- 
1.7.3.1
