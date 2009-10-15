From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 13:21:52 +0100
Subject: [PATCH 1/4] RealView: Add default memory configuration
In-Reply-To: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091015122152.739.39329.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a realview_fixup() function called during booting to set
up the memory banks. This way there is no need to pass a "mem=" argument
on the kernel command line.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/core.c            |   21 +++++++++++++++++++++
 arch/arm/mach-realview/core.h            |    5 +++++
 arch/arm/mach-realview/realview_eb.c     |    1 +
 arch/arm/mach-realview/realview_pb1176.c |   13 +++++++++++++
 arch/arm/mach-realview/realview_pb11mp.c |    1 +
 arch/arm/mach-realview/realview_pba8.c   |    1 +
 arch/arm/mach-realview/realview_pbx.c    |    1 +
 7 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index a2083b6..c21b0fd 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -788,3 +788,24 @@ void __init realview_timer_init(unsigned int timer_irq)
 	realview_clocksource_init();
 	realview_clockevents_init(timer_irq);
 }
+
+/*
+ * Setup the memory banks.
+ */
+void realview_fixup(struct machine_desc *mdesc, struct tag *tags, char **from,
+		    struct meminfo *meminfo)
+{
+	/*
+	 * Most RealView platforms have 512MB contiguous RAM at 0x70000000.
+	 * Half of this is mirrored at 0.
+	 */
+#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
+	meminfo->bank[0].start = 0x70000000;
+	meminfo->bank[0].size = SZ_512M;
+	meminfo->nr_banks = 1;
+#else
+	meminfo->bank[0].start = 0;
+	meminfo->bank[0].size = SZ_256M;
+	meminfo->nr_banks = 1;
+#endif
+}
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 46cd6ac..1398854 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -25,6 +25,7 @@
 #include <linux/amba/bus.h>
 #include <linux/io.h>
 
+#include <asm/setup.h>
 #include <asm/leds.h>
 
 #define AMBA_DEVICE(name,busid,base,plat)			\
@@ -44,6 +45,8 @@ static struct amba_device name##_device = {			\
 	/* .dma		= base##_DMA,*/				\
 }
 
+struct machine_desc;
+
 extern struct platform_device realview_flash_device;
 extern struct platform_device realview_cf_device;
 extern struct platform_device realview_i2c_device;
@@ -61,5 +64,7 @@ extern void realview_timer_init(unsigned int timer_irq);
 extern int realview_flash_register(struct resource *res, u32 num);
 extern int realview_eth_register(const char *name, struct resource *res);
 extern int realview_usb_register(struct resource *res);
+extern void realview_fixup(struct machine_desc *mdesc, struct tag *tags,
+			   char **from, struct meminfo *meminfo);
 
 #endif
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 1d65e64..917f8ca 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -415,6 +415,7 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	.phys_io	= REALVIEW_EB_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_EB_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_eb_timer,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 2817fe0..b1cdd37 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -290,6 +290,18 @@ static struct sys_timer realview_pb1176_timer = {
 	.init		= realview_pb1176_timer_init,
 };
 
+static void realview_pb1176_fixup(struct machine_desc *mdesc,
+				  struct tag *tags, char **from,
+				  struct meminfo *meminfo)
+{
+	/*
+	 * RealView PB1176 only has 128MB of RAM mapped at 0.
+	 */
+	meminfo->bank[0].start = 0;
+	meminfo->bank[0].size = SZ_128M;
+	meminfo->nr_banks = 1;
+}
+
 static void __init realview_pb1176_init(void)
 {
 	int i;
@@ -320,6 +332,7 @@ MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	.phys_io	= REALVIEW_PB1176_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB1176_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb1176_timer,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 94680fc..22726b5 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -331,6 +331,7 @@ MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	.phys_io	= REALVIEW_PB11MP_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB11MP_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb11mp_timer,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 941beb2..fe861e9 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -298,6 +298,7 @@ MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	.phys_io	= REALVIEW_PBA8_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBA8_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pba8_timer,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 7e4bc6c..5d09d8b 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -345,6 +345,7 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	.phys_io	= REALVIEW_PBX_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBX_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.fixup		= realview_fixup,
 	.map_io		= realview_pbx_map_io,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pbx_timer,
