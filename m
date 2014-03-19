From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:18 +0100
Subject: [PATCH 21/62] ARM: msm: avoid calling debug_ll_addr on !MMU
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-22-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSM7X00A has an open-coded version of debug_ll_io_init so it
can use MT_DEVICE_NONSHARED as required by the platform.

However, this fails to build on no-MMU kernels because the
debug_ll_addr function is not available. Since the iotable_init
function doesn't actually do anyting in this configuration,
we can simply get away by enclosing the broken function call
in an #ifdef, which seems to be the least ugly workaround.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
---
 arch/arm/mach-msm/io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index adc8971..34e0947 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -78,8 +78,10 @@ void __init msm_map_common_io(void)
 	asm("mcr p15, 0, %0, c15, c2, 4" : : "r" (0));
 #if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
 		defined(CONFIG_DEBUG_MSM_UART3)
+#ifdef CONFIG_MMU
 	debug_ll_addr(&msm_io_desc[size - 1].pfn,
 		      &msm_io_desc[size - 1].virtual);
+#endif
 	msm_io_desc[size - 1].pfn = __phys_to_pfn(msm_io_desc[size - 1].pfn);
 #endif
 	iotable_init(msm_io_desc, size);
-- 
1.8.3.2
