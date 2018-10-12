From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 12 Oct 2018 23:57:37 +0900
Subject: [PATCH 1/2] mmc: uniphier-sd: fix DMA disabling
In-Reply-To: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once DMA is enabled, it is not possible to disable it because
uniphier_sd_dma_endisable() always sets the DMA_ENABLE_DMASDRW bit
regardless of the argument 'enable'. It should disable DMA when
'enable' is false.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/uniphier-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 10e7b30..10d49aa 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -78,7 +78,7 @@ static void *uniphier_sd_priv(struct tmio_mmc_host *host)
 
 static void uniphier_sd_dma_endisable(struct tmio_mmc_host *host, int enable)
 {
-	sd_ctrl_write16(host, CTL_DMA_ENABLE, DMA_ENABLE_DMASDRW);
+	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
 }
 
 /* external DMA engine */
-- 
2.7.4
