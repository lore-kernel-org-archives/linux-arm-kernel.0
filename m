From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Fri,  9 Oct 2009 12:18:49 +0400
Subject: [PATCH] mtd: maps/sa1100: fix section mismatch
Message-ID: <1255076329-15065-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f0b1e589 changed sa1100_mtd_probe from __init to __devinit,
but missed to correct sa1100_setup_mtd definition accordingly, which
causes following warning:

WARNING: vmlinux.o(.devinit.text+0xf4): Section mismatch in reference from
 the function sa1100_mtd_probe() to the function .init.text:sa1100_setup_mtd()
The function __devinit sa1100_mtd_probe() references
a function __init sa1100_setup_mtd().
If sa1100_setup_mtd is only used by sa1100_mtd_probe then
annotate sa1100_setup_mtd with a matching annotation.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 drivers/mtd/maps/sa1100-flash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index fdb97f3..b1cf17b 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -248,7 +248,7 @@ static void sa1100_destroy(struct sa_info *info, struct flash_platform_data *pla
 		plat->exit();
 }
 
-static struct sa_info *__init
+static struct sa_info *__devinit
 sa1100_setup_mtd(struct platform_device *pdev, struct flash_platform_data *plat)
 {
 	struct sa_info *info;
-- 
1.6.3.4
