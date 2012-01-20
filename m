From: dron0gus@gmail.com (Gusakov Andrey)
Date: Fri, 20 Jan 2012 17:13:04 +0400
Subject: [PATCH v2] S3C24XX DMA resume regression fix
Message-ID: <1327065184-9805-1-git-send-email-dron0gus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit bb072c3cf21d1c9a5a2eeb5a00679ee7bf39675b
(Use struct syscore_ops for "core" power management)
suspend/resume hooks for each DMA channels were replaced with
hooks that suspend/resume all channels. s3c2410_dma_suspend
suspends channels from 0 to dma_channels. s3c2410_dma_resume
resumes channels in reverse order. So pointer should be
decremented insted of being incremented.

Signed-off-by: Gusakov Andrey <dron0gus@gmail.com>
---
 arch/arm/plat-s3c24xx/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

v2: updated commit message with original commit summary

diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 57abec9..16510d5 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1249,7 +1249,7 @@ static void s3c2410_dma_resume(void)
 	struct s3c2410_dma_chan *cp = s3c2410_chans + dma_channels - 1;
 	int channel;
 
-	for (channel = dma_channels - 1; channel >= 0; cp++, channel--)
+	for (channel = dma_channels - 1; channel >= 0; cp--, channel--)
 		s3c2410_dma_resume_chan(cp);
 }
 
-- 
1.7.0.4
