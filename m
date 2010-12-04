From: tony@atomide.com (Tony Lindgren)
Date: Sat, 04 Dec 2010 13:29:50 -0800
Subject: [PATCH 3/5] omap: McBSP: Fix potential memory leak in
	omap_mcbsp_remove
In-Reply-To: <20101204212904.25978.22090.stgit@baageli.muru.com>
References: <20101204212904.25978.22090.stgit@baageli.muru.com>
Message-ID: <20101204212950.25978.54068.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jarkko Nikula <jhnikula@gmail.com>

Function omap_mcbsp_probe allocates struct omap_mcbsp *mcbsp but it is not
freed in omap_mcbsp_remove. Fix this, remove unneeded structure cleanups
and clk_disable calls since they are not needed here.

This is not problem currently but becomes if the mcbsp driver is ever
modularized.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index eac4b97..f79090c 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1836,17 +1836,11 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 
 		omap34xx_device_exit(mcbsp);
 
-		clk_disable(mcbsp->fclk);
-		clk_disable(mcbsp->iclk);
 		clk_put(mcbsp->fclk);
 		clk_put(mcbsp->iclk);
 
 		iounmap(mcbsp->io_base);
-
-		mcbsp->fclk = NULL;
-		mcbsp->iclk = NULL;
-		mcbsp->free = 0;
-		mcbsp->dev = NULL;
+		kfree(mcbsp);
 	}
 
 	return 0;
