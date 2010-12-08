From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue,  7 Dec 2010 17:02:12 -0800
Subject: [PATCH] OMAP1: SRAM: fix size for OMAP1611 SoCs
Message-ID: <1291770132-2283-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel was failing to boot on omap1611 based OSK boards due to
mis-configured SRAM size.  Existing code was using a hard-coded value
for 250k, which was then rounded down by PAGE_SIZE.  Increasing this to
256k allows kernel to boot on omap1611 SoCs.

Problem reported by and initial fix suggested by Tim Bird.

Thanks to Tony Lindgren for helping diagnose the problem to being
specific to OMAP1611 and not affecting OMAP1610/OMAP1623.

Reported-by: Tim Bird <tim.bird@am.sony.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to Tony's omap-fixes branch, and should probably be 
targetted for .37-rc.

 arch/arm/plat-omap/sram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e2c8eeb..74dac41 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -166,7 +166,7 @@ static void __init omap_detect_sram(void)
 		     cpu_is_omap1710())
 			omap_sram_size = 0x4000;	/* 16K */
 		else if (cpu_is_omap1611())
-			omap_sram_size = 0x3e800;	/* 250K */
+			omap_sram_size = SZ_256K;
 		else {
 			printk(KERN_ERR "Could not detect SRAM size\n");
 			omap_sram_size = 0x4000;
-- 
1.7.2.1
