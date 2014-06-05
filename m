From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:29:48 +0200
Subject: [PATCH 3/4] [SCSI] qlogicfas: don't call free_dma()
In-Reply-To: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
Message-ID: <1402003789-1990031-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qlogicfas scsi driver does not use DMA, and the call to free_dma()
in its exit function seems to have been copied incorrectly from
another driver but never caused trouble.

One case where it gets in the way is randconfig builds on ARM,
which depending on the configuration does not provide a free_dma()
function, causing this build error:

drivers/scsi/qlogicfas.c: In function 'qlogicfas_release':
drivers/scsi/qlogicfas.c:175:3: error: implicit declaration of function 'free_dma' [-Werror=implicit-function-declaration]
   free_dma(shost->dma_channel);
   ^

Removing the incorrect function calls should be the obvious
fix for this, with no downsides.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/qlogicfas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qlogicfas.c b/drivers/scsi/qlogicfas.c
index 13d628b..a22bb1b 100644
--- a/drivers/scsi/qlogicfas.c
+++ b/drivers/scsi/qlogicfas.c
@@ -171,8 +171,6 @@ static int qlogicfas_release(struct Scsi_Host *shost)
 		qlogicfas408_disable_ints(priv);	
 		free_irq(shost->irq, shost);
 	}
-	if (shost->dma_channel != 0xff)
-		free_dma(shost->dma_channel);
 	if (shost->io_port && shost->n_io_port)
 		release_region(shost->io_port, shost->n_io_port);
 	scsi_host_put(shost);
-- 
1.8.3.2
