From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 11 Nov 2012 18:31:19 +0100
Subject: [PATCH] ARM: Orion: Remove redundent init_dma_coherent_pool_size()
In-Reply-To: <1352356737-14413-1-git-send-email-m.szyprowski@samsung.com>
References: <1352356737-14413-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1352655079-1005-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch:

mm: dmapool: use provided gfp flags for all dma_alloc_coherent() calls

makes these calls on Kirkword and Orion5x redundent. The drivers are
not making atomic requests for coherent memory and hence the default
pool size is now sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/common.c |    7 -------
 arch/arm/mach-orion5x/common.c  |    7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 2c6c218..8080ceb 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -505,13 +505,6 @@ void __init kirkwood_wdt_init(void)
 void __init kirkwood_init_early(void)
 {
 	orion_time_set_base(TIMER_VIRT_BASE);
-
-	/*
-	 * Some Kirkwood devices allocate their coherent buffers from atomic
-	 * context. Increase size of atomic coherent pool to make sure such
-	 * the allocations won't fail.
-	 */
-	init_dma_coherent_pool_size(SZ_1M);
 }
 
 int kirkwood_tclk;
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index b3eb3da..3e07f52 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -194,13 +194,6 @@ void __init orion5x_wdt_init(void)
 void __init orion5x_init_early(void)
 {
 	orion_time_set_base(TIMER_VIRT_BASE);
-
-	/*
-	 * Some Orion5x devices allocate their coherent buffers from atomic
-	 * context. Increase size of atomic coherent pool to make sure such
-	 * the allocations won't fail.
-	 */
-	init_dma_coherent_pool_size(SZ_1M);
 }
 
 int orion5x_tclk;
-- 
1.7.10.4
