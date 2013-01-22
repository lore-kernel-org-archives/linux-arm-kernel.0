From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:20:41 +0800
Subject: [PATCH v3 4/9] ARM: PRIMA2: mv timer to timer-prima2 as we will add
 timer-marco
In-Reply-To: <1358857241-10052-1-git-send-email-Barry.Song@csr.com>
References: <1358857241-10052-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1358857241-10052-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Marco timer has different timer IP with prima2, so rename the current timer
to timer-prima2 so that we can add timer-marco.

at the same time, if we don't find prima2 timer node in dt, don't panic the
system as we will make prima2 and marco use same kernel image.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/Makefile                    |    2 +-
 arch/arm/mach-prima2/common.c                    |    2 +-
 arch/arm/mach-prima2/common.h                    |    2 +-
 arch/arm/mach-prima2/{timer.c => timer-prima2.c} |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/mach-prima2/{timer.c => timer-prima2.c} (98%)

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index fc9ce22..0007a6e 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -1,4 +1,3 @@
-obj-y := timer.o
 obj-y += rstc.o
 obj-y += common.o
 obj-y += rtciobrg.o
@@ -6,3 +5,4 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
 obj-$(CONFIG_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_SIRF_IRQ) += irq.o
+obj-$(CONFIG_ARCH_PRIMA2) += timer-prima2.o
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index ed3570e..8e6f668 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -40,7 +40,7 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_lluart,
 	.init_irq	= sirfsoc_of_irq_init,
-	.init_time	= sirfsoc_timer_init,
+	.init_time	= sirfsoc_prima2_timer_init,
 	.dma_zone_size	= SZ_256M,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 9c75f12..d6890b6 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <asm/mach/time.h>
 
-extern void sirfsoc_timer_init(void);
+extern void sirfsoc_prima2_timer_init(void);
 
 extern void __init sirfsoc_of_irq_init(void);
 extern void __init sirfsoc_of_clk_init(void);
diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer-prima2.c
similarity index 98%
rename from arch/arm/mach-prima2/timer.c
rename to arch/arm/mach-prima2/timer-prima2.c
index 8c732a5..309e724 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer-prima2.c
@@ -187,7 +187,7 @@ static void __init sirfsoc_clockevent_init(void)
 }
 
 /* initialize the kernel jiffy timer source */
-void __init sirfsoc_timer_init(void)
+void __init sirfsoc_prima2_timer_init(void)
 {
 	unsigned long rate;
 	struct clk *clk;
@@ -226,14 +226,14 @@ static struct of_device_id timer_ids[] = {
 	{},
 };
 
-void __init sirfsoc_of_timer_map(void)
+static void __init sirfsoc_of_timer_map(void)
 {
 	struct device_node *np;
 	const unsigned int *intspec;
 
 	np = of_find_matching_node(NULL, timer_ids);
 	if (!np)
-		panic("unable to find compatible timer node in dtb\n");
+		return;
 	sirfsoc_timer_base = of_iomap(np, 0);
 	if (!sirfsoc_timer_base)
 		panic("unable to map timer cpu registers\n");
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
