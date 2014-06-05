From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:29:47 +0200
Subject: [PATCH 2/4] [SCSI] pas16: don't call free_dma()
In-Reply-To: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
Message-ID: <1402003789-1990031-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pas16 scsi driver does not use DMA, and the call to free_dma()
in its exit function seems to have been copied incorrectly from
another driver but never caused trouble.

One case where it gets in the way is randconfig builds on ARM,
which depending on the configuration does not provide a free_dma()
function, causing this build error:

drivers/scsi/pas16.c: In function 'pas16_release':
drivers/scsi/pas16.c:611:3: error: implicit declaration of function 'free_dma' [-Werror=implicit-function-declaration]
   free_dma(shost->dma_channel);

Removing the incorrect function calls should be the obvious
fix for this, with no downsides.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>
---
 drivers/scsi/pas16.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/pas16.c b/drivers/scsi/pas16.c
index 0d78a4d..80bacb5 100644
--- a/drivers/scsi/pas16.c
+++ b/drivers/scsi/pas16.c
@@ -607,8 +607,6 @@ static int pas16_release(struct Scsi_Host *shost)
 	if (shost->irq)
 		free_irq(shost->irq, shost);
 	NCR5380_exit(shost);
-	if (shost->dma_channel != 0xff)
-		free_dma(shost->dma_channel);
 	if (shost->io_port && shost->n_io_port)
 		release_region(shost->io_port, shost->n_io_port);
 	scsi_unregister(shost);
-- 
1.8.3.2
