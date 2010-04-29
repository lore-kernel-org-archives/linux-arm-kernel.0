From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 29 Apr 2010 21:30:36 +0300
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
Message-ID: <20100429183036.GL26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Wed, Apr 21, 2010 at 02:10:08AM +0100, Martin Guy wrote:
> 
> and the SDHC cards I have don't work at all, spewing tons of:
> mmcblk0: error -38 sending status comand
> mmcblk0: error -38 sending read/write command, response 0x4, card status 0xff04
> end_request: I/O error, dev mmcblk0, sector 7744509

I bought today a new 4GB SDHC card and with that I get similar
errors that you are getting. I hacked around quick fix which seems
to work in my case. I'm wondering whether you could check if it
helps with your SDHC card as well?

This problem is easy to reproduce, just read last sector of the
card (I wrote simple C program but running fdisk -l does the same).

Patch is below.

Thanks,
MW

>From d98fcab5f26e3ee8185232b51baeaae66b1ac0f3 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Thu, 29 Apr 2010 21:14:32 +0300
Subject: [PATCH] mmc_block: use single block reads for last block on SPI

Some SD-cards fail when doing multiblock read for last block with SPI host. Real
reason is not known but as workaround we can perform this last read using
multiple single block reads.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 drivers/mmc/card/block.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cb9fbc8..acf3a88 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -277,6 +277,25 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		if (brq.data.blocks > card->host->max_blk_count)
 			brq.data.blocks = card->host->max_blk_count;
 
+		if (mmc_host_is_spi(card->host)) {
+			/*
+			 * Some SD-cards fail when we are reading last block
+			 * with multiblock read. In these cases we automatically
+			 * use single block reads. This only happens on SPI
+			 * hosts.
+			 */
+			if (rq_data_dir(req) == READ && brq.data.blocks > 1) {
+				sector_t s = blk_rq_pos(req) + brq.data.blocks;
+
+				if (s >= get_capacity(md->disk)) {
+					disable_multi = 1;
+					printk(KERN_DEBUG "%s: using single block "
+					       "read for this request\n",
+					       req->rq_disk->disk_name);
+				}
+			}
+		}
+
 		/*
 		 * After a read error, we redo the request one sector at a time
 		 * in order to accurately determine which sectors can be read
-- 
1.5.6.5
