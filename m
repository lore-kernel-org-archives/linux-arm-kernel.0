From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 00:27:58 +0200
Subject: [PATCH] dmaengine: shdmac: avoid unused variable warnings
Message-ID: <27084610.k92kokiTBY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver uses '#ifdef CONFIG_ARCH_SHMOBILE' and '#ifdef CONFIG_ARM'
interchangeably in its sh_dmae_probe function, which causes a build
warning when building for ARM without also enabling shmobile:

dma/sh/shdmac.c: In function sh_dmae_probe:
dma/sh/shdmac.c:696:6: warning: unused variable errirq [-Wunused-variable]
dma/sh/shdmac.c:695:16: warning: unused variable irqflags [-Wunused-variable]
dma/sh/shdmac.c: At top level:
dma/sh/shdmac.c:447:20: warning: sh_dmae_err defined but not used [-Wunused-function]

This changes all the #ifdef to test for CONFIG_ARCH_SHMOBILE to
avoid that warning. An earlier patch from Laurent had fixed the warning
for non-ARM case, but it still remained present in ARM randconfig builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 52d6a5ee101bf ("DMA: shdma: Fix warnings due to declared but unused symbols")
---
 drivers/dma/sh/shdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 9f1d4c7dbab8..11707df1a689 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -443,7 +443,7 @@ static bool sh_dmae_reset(struct sh_dmae_device *shdev)
 	return ret;
 }
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARM)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 static irqreturn_t sh_dmae_err(int irq, void *data)
 {
 	struct sh_dmae_device *shdev = data;
@@ -689,7 +689,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	const struct sh_dmae_pdata *pdata;
 	unsigned long chan_flag[SH_DMAE_MAX_CHANNELS] = {};
 	int chan_irq[SH_DMAE_MAX_CHANNELS];
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARM)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 	unsigned long irqflags = 0;
 	int errirq;
 #endif
