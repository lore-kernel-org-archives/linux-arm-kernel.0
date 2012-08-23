From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 13:41:57 +0800
Subject: [PATCH v2 1/3] ARM: PRIMA2: use DT_MACHINE_START and convert to
 generic board
In-Reply-To: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
References: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345700519-667-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

we will have SiRFMarco and SiRFPolo, all of them will be in the
generic board.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2: rename prima2.c to common.c instead of board-generic.c
 delete redundant atag_offset

 arch/arm/mach-prima2/Makefile               |    2 +-
 arch/arm/mach-prima2/{prima2.c => common.c} |   11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)
 rename arch/arm/mach-prima2/{prima2.c => common.c} (81%)

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index 841847d..f2cde60 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -1,7 +1,7 @@
 obj-y := timer.o
 obj-y += irq.o
 obj-y += rstc.o
-obj-y += prima2.o
+obj-y += common.o
 obj-y += rtciobrg.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/common.c
similarity index 81%
rename from arch/arm/mach-prima2/prima2.c
rename to arch/arm/mach-prima2/common.c
index e9a17ae..f25a541 100644
--- a/arch/arm/mach-prima2/prima2.c
+++ b/arch/arm/mach-prima2/common.c
@@ -30,20 +30,21 @@ void __init sirfsoc_init_late(void)
 	sirfsoc_pm_init();
 }
 
-static const char *prima2cb_dt_match[] __initdata = {
-       "sirf,prima2-cb",
+#ifdef CONFIG_ARCH_PRIMA2
+static const char *prima2_dt_match[] __initdata = {
+       "sirf,prima2",
        NULL
 };
 
-MACHINE_START(PRIMA2_EVB, "prima2cb")
+DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
-	.atag_offset	= 0x100,
 	.map_io         = sirfsoc_map_lluart,
 	.init_irq	= sirfsoc_of_irq_init,
 	.timer		= &sirfsoc_timer,
 	.dma_zone_size	= SZ_256M,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
-	.dt_compat      = prima2cb_dt_match,
+	.dt_compat      = prima2_dt_match,
 	.restart	= sirfsoc_restart,
 MACHINE_END
+#endif
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
