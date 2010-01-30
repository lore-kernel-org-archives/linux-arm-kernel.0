From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Jan 2010 18:01:40 -0800
Subject: [PATCH 8/9] omap2/3/4: Fix mach-omap2/serial.c for multiboot
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Message-ID: <20100130020140.10590.26461.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize UART4 only for 3630 and 44xx.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 21e51c5..9bbc2c5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -108,7 +108,7 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 	}
 };
 
-#ifdef CONFIG_ARCH_OMAP4
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct plat_serial8250_port serial_platform_data3[] = {
 	{
 		.irq		= 70,
@@ -120,6 +120,15 @@ static struct plat_serial8250_port serial_platform_data3[] = {
 		.flags		= 0
 	}
 };
+
+static inline void omap2_set_globals_uart4(struct omap_globals *omap2_globals)
+{
+	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
+}
+#else
+static inline void omap2_set_globals_uart4(struct omap_globals *omap2_globals)
+{
+}
 #endif
 
 void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
@@ -127,9 +136,8 @@ void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
 	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
 	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
 	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;
-#ifdef CONFIG_ARCH_OMAP4
-	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
-#endif
+	if (cpu_is_omap3630() || cpu_is_omap44xx())
+		omap2_set_globals_uart4(omap2_globals);
 }
 
 static inline unsigned int __serial_read_reg(struct uart_port *up,
@@ -574,7 +582,7 @@ static struct omap_uart_state omap_uart[] = {
 			},
 		},
 	},
-#ifdef CONFIG_ARCH_OMAP4
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	{
 		.pdev = {
 			.name			= "serial8250",
@@ -722,8 +730,13 @@ void __init omap_serial_init_port(int port)
  */
 void __init omap_serial_init(void)
 {
-	int i;
+	int i, nr_ports;
+
+	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
+		nr_ports = 3;
+	else
+		nr_ports = ARRAY_SIZE(omap_uart);
 
-	for (i = 0; i < ARRAY_SIZE(omap_uart); i++)
+	for (i = 0; i < nr_ports; i++)
 		omap_serial_init_port(i);
 }
