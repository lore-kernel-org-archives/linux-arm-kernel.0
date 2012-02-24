From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 16:54:15 -0800
Subject: [PATCH 6/7] ARM: OMAP: Fix devexit for dma when CONFIG_HOTPLUG is
 not set
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Message-ID: <20120224005415.16794.60826.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get:

`omap_system_dma_remove' referenced in section `.data' of arch/arm/plat-omap/built-in.o:
defined in discarded section `.devexit.text' of arch/arm/plat-omap/built-in.o

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
