From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  7 Jul 2011 12:18:38 +0200
Subject: [PATCH 3/4] arm: mach-s3c2440: dma: fix section mismatch
In-Reply-To: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1310033919-4245-4-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If s3c2440_dma_add() and s3c2440_dma_init() are in __init, then the
struct s3c2440_dma_driver they are using should be __initdata, too.

Fixes:

WARNING: vmlinux.o(.data+0x14ac): Section mismatch in reference from the variable s3c2440_dma_driver to the function .init.text:s3c2440_dma_add()
The variable s3c2440_dma_driver references the function __init s3c2440_dma_add()

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/dma.c b/arch/arm/mach-s3c2440/dma.c
index 3b0529f..f417959 100644
--- a/arch/arm/mach-s3c2440/dma.c
+++ b/arch/arm/mach-s3c2440/dma.c
@@ -198,7 +198,7 @@ static int __init s3c2440_dma_add(struct sys_device *sysdev)
 	return s3c24xx_dma_init_map(&s3c2440_dma_sel);
 }
 
-static struct sysdev_driver s3c2440_dma_driver = {
+static struct sysdev_driver __initdata s3c2440_dma_driver = {
 	.add	= s3c2440_dma_add,
 };
 
-- 
1.7.5.4
