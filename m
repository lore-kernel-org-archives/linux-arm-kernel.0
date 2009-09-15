From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:01:25 +0900
Subject: [PATCH 7/7] S3C64XX DMA: AUTOSTART flag implementation
Message-ID: <1253008885-7690-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implemented the S3C2410_DMAF_AUTOSTART flag as is available for S3C24XX
Dma driver.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6400/include/mach/dma.h |    1 +
 arch/arm/plat-s3c64xx/dma.c              |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/dma.h b/arch/arm/mach-s3c6400/include/mach/dma.h
index 1067619..b96e663 100644
--- a/arch/arm/mach-s3c6400/include/mach/dma.h
+++ b/arch/arm/mach-s3c6400/include/mach/dma.h
@@ -67,6 +67,7 @@ static __inline__ int s3c_dma_has_circular(void)
 }
 
 #define S3C2410_DMAF_CIRCULAR		(1 << 0)
+#define S3C2410_DMAF_AUTOSTART		(1 << 1)
 
 #include <plat/dma.h>
 
diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 727072b..49bcfb8 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -394,6 +394,9 @@ int s3c2410_dma_enqueue(unsigned int channel, void *id,
 		chan->end = buff;
 
 		s3c64xx_lli_to_regs(chan, lli);
+
+		if (chan->flags & S3C2410_DMAF_AUTOSTART)
+			return s3c2410_dma_ctrl(channel, S3C2410_DMAOP_START);
 	}
 
 	local_irq_restore(flags);
-- 
1.6.2.5
