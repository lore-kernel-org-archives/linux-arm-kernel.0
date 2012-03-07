From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  7 Mar 2012 23:03:56 +0100
Subject: [PATCH] ARM: davinci: DA850: move da850_register_pm to .init.text
Message-ID: <1331157836-30527-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All callers (board-mityomapl138.c and board-da850-evm.c) use it in
__init functions only.

This fixes:

	WARNING: vmlinux.o(.text+0xd664): Section mismatch in reference from the function da850_register_pm() to the function .init.text:da8xx_get_mem_ctlr()
	The function da850_register_pm() references
	the function __init da8xx_get_mem_ctlr().
	This is often because da850_register_pm lacks a __init
	annotation or the annotation of da8xx_get_mem_ctlr is wrong.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-davinci/da850.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 992c4c4..b44dc84 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1026,7 +1026,7 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 }
 #endif
 
-int da850_register_pm(struct platform_device *pdev)
+int __init da850_register_pm(struct platform_device *pdev)
 {
 	int ret;
 	struct davinci_pm_config *pdata = pdev->dev.platform_data;
-- 
1.7.9.1
