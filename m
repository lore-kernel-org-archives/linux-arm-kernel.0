From: ospite@studenti.unina.it (Antonio Ospite)
Date: Mon,  9 May 2011 22:11:09 +0200
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Message-ID: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't wrap regulator_get() inside an #ifdef CONFIG_REGULATOR anymore, as
now (since be1a50d) it correctly degenerates and returns NULL when the
regulator framework is disabled.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

This comes after the discussion at 
http://www.mail-archive.com/linux-mmc at vger.kernel.org/msg07443.html and 
following.

Regards,
   Antonio Ospite
   http://ao2.it

 drivers/mmc/host/pxamci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 7257738..07e1f22 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -79,7 +79,6 @@ struct pxamci_host {
 
 static inline void pxamci_init_ocr(struct pxamci_host *host)
 {
-#ifdef CONFIG_REGULATOR
 	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
 
 	if (IS_ERR(host->vcc))
@@ -90,7 +89,7 @@ static inline void pxamci_init_ocr(struct pxamci_host *host)
 			dev_warn(mmc_dev(host->mmc),
 				"ocr_mask/setpower will not be used\n");
 	}
-#endif
+
 	if (host->vcc == NULL) {
 		/* fall-back to platform data */
 		host->mmc->ocr_avail = host->pdata ?
-- 
1.7.5.1
