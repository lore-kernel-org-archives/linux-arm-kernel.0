From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 21:48:51 +0200
Subject: [PATCH 3/9] ARM: S3C64XX: Stop and flush requests on freeing
In-Reply-To: <cover.1276284559.git.mcuelenaere@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
Message-ID: <4C129323.2030101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a DMA channel is freed, its pending requests should be flushed and the
channel should be halted. This patch ensures that happens.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index be043db..48cbfbc 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -560,7 +560,8 @@ int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
 		       channel, chan->client, client);
 	}
 
-	/* sort out stopping and freeing the channel */
+	s3c64xx_dma_flush(chan);
+	s3c64xx_dma_stop(chan);
 
 
 	chan->client = NULL;
-- 
1.7.1
