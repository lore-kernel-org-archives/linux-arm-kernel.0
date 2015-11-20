From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 17:43:44 +0100
Subject: [PATCH] memstick: use sector_div instead of do_div
Message-ID: <7721365.qIlei5Urfx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

do_div is the wrong way to divide a sector_t, as it is less
efficient when sector_t is 32-bit wide. With the upcoming
do_div optimizations, the kernel starts warning about this:

drivers/memstick/core/ms_block.c: In function 'msb_io_work':
include/asm-generic/div64.h:207:28: warning: comparison of distinct pointer types lacks a cast

This changes the code to use sector_div instead, which always
produces optimal code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 24f2f8473dee..84abf9d3c24e 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1909,7 +1909,7 @@ static void msb_io_work(struct work_struct *work)
 		lba = blk_rq_pos(msb->req);
 
 		sector_div(lba, msb->page_size / 512);
-		page = do_div(lba, msb->pages_in_block);
+		page = sector_div(lba, msb->pages_in_block);
 
 		if (rq_data_dir(msb->req) == READ)
 			error = msb_do_read_request(msb, lba, page, sg,
