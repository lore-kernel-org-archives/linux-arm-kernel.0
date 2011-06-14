From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 14 Jun 2011 16:10:39 +0200
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <BANLkTi=YvSL_yzku6v3tsJaaLTL=fBXShg@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
	<201106030956.43174.heiko@sntech.de>
	<BANLkTi=YvSL_yzku6v3tsJaaLTL=fBXShg@mail.gmail.com>
Message-ID: <201106141610.42700.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei,

Am Dienstag 14 Juni 2011 schrieb Andrei Warkentin:
> I recently came back from vacation (which is why I didn't pitch in
> before). Has there been any further update on this? I want to exclude
> my EMMC partitioning changes as the possible culprit here.

nope, no updates yet. The flood also only starts when udev wants to
create its device nodes, meaning the initial detection seems not to
produce this problem

But when I disable the whole boot partition stuff, it works as before
without irq storms.

As there don't seem to exist reports from other emmc users about this
I guess the problem lays somewhere between the boot-partitions-patch
and the sdhci-s3c driver (for s3c2416 at least).

As my knowledge about the whole mmc-subsystem is quite spare I also
don't really know where to start looking for the culprit yet.

Heiko


diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 71da564..32290c5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1136,7 +1136,7 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 
 	if (!mmc_card_mmc(card))
 		return 0;
-
+/*
 	if (card->ext_csd.boot_size) {
 		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PART_CONFIG_ACC_BOOT0,
 					 card->ext_csd.boot_size >> 9,
@@ -1151,7 +1151,7 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 		if (ret)
 			return ret;
 	}
-
+*/
 	return ret;
 }
