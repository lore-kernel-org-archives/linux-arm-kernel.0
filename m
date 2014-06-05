From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:29:49 +0200
Subject: [PATCH 4/4] [SCSI] NCR53c406a: don't call free_dma() by default
In-Reply-To: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
Message-ID: <1402003789-1990031-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NCR53c406a scsi driver normally does not use DMA, unless
the USE_PIO macro is disabled by modifying the source code.

The call to free_dma() for some reason uses #ifdef USE_DMA,
which does not do the right thing, since USE_DMA is defined
as a boolean that is either 0 or 1, but always present.

One case where it gets in the way is randconfig builds on ARM,
which depending on the configuration does not provide a free_dma()
function, causing this build error:

drivers/scsi/NCR53c406a.c: In function 'NCR53c406a_release':
drivers/scsi/NCR53c406a.c:600:3: error: implicit declaration of function 'free_dma' [-Werror=implicit-function-declaration]
   free_dma(shost->dma_channel);
   ^

This changes the code to use #if USE_DMA, to match the
rest of the file, which seems to be what the author intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/NCR53c406a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR53c406a.c b/drivers/scsi/NCR53c406a.c
index c91888a..2c78785 100644
--- a/drivers/scsi/NCR53c406a.c
+++ b/drivers/scsi/NCR53c406a.c
@@ -595,7 +595,7 @@ static int NCR53c406a_release(struct Scsi_Host *shost)
 {
 	if (shost->irq)
 		free_irq(shost->irq, NULL);
-#ifdef USE_DMA
+#if USE_DMA
 	if (shost->dma_channel != 0xff)
 		free_dma(shost->dma_channel);
 #endif
-- 
1.8.3.2
