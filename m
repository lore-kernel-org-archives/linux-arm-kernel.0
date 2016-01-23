From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 22 Jan 2016 18:57:13 -0800
Subject: [PATCH v2 3/3] mtd: nand: sunxi: add randomizer support
In-Reply-To: <1449054067-16751-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1449054067-16751-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449054067-16751-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160123025713.GA90611@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All three look good, so pushed to l2-mtd.git/next. One comment below:

On Wed, Dec 02, 2015 at 12:01:07PM +0100, Boris Brezillon wrote:

...

> +static u16 sunxi_nfc_randomizer_state(struct mtd_info *mtd, int page, bool ecc)
> +{
> +	const u16 *seeds = sunxi_nfc_randomizer_page_seeds;
> +	int mod = mtd->erasesize / mtd->writesize;

Richard suggested you use the mtd.h helper here. Patch below.

> +
> +	if (mod > ARRAY_SIZE(sunxi_nfc_randomizer_page_seeds))
> +		mod = ARRAY_SIZE(sunxi_nfc_randomizer_page_seeds);
> +
> +	if (ecc) {
> +		if (mtd->ecc_step_size == 512)
> +			seeds = sunxi_nfc_randomizer_ecc512_seeds;
> +		else
> +			seeds = sunxi_nfc_randomizer_ecc1024_seeds;
> +	}
> +
> +	return seeds[page % mod];
> +}

From: Brian Norris <computersforpeace@gmail.com>
Date: Fri, 22 Jan 2016 18:54:02 -0800
Subject: [PATCH] mtd: nand: sunxi: use mtd_div_by_ws() helper

Suggested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 5f700719d5c2..b5ea6b312df0 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -624,7 +624,7 @@ static u16 sunxi_nfc_randomizer_step(u16 state, int count)
 static u16 sunxi_nfc_randomizer_state(struct mtd_info *mtd, int page, bool ecc)
 {
 	const u16 *seeds = sunxi_nfc_randomizer_page_seeds;
-	int mod = mtd->erasesize / mtd->writesize;
+	int mod = mtd_div_by_ws(mtd->erasesize, mtd);
 
 	if (mod > ARRAY_SIZE(sunxi_nfc_randomizer_page_seeds))
 		mod = ARRAY_SIZE(sunxi_nfc_randomizer_page_seeds);
-- 
2.7.0.rc3.207.g0ac5344
