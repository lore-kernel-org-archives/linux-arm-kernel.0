From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 15 Mar 2012 10:30:19 +0000
Subject: [PATCH 4/6] ARM: OMAP: fix missing __devexit_p() annotations
In-Reply-To: <20120315102845.GB16389@n2100.arm.linux.org.uk>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
Message-ID: <E1S87wp-0000Mz-V8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing __devexit_p() annotations in driver structures for remove functions
marked with __devexit is waiting for build errors to happen, such as:

`omap_system_dma_remove' referenced in section `.data' of arch/arm/plat-omap/bui
lt-in.o: defined in discarded section `.devexit.text' of arch/arm/plat-omap/buil
t-in.o

Add the necessary annotation, and as a result of audit, fix others which
are also missing in arch/arm/*omap*.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 arch/arm/plat-omap/dma.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7e755bb..47c77a1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1012,7 +1012,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove         = __devexit_p(omap_sr_remove),
 	.driver		= {
 		.name	= "smartreflex",
 	},
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 002fb4d..cb856fe 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2125,7 +2125,7 @@ static int __devexit omap_system_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_system_dma_driver = {
 	.probe		= omap_system_dma_probe,
-	.remove		= omap_system_dma_remove,
+	.remove		= __devexit_p(omap_system_dma_remove),
 	.driver		= {
 		.name	= "omap_dma_system"
 	},
-- 
1.7.4.4
