From: segooon@gmail.com (Vasiliy Kulikov)
Date: Sun, 10 Oct 2010 21:28:23 +0400
Subject: [PATCH] arch: arm/imx: fix memory init in imx_dma_request()
Message-ID: <1286731703-17775-1-git-send-email-segooon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx_dma_request() didn't fill struct pointed by imxdma with zeroes
as it passed sizeof(pointer), not sizeof(struct) to memset().

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 I cannot compile this driver, so it is not tested.

 arch/arm/mach-imx/dma-v1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/dma-v1.c b/arch/arm/mach-imx/dma-v1.c
index 3e8c47c..b5cc027 100644
--- a/arch/arm/mach-imx/dma-v1.c
+++ b/arch/arm/mach-imx/dma-v1.c
@@ -699,7 +699,7 @@ int imx_dma_request(int channel, const char *name)
 		local_irq_restore(flags);
 		return -EBUSY;
 	}
-	memset(imxdma, 0, sizeof(imxdma));
+	memset(imxdma, 0, sizeof(*imxdma));
 	imxdma->name = name;
 	local_irq_restore(flags); /* request_irq() can block */
 
-- 
1.7.0.4
