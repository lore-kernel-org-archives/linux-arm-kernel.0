From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 20 Apr 2011 13:10:14 +1200
Subject: [RFC PATCH 10/23] at91: Make RTT device common
In-Reply-To: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1303261827-27730-12-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual RTT code for each at91 variant with a single
implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |   23 ++------------
 arch/arm/mach-at91/at91cap9_devices.c    |   23 ++------------
 arch/arm/mach-at91/at91sam9260_devices.c |   23 ++------------
 arch/arm/mach-at91/at91sam9261_devices.c |   23 ++------------
 arch/arm/mach-at91/at91sam9263_devices.c |   40 +++--------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   23 ++------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   23 ++------------
 arch/arm/mach-at91/devices.c             |   51 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |    5 +++
 9 files changed, 80 insertions(+), 154 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 08b1c19..2828e7e 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -187,27 +187,10 @@ static struct __initdata at91_dev_table_tcb device_tcb = {
  *  RTT
  * -------------------------------------------------------------------- */
 
-static struct resource rtt_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at572d940hf_rtt_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt_resources,
-	.num_resources	= ARRAY_SIZE(rtt_resources),
+static struct __initdata at91_dev_table_rtt device_rtt = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT,
 };
 
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at572d940hf_rtt_device);
-}
-
-
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
@@ -548,6 +531,7 @@ static struct at91_device_table __initdata at572d940hf_device_table = {
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb,
+	.rtt[0]		= &device_rtt,
 };
 
 void __init at572d940hf_init_devices(void)
@@ -563,7 +547,6 @@ void __init at572d940hf_init_devices(void)
  */
 static int __init at91_add_standard_devices(void)
 {
-	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 575926d..cf33337 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -294,27 +294,10 @@ static struct __initdata at91_dev_table_tcb device_tcb = {
  *  RTT
  * -------------------------------------------------------------------- */
 
-static struct resource rtt_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91cap9_rtt_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt_resources,
-	.num_resources	= ARRAY_SIZE(rtt_resources),
+static struct __initdata at91_dev_table_rtt device_rtt = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT,
 };
 
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at91cap9_rtt_device);
-}
-
-
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
@@ -886,6 +869,7 @@ static struct at91_device_table __initdata at91cap9_device_table = {
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb,
+	.rtt[0]		= &device_rtt,
 };
 
 void __init at91cap9_init_devices(void)
@@ -900,7 +884,6 @@ void __init at91cap9_init_devices(void)
  */
 static int __init at91_add_standard_devices(void)
 {
-	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index aeb3807..fb6d939 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -192,27 +192,10 @@ static struct __initdata at91_dev_table_tcb device_tcb1 = {
  *  RTT
  * -------------------------------------------------------------------- */
 
-static struct resource rtt_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91sam9260_rtt_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt_resources,
-	.num_resources	= ARRAY_SIZE(rtt_resources),
+static struct __initdata at91_dev_table_rtt device_rtt = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT,
 };
 
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at91sam9260_rtt_device);
-}
-
-
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
@@ -815,6 +798,7 @@ static struct at91_device_table __initdata at91sam9260_device_table = {
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb0,
 	.tcb[1]		= &device_tcb1,
+	.rtt[0]		= &device_rtt,
 };
 
 void __init at91sam9260_init_devices(void)
@@ -829,7 +813,6 @@ void __init at91sam9260_init_devices(void)
  */
 static int __init at91_add_standard_devices(void)
 {
-	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index f5a98c5..da06dbb 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -244,27 +244,10 @@ static struct __initdata at91_dev_table_tcb device_tcb = {
  *  RTT
  * -------------------------------------------------------------------- */
 
-static struct resource rtt_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91sam9261_rtt_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt_resources,
-	.num_resources	= ARRAY_SIZE(rtt_resources),
+static struct __initdata at91_dev_table_rtt device_rtt = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT,
 };
 
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at91sam9261_rtt_device);
-}
-
-
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
@@ -701,6 +684,7 @@ static struct at91_device_table __initdata at91sam9261_device_table = {
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb,
+	.rtt[0]		= &device_rtt,
 };
 
 void __init at91sam9261_init_devices(void)
@@ -716,7 +700,6 @@ void __init at91sam9261_init_devices(void)
  */
 static int __init at91_add_standard_devices(void)
 {
-	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 6fcdf1a..cd55e8f 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -524,43 +524,14 @@ static struct __initdata at91_dev_table_tcb device_tcb = {
  *  RTT
  * -------------------------------------------------------------------- */
 
-static struct resource rtt0_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT0,
-		.end	= AT91_BASE_SYS + AT91_RTT0 + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91sam9263_rtt0_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt0_resources,
-	.num_resources	= ARRAY_SIZE(rtt0_resources),
-};
-
-static struct resource rtt1_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT1,
-		.end	= AT91_BASE_SYS + AT91_RTT1 + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+static struct __initdata at91_dev_table_rtt device_rtt0 = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT0,
 };
 
-static struct platform_device at91sam9263_rtt1_device = {
-	.name		= "at91_rtt",
-	.id		= 1,
-	.resource	= rtt1_resources,
-	.num_resources	= ARRAY_SIZE(rtt1_resources),
+static struct __initdata at91_dev_table_rtt device_rtt1 = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT1,
 };
 
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at91sam9263_rtt0_device);
-	platform_device_register(&at91sam9263_rtt1_device);
-}
-
-
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
@@ -1006,6 +977,8 @@ static struct at91_device_table __initdata at91sam9263_device_table = {
 	.spi[0]		= &device_spi0,
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb,
+	.rtt[0]		= &device_rtt0,
+	.rtt[1]		= &device_rtt1,
 };
 
 void __init at91sam9263_init_devices(void)
@@ -1020,7 +993,6 @@ void __init at91sam9263_init_devices(void)
  */
 static int __init at91_add_standard_devices(void)
 {
-	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 27f7102..53ce9eb 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -561,27 +561,10 @@ void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
  *  RTT
  * -------------------------------------------------------------------- */
 
-static struct resource rtt_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91sam9g45_rtt_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt_resources,
-	.num_resources	= ARRAY_SIZE(rtt_resources),
+static struct __initdata at91_dev_table_rtt device_rtt = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT,
 };
 
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at91sam9g45_rtt_device);
-}
-
-
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
@@ -1076,6 +1059,7 @@ static struct at91_device_table __initdata at91sam9g45_device_table = {
 	.spi[1]		= &device_spi1,
 	.tcb[0]		= &device_tcb0,
 	.tcb[1]		= &device_tcb1,
+	.rtt[0]		= &device_rtt,
 };
 
 void __init at91sam9g45_init_devices(void)
@@ -1092,7 +1076,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_hdmac();
 	at91_add_device_rtc();
-	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 23dc097..65cd887 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -439,27 +439,10 @@ static void __init at91_add_device_rtc(void) {}
  *  RTT
  * -------------------------------------------------------------------- */
 
-static struct resource rtt_resources[] = {
-	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91sam9rl_rtt_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt_resources,
-	.num_resources	= ARRAY_SIZE(rtt_resources),
+static struct __initdata at91_dev_table_rtt device_rtt = {
+	.mmio_base	=  AT91_BASE_SYS + AT91_RTT,
 };
 
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at91sam9rl_rtt_device);
-}
-
-
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
@@ -955,6 +938,7 @@ static struct at91_device_table __initdata at91sam9rl_device_table = {
 	.twi[0]		= &device_twi,
 	.spi[0]		= &device_spi,
 	.tcb[0]		= &device_tcb,
+	.rtt[0]		= &device_rtt,
 };
 
 void __init at91sam9rl_init_devices(void)
@@ -972,7 +956,6 @@ static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_hdmac();
 	at91_add_device_rtc();
-	at91_add_device_rtt();
 	at91_add_device_watchdog();
 	return 0;
 }
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index f7ed9aa..1596c20 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -923,6 +923,56 @@ static void __init at91_add_device_tc(void)
 static void __init at91_add_device_tc(void) { }
 #endif
 
+/* --------------------------------------------------------------------
+ *  RTT
+ * -------------------------------------------------------------------- */
+
+static struct resource rtt0_resources[] = {
+	{
+		.end	= SZ_16,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device at91_rtt0_device = {
+	.name		= "at91_rtt",
+	.id		= 0,
+	.resource	= rtt0_resources,
+	.num_resources	= ARRAY_SIZE(rtt0_resources),
+};
+
+static struct resource rtt1_resources[] = {
+	{
+		.end	= SZ_16,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device at91_rtt1_device = {
+	.name		= "at91_rtt",
+	.id		= 1,
+	.resource	= rtt1_resources,
+	.num_resources	= ARRAY_SIZE(rtt1_resources),
+};
+
+static void __init at91_add_device_rtt(void)
+{
+	struct at91_dev_table_rtt *info[2];
+
+	info[0] = devices->rtt[0];
+	info[1] = devices->rtt[1];
+	BUG_ON(!info[0] && !info[1]);
+
+	if (info[0]) {
+		init_resource_mem(&rtt0_resources[0], info[0]->mmio_base);
+		platform_device_register(&at91_rtt0_device);
+	}
+	if (info[1]) {
+		init_resource_mem(&rtt1_resources[0], info[1]->mmio_base);
+		platform_device_register(&at91_rtt1_device);
+	}
+}
+
 void __init at91_init_devices(struct at91_device_table *device_table)
 {
 	devices = device_table;
@@ -931,6 +981,7 @@ void __init at91_init_devices(struct at91_device_table *device_table)
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
+	at91_add_device_rtt();
 	return 0;
 }
 
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index 41b6f6e..d7855ec 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -103,6 +103,10 @@ struct at91_dev_table_tcb {
 	int			nr_resources;
 };
 
+struct at91_dev_table_rtt {
+	unsigned		mmio_base;
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -113,6 +117,7 @@ struct at91_device_table {
 	struct at91_dev_table_twi		*twi[2];
 	struct at91_dev_table_spi		*spi[2];
 	struct at91_dev_table_tcb		*tcb[2];
+	struct at91_dev_table_rtt		*rtt[2];
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
