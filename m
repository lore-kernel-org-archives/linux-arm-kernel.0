From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 31 May 2010 13:58:34 +0200
Subject: [PATCH 3/3] ARM: S3C64XX: Stop and flush requests on freeing
In-Reply-To: <cover.1275306279.git.mcuelenaere@gmail.com>
References: <cover.1275306279.git.mcuelenaere@gmail.com>
Message-ID: <4C03A46A.2090403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a DMA channel is freed, its pending requests should be flushed and the
channel should be halted. This patch ensures that happens.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 8c9946f..193b07f 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -560,7 +560,8 @@ int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
 		       channel, chan->client, client);
 	}
 
-	/* sort out stopping and freeing the channel */
+	s3c64xx_dma_flush(chan);
+	s3c64xx_dma_stop(chan);
 
 	chan->client = NULL;
 	chan->in_use = 0;
-- 
1.7.1
