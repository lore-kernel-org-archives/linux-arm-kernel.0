From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Aug 2012 12:47:28 +0200
Subject: [PATCH 3/3] ARM: Kirkwood: increase atomic coherent pool size
In-Reply-To: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1345459648-24263-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default 256 KiB coherent pool may be too small for some of the Kirkwood
devices, so increase it to make sure that devices will be able to allocate
their buffers with GFP_ATOMIC flag.

Suggested-by: Josh Coombs <josh.coombs@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-kirkwood/common.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index c4b64ad..d748f50 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -517,6 +517,13 @@ void __init kirkwood_wdt_init(void)
 void __init kirkwood_init_early(void)
 {
 	orion_time_set_base(TIMER_VIRT_BASE);
+
+	/*
+	 * Some Kirkwood devices allocate their coherent buffers from atomic
+	 * context. Increase size of atomic coherent pool to make sure such
+	 * the allocations won't fail.
+	 */
+	init_dma_coherent_pool_size(SZ_1M);
 }
 
 int kirkwood_tclk;
-- 
1.7.1.569.g6f426
