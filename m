From: avictor.za@gmail.com (Andrew Victor)
Date: Fri, 29 Apr 2011 21:41:08 +0200
Subject: AT91: Convert RTC and RTT drivers to be independent of processor
	base-address
Message-ID: <1304106068.25025.8.camel@redbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For supporting multiple AT91 processors in a single kernel image, the
following changes to the RTC and RTT driver support:
 * pass base addresses via platform resources
 * replace calls to at91_sys_read() / at91_sys_write()
 * rename AT91_RTT/AT91_RTC to AT91xxx_RTT/AT91xxx_RTC to denote they
are processor-specific.

Signed-off-by: Andrew Victor <linux@maxim.org.za>



diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 0fc20a2..a3534e3 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -604,8 +604,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT572D940HF_RTT,
+		.end	= AT91_VA_BASE_SYS + AT572D940HF_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 9ffbf3a..f20a31d 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -674,8 +674,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91CAP9_RTT,
+		.end	= AT91_VA_BASE_SYS + AT91CAP9_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 7b53922..af4e30a 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -665,10 +665,19 @@ static void __init at91_add_device_tc(void) { }
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
+static struct resource rtc_resources[] = {
+	[0] = {
+		.start	= AT91_VA_BASE_SYS + AT91RM9200_RTC,
+		.end	= AT91_VA_BASE_SYS + AT91RM9200_RTC + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91rm9200_rtc_device = {
 	.name		= "at91_rtc",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= rtc_resources,
+	.num_resources	= ARRAY_SIZE(rtc_resources),
 };
 
 static void __init at91_add_device_rtc(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 07eb7b0..fa783c7 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -716,8 +716,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9260_RTT,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9260_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 59fc483..f8a6bc9 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -598,8 +598,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9261_RTT,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9261_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index fb5c23a..5a8fb39 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -956,8 +956,8 @@ static void __init at91_add_device_tc(void) { }
 
 static struct resource rtt0_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT0,
-		.end	= AT91_BASE_SYS + AT91_RTT0 + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9263_RTT0,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9263_RTT0 + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
@@ -971,8 +971,8 @@ static struct platform_device at91sam9263_rtt0_device = {
 
 static struct resource rtt1_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT1,
-		.end	= AT91_BASE_SYS + AT91_RTT1 + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9263_RTT1,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9263_RTT1 + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 1e8f275..464d7ff 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1015,10 +1015,19 @@ static void __init at91_add_device_tc(void) { }
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
+static struct resource rtc_resources[] = {
+	[0] = {
+		.start	= AT91_VA_BASE_SYS + AT91SAM9G45_RTC,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9G45_RTC + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9g45_rtc_device = {
 	.name		= "at91_rtc",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= rtc_resources,
+	.num_resources	= ARRAY_SIZE(rtc_resources),
 };
 
 static void __init at91_add_device_rtc(void)
@@ -1087,8 +1096,8 @@ void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9G45_RTT,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9G45_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 53aaa94..72effd4 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -672,10 +672,19 @@ void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
+static struct resource rtc_resources[] = {
+	[0] = {
+		.start	= AT91_VA_BASE_SYS + AT91SAM9RL_RTC,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9RL_RTC + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9rl_rtc_device = {
 	.name		= "at91_rtc",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= rtc_resources,
+	.num_resources	= ARRAY_SIZE(rtc_resources),
 };
 
 static void __init at91_add_device_rtc(void)
@@ -693,8 +702,8 @@ static void __init at91_add_device_rtc(void) {}
 
 static struct resource rtt_resources[] = {
 	{
-		.start	= AT91_BASE_SYS + AT91_RTT,
-		.end	= AT91_BASE_SYS + AT91_RTT + SZ_16 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9RL_RTT,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9RL_RTT + SZ_16 - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
diff --git a/arch/arm/mach-at91/include/mach/at572d940hf.h b/arch/arm/mach-at91/include/mach/at572d940hf.h
index cfac3d2..b714a84 100644
--- a/arch/arm/mach-at91/include/mach/at572d940hf.h
+++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
@@ -99,7 +99,7 @@
 #define AT572D940HF_PIOC	(0xfffff800 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
+#define AT572D940HF_RTT		(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 
diff --git a/arch/arm/mach-at91/include/mach/at91_rtc.h b/arch/arm/mach-at91/include/mach/at91_rtc.h
index e56f470..2aa234f 100644
--- a/arch/arm/mach-at91/include/mach/at91_rtc.h
+++ b/arch/arm/mach-at91/include/mach/at91_rtc.h
@@ -16,7 +16,7 @@
 #ifndef AT91_RTC_H
 #define AT91_RTC_H
 
-#define	AT91_RTC_CR		(AT91_RTC + 0x00)	/* Control Register */
+#define	AT91_RTC_CR		0x00	/* Control Register */
 #define		AT91_RTC_UPDTIM		(1 <<  0)		/* Update Request Time Register */
 #define		AT91_RTC_UPDCAL		(1 <<  1)		/* Update Request Calendar Register */
 #define		AT91_RTC_TIMEVSEL	(3 <<  8)		/* Time Event Selection */
@@ -29,44 +29,44 @@
 #define			AT91_RTC_CALEVSEL_MONTH		(1 << 16)
 #define			AT91_RTC_CALEVSEL_YEAR		(2 << 16)
 
-#define	AT91_RTC_MR		(AT91_RTC + 0x04)	/* Mode Register */
+#define	AT91_RTC_MR		0x04	/* Mode Register */
 #define			AT91_RTC_HRMOD		(1 <<  0)		/* 12/24 Hour Mode */
 
-#define	AT91_RTC_TIMR		(AT91_RTC + 0x08)	/* Time Register */
+#define	AT91_RTC_TIMR		0x08	/* Time Register */
 #define		AT91_RTC_SEC		(0x7f <<  0)		/* Current Second */
 #define		AT91_RTC_MIN		(0x7f <<  8)		/* Current Minute */
 #define		AT91_RTC_HOUR		(0x3f << 16)		/* Current Hour */
 #define		AT91_RTC_AMPM		(1    << 22)		/* Ante Meridiem Post Meridiem Indicator */
 
-#define	AT91_RTC_CALR		(AT91_RTC + 0x0c)	/* Calendar Register */
+#define	AT91_RTC_CALR		0x0c	/* Calendar Register */
 #define		AT91_RTC_CENT		(0x7f <<  0)		/* Current Century */
 #define		AT91_RTC_YEAR		(0xff <<  8)		/* Current Year */
 #define		AT91_RTC_MONTH		(0x1f << 16)		/* Current Month */
 #define		AT91_RTC_DAY		(7    << 21)		/* Current Day */
 #define		AT91_RTC_DATE		(0x3f << 24)		/* Current Date */
 
-#define	AT91_RTC_TIMALR		(AT91_RTC + 0x10)	/* Time Alarm Register */
+#define	AT91_RTC_TIMALR		0x10	/* Time Alarm Register */
 #define		AT91_RTC_SECEN		(1 <<  7)		/* Second Alarm Enable */
 #define		AT91_RTC_MINEN		(1 << 15)		/* Minute Alarm Enable */
 #define		AT91_RTC_HOUREN		(1 << 23)		/* Hour Alarm Enable */
 
-#define	AT91_RTC_CALALR		(AT91_RTC + 0x14)	/* Calendar Alarm Register */
+#define	AT91_RTC_CALALR		0x14	/* Calendar Alarm Register */
 #define		AT91_RTC_MTHEN		(1 << 23)		/* Month Alarm Enable */
 #define		AT91_RTC_DATEEN		(1 << 31)		/* Date Alarm Enable */
 
-#define	AT91_RTC_SR		(AT91_RTC + 0x18)	/* Status Register */
+#define	AT91_RTC_SR		0x18	/* Status Register */
 #define		AT91_RTC_ACKUPD		(1 <<  0)		/* Acknowledge for Update */
 #define		AT91_RTC_ALARM		(1 <<  1)		/* Alarm Flag */
 #define		AT91_RTC_SECEV		(1 <<  2)		/* Second Event */
 #define		AT91_RTC_TIMEV		(1 <<  3)		/* Time Event */
 #define		AT91_RTC_CALEV		(1 <<  4)		/* Calendar Event */
 
-#define	AT91_RTC_SCCR		(AT91_RTC + 0x1c)	/* Status Clear Command Register */
-#define	AT91_RTC_IER		(AT91_RTC + 0x20)	/* Interrupt Enable Register */
-#define	AT91_RTC_IDR		(AT91_RTC + 0x24)	/* Interrupt Disable Register */
-#define	AT91_RTC_IMR		(AT91_RTC + 0x28)	/* Interrupt Mask Register */
+#define	AT91_RTC_SCCR		0x1c	/* Status Clear Command Register */
+#define	AT91_RTC_IER		0x20	/* Interrupt Enable Register */
+#define	AT91_RTC_IDR		0x24	/* Interrupt Disable Register */
+#define	AT91_RTC_IMR		0x28	/* Interrupt Mask Register */
 
-#define	AT91_RTC_VER		(AT91_RTC + 0x2c)	/* Valid Entry Register */
+#define	AT91_RTC_VER		0x2c	/* Valid Entry Register */
 #define		AT91_RTC_NVTIM		(1 <<  0)		/* Non valid Time */
 #define		AT91_RTC_NVCAL		(1 <<  1)		/* Non valid Calendar */
 #define		AT91_RTC_NVTIMALR	(1 <<  2)		/* Non valid Time Alarm */
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index dac41ec..a1776a0 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -98,7 +98,7 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
+#define AT91CAP9_RTT	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 14fc587..f81a976 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -90,7 +90,7 @@
 #define AT91RM9200_PIOD	(0xfffffa00 - AT91_BASE_SYS)	/* PIO Controller D */
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)	/* Power Management Controller */
 #define AT91_ST		(0xfffffd00 - AT91_BASE_SYS)	/* System Timer */
-#define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
+#define AT91RM9200_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
 #define AT91_MC		(0xffffff00 - AT91_BASE_SYS)	/* Memory Controllers */
 
 #define AT91_USART0	AT91RM9200_BASE_US0
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index c229963..53e715a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -96,7 +96,7 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
+#define AT91SAM9260_RTT		(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index 47864c2..5e633ae 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -79,7 +79,7 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
+#define AT91SAM9261_RTT		(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index e5ef41e..c12514f 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -95,10 +95,10 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT0	(0xfffffd20 - AT91_BASE_SYS)
+#define AT91SAM9263_RTT0	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
-#define AT91_RTT1	(0xfffffd50 - AT91_BASE_SYS)
+#define AT91SAM9263_RTT1	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
 #define AT91_USART0	AT91SAM9263_BASE_US0
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index a1e025e..6c42060 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -105,11 +105,11 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
+#define AT91SAM9G45_RTT		(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
-#define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
+#define AT91SAM9G45_RTC		(0xfffffdb0 - AT91_BASE_SYS)
 
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 94a3e81..003e0b5 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -87,12 +87,12 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
-#define AT91_RTT	(0xfffffd20 - AT91_BASE_SYS)
+#define AT91SAM9RL_RTT	(0xfffffd20 - AT91_BASE_SYS)
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
-#define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)
+#define AT91SAM9RL_RTC	(0xfffffe00 - AT91_BASE_SYS)
 
 #define AT91_USART0	AT91SAM9RL_BASE_US0
 #define AT91_USART1	AT91SAM9RL_BASE_US1
diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index e39b77a..971271c 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
 #include <linux/completion.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 
@@ -35,23 +36,33 @@
 
 #define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */
 
+struct at91_rtc {
+	struct rtc_device	*rtcdev;
+	void __iomem		*regbase;
+	unsigned int		alarm_year;
+};
+
 static DECLARE_COMPLETION(at91_rtc_updated);
-static unsigned int at91_alarm_year = AT91_RTC_EPOCH;
+
+#define rtc_readl(rtc, reg) \
+	__raw_readl((rtc)->regbase + (reg))
+#define rtc_writel(rtc, reg, value) \
+	__raw_writel((value), (rtc)->regbase + (reg))
 
 /*
  * Decode time/date into rtc_time structure
  */
-static void at91_rtc_decodetime(unsigned int timereg, unsigned int calreg,
-				struct rtc_time *tm)
+static void at91_rtc_decodetime(struct at91_rtc* rtc,
+	unsigned int timereg, unsigned int calreg, struct rtc_time *tm)
 {
 	unsigned int time, date;
 
 	/* must read twice in case it changes */
 	do {
-		time = at91_sys_read(timereg);
-		date = at91_sys_read(calreg);
-	} while ((time != at91_sys_read(timereg)) ||
-			(date != at91_sys_read(calreg)));
+		time = rtc_readl(rtc, timereg);
+		date = rtc_readl(rtc, calreg);
+	} while ((time != rtc_readl(rtc, timereg)) ||
+			(date != rtc_readl(rtc, calreg)));
 
 	tm->tm_sec  = bcd2bin((time & AT91_RTC_SEC) >> 0);
 	tm->tm_min  = bcd2bin((time & AT91_RTC_MIN) >> 8);
@@ -60,7 +71,7 @@ static void at91_rtc_decodetime(unsigned int timereg, unsigned int calreg,
 	/*
 	 * The Calendar Alarm register does not have a field for
 	 * the year - so these will return an invalid value.  When an
-	 * alarm is set, at91_alarm_year will store the current year.
+	 * alarm is set, rtc->alarm_year will store the current year.
 	 */
 	tm->tm_year  = bcd2bin(date & AT91_RTC_CENT) * 100;	/* century */
 	tm->tm_year += bcd2bin((date & AT91_RTC_YEAR) >> 8);	/* year */
@@ -75,7 +86,9 @@ static void at91_rtc_decodetime(unsigned int timereg, unsigned int calreg,
  */
 static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 {
-	at91_rtc_decodetime(AT91_RTC_TIMR, AT91_RTC_CALR, tm);
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
+
+	at91_rtc_decodetime(rtc, AT91_RTC_TIMR, AT91_RTC_CALR, tm);
 	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 	tm->tm_year = tm->tm_year - 1900;
 
@@ -91,6 +104,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
  */
 static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
 	unsigned long cr;
 
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
@@ -98,19 +112,19 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	/* Stop Time/Calendar from counting */
-	cr = at91_sys_read(AT91_RTC_CR);
-	at91_sys_write(AT91_RTC_CR, cr | AT91_RTC_UPDCAL | AT91_RTC_UPDTIM);
+	cr = rtc_readl(rtc, AT91_RTC_CR);
+	rtc_writel(rtc, AT91_RTC_CR, cr | AT91_RTC_UPDCAL | AT91_RTC_UPDTIM);
 
-	at91_sys_write(AT91_RTC_IER, AT91_RTC_ACKUPD);
+	rtc_writel(rtc, AT91_RTC_IER, AT91_RTC_ACKUPD);
 	wait_for_completion(&at91_rtc_updated);	/* wait for ACKUPD interrupt */
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ACKUPD);
+	rtc_writel(rtc, AT91_RTC_IDR, AT91_RTC_ACKUPD);
 
-	at91_sys_write(AT91_RTC_TIMR,
+	rtc_writel(rtc, AT91_RTC_TIMR,
 			  bin2bcd(tm->tm_sec) << 0
 			| bin2bcd(tm->tm_min) << 8
 			| bin2bcd(tm->tm_hour) << 16);
 
-	at91_sys_write(AT91_RTC_CALR,
+	rtc_writel(rtc, AT91_RTC_CALR,
 			  bin2bcd((tm->tm_year + 1900) / 100)	/* century */
 			| bin2bcd(tm->tm_year % 100) << 8	/* year */
 			| bin2bcd(tm->tm_mon + 1) << 16		/* tm_mon starts@zero */
@@ -118,8 +132,8 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 			| bin2bcd(tm->tm_mday) << 24);
 
 	/* Restart Time/Calendar */
-	cr = at91_sys_read(AT91_RTC_CR);
-	at91_sys_write(AT91_RTC_CR, cr & ~(AT91_RTC_UPDCAL | AT91_RTC_UPDTIM));
+	cr = rtc_readl(rtc, AT91_RTC_CR);
+	rtc_writel(rtc, AT91_RTC_CR, cr & ~(AT91_RTC_UPDCAL | AT91_RTC_UPDTIM));
 
 	return 0;
 }
@@ -129,13 +143,14 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
  */
 static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time;
 
-	at91_rtc_decodetime(AT91_RTC_TIMALR, AT91_RTC_CALALR, tm);
+	at91_rtc_decodetime(rtc, AT91_RTC_TIMALR, AT91_RTC_CALALR, tm);
 	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
-	tm->tm_year = at91_alarm_year - 1900;
+	tm->tm_year = rtc->alarm_year - 1900;
 
-	alrm->enabled = (at91_sys_read(AT91_RTC_IMR) & AT91_RTC_ALARM)
+	alrm->enabled = (rtc_readl(rtc, AT91_RTC_IMR) & AT91_RTC_ALARM)
 			? 1 : 0;
 
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
@@ -150,34 +165,35 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
  */
 static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time tm;
 
-	at91_rtc_decodetime(AT91_RTC_TIMR, AT91_RTC_CALR, &tm);
+	at91_rtc_decodetime(rtc, AT91_RTC_TIMR, AT91_RTC_CALR, &tm);
 
-	at91_alarm_year = tm.tm_year;
+	rtc->alarm_year = tm.tm_year;
 
 	tm.tm_hour = alrm->time.tm_hour;
 	tm.tm_min = alrm->time.tm_min;
 	tm.tm_sec = alrm->time.tm_sec;
 
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ALARM);
-	at91_sys_write(AT91_RTC_TIMALR,
+	rtc_writel(rtc, AT91_RTC_IDR, AT91_RTC_ALARM);
+	rtc_writel(rtc, AT91_RTC_TIMALR,
 		  bin2bcd(tm.tm_sec) << 0
 		| bin2bcd(tm.tm_min) << 8
 		| bin2bcd(tm.tm_hour) << 16
 		| AT91_RTC_HOUREN | AT91_RTC_MINEN | AT91_RTC_SECEN);
-	at91_sys_write(AT91_RTC_CALALR,
+	rtc_writel(rtc, AT91_RTC_CALALR,
 		  bin2bcd(tm.tm_mon + 1) << 16		/* tm_mon starts@zero */
 		| bin2bcd(tm.tm_mday) << 24
 		| AT91_RTC_DATEEN | AT91_RTC_MTHEN);
 
 	if (alrm->enabled) {
-		at91_sys_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
-		at91_sys_write(AT91_RTC_IER, AT91_RTC_ALARM);
+		rtc_writel(rtc, AT91_RTC_SCCR, AT91_RTC_ALARM);
+		rtc_writel(rtc, AT91_RTC_IER, AT91_RTC_ALARM);
 	}
 
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		at91_alarm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour,
+		rtc->alarm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour,
 		tm.tm_min, tm.tm_sec);
 
 	return 0;
@@ -185,13 +201,15 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int at91_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
+
 	pr_debug("%s(): cmd=%08x\n", __func__, enabled);
 
 	if (enabled) {
-		at91_sys_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
-		at91_sys_write(AT91_RTC_IER, AT91_RTC_ALARM);
+		rtc_writel(rtc, AT91_RTC_SCCR, AT91_RTC_ALARM);
+		rtc_writel(rtc, AT91_RTC_IER, AT91_RTC_ALARM);
 	} else
-		at91_sys_write(AT91_RTC_IDR, AT91_RTC_ALARM);
+		rtc_writel(rtc, AT91_RTC_IDR, AT91_RTC_ALARM);
 
 	return 0;
 }
@@ -200,7 +218,9 @@ static int at91_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
  */
 static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	unsigned long imr = at91_sys_read(AT91_RTC_IMR);
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
+
+	unsigned long imr = rtc_readl(rtc, AT91_RTC_IMR);
 
 	seq_printf(seq, "update_IRQ\t: %s\n",
 			(imr & AT91_RTC_ACKUPD) ? "yes" : "no");
@@ -213,14 +233,13 @@ static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
 /*
  * IRQ handler for the RTC
  */
-static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
+static irqreturn_t at91_rtc_interrupt(int irq, void *dev)
 {
-	struct platform_device *pdev = dev_id;
-	struct rtc_device *rtc = platform_get_drvdata(pdev);
+	struct at91_rtc *rtc = dev;
 	unsigned int rtsr;
 	unsigned long events = 0;
 
-	rtsr = at91_sys_read(AT91_RTC_SR) & at91_sys_read(AT91_RTC_IMR);
+	rtsr = rtc_readl(rtc, AT91_RTC_SR) & rtc_readl(rtc, AT91_RTC_IMR);
 	if (rtsr) {		/* this interrupt is shared!  Is it ours? */
 		if (rtsr & AT91_RTC_ALARM)
 			events |= (RTC_AF | RTC_IRQF);
@@ -229,9 +248,9 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 		if (rtsr & AT91_RTC_ACKUPD)
 			complete(&at91_rtc_updated);
 
-		at91_sys_write(AT91_RTC_SCCR, rtsr);	/* clear status reg */
+		rtc_writel(rtc, AT91_RTC_SCCR, rtsr);	/* clear status reg */
 
-		rtc_update_irq(rtc, 1, events);
+		rtc_update_irq(rtc->rtcdev, 1, events);
 
 		pr_debug("%s(): num=%ld, events=0x%02lx\n", __func__,
 			events >> 8, events & 0x000000FF);
@@ -255,23 +274,37 @@ static const struct rtc_class_ops at91_rtc_ops = {
  */
 static int __init at91_rtc_probe(struct platform_device *pdev)
 {
-	struct rtc_device *rtc;
+	struct resource	*r;
+	struct at91_rtc	*rtc;
 	int ret;
 
-	at91_sys_write(AT91_RTC_CR, 0);
-	at91_sys_write(AT91_RTC_MR, 0);		/* 24 hour mode */
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	rtc = kzalloc(sizeof *rtc, GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rtc);
+	rtc->regbase = (void __force __iomem *) r->start;
+	rtc->alarm_year = AT91_RTC_EPOCH;
+
+	rtc_writel(rtc, AT91_RTC_CR, 0);
+	rtc_writel(rtc, AT91_RTC_MR, 0);	/* 24 hour mode */
 
 	/* Disable all interrupts */
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
+	rtc_writel(rtc, AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
 					AT91_RTC_SECEV | AT91_RTC_TIMEV |
 					AT91_RTC_CALEV);
 
 	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt,
 				IRQF_SHARED,
-				"at91_rtc", pdev);
+				"at91_rtc", rtc);
 	if (ret) {
 		printk(KERN_ERR "at91_rtc: IRQ %d already in use.\n",
 				AT91_ID_SYS);
+		kfree(rtc);
 		return ret;
 	}
 
@@ -281,13 +314,14 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	if (!device_can_wakeup(&pdev->dev))
 		device_init_wakeup(&pdev->dev, 1);
 
-	rtc = rtc_device_register(pdev->name, &pdev->dev,
+	rtc->rtcdev = rtc_device_register(pdev->name, &pdev->dev,
 				&at91_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
+	if (IS_ERR(rtc->rtcdev)) {
 		free_irq(AT91_ID_SYS, pdev);
-		return PTR_ERR(rtc);
+		ret = PTR_ERR(rtc->rtcdev);
+		kfree(rtc);
+		return ret;
 	}
-	platform_set_drvdata(pdev, rtc);
 
 	printk(KERN_INFO "AT91 Real Time Clock driver.\n");
 	return 0;
@@ -298,17 +332,17 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
  */
 static int __exit at91_rtc_remove(struct platform_device *pdev)
 {
-	struct rtc_device *rtc = platform_get_drvdata(pdev);
+	struct at91_rtc *rtc = platform_get_drvdata(pdev);
 
 	/* Disable all interrupts */
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
+	rtc_writel(rtc, AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
 					AT91_RTC_SECEV | AT91_RTC_TIMEV |
 					AT91_RTC_CALEV);
 	free_irq(AT91_ID_SYS, pdev);
 
-	rtc_device_unregister(rtc);
+	rtc_device_unregister(rtc->rtcdev);
 	platform_set_drvdata(pdev, NULL);
-
+	kfree(rtc);
 	return 0;
 }
 
@@ -320,27 +354,31 @@ static u32 at91_rtc_imr;
 
 static int at91_rtc_suspend(struct device *dev)
 {
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
+
 	/* this IRQ is shared with DBGU and other hardware which isn't
 	 * necessarily doing PM like we are...
 	 */
-	at91_rtc_imr = at91_sys_read(AT91_RTC_IMR)
+	at91_rtc_imr = rtc_readl(rtc, AT91_RTC_IMR)
 			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
 	if (at91_rtc_imr) {
 		if (device_may_wakeup(dev))
 			enable_irq_wake(AT91_ID_SYS);
 		else
-			at91_sys_write(AT91_RTC_IDR, at91_rtc_imr);
+			rtc_writel(rtc, AT91_RTC_IDR, at91_rtc_imr);
 	}
 	return 0;
 }
 
 static int at91_rtc_resume(struct device *dev)
 {
+	struct at91_rtc *rtc = dev_get_drvdata(dev);
+
 	if (at91_rtc_imr) {
 		if (device_may_wakeup(dev))
 			disable_irq_wake(AT91_ID_SYS);
 		else
-			at91_sys_write(AT91_RTC_IER, at91_rtc_imr);
+			rtc_writel(rtc, AT91_RTC_IER, at91_rtc_imr);
 	}
 	return 0;
 }
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index a3ad957..6aaa7f6 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -307,8 +307,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 1);
 
 	platform_set_drvdata(pdev, rtc);
-	rtc->rtt = (void __force __iomem *) (AT91_VA_BASE_SYS - AT91_BASE_SYS);
-	rtc->rtt += r->start;
+	rtc->rtt = (void __force __iomem *) r->start;
 
 	mr = rtt_readl(rtc, MR);
 
