From: avictor.za@gmail.com (Andrew Victor)
Date: Sun, 01 May 2011 23:24:39 +0200
Subject: AT91: DBGU definitions are processor-dependent
Message-ID: <1304285079.22966.7.camel@redbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For supporting multiple AT91 processors in a single kernel image, the
following changes:
 * rename AT91_DBGU to AT91xxx_DBGU to indicate they're
processor-dependent
 * add at91_sram_size() macro in cpu.h.

Unfortunately we still need (for now ) a compatibility AT91_DBGU
definition for the CPU detection (cpu.h) and the uncompressor and
early-kernel debugging (debug-macro.S)


Signed-off-by: Andrew Victor <linux@maxim.org.za>


diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 9e7e513..e012f3a 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -660,8 +660,8 @@ static void __init at91_add_device_watchdog(void) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT572D940HF_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT572D940HF_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -674,7 +674,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT572D940HF_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 4933306..18039ed 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -1037,8 +1037,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91CAP9_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91CAP9_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -1051,7 +1051,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91CAP9_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index af4e30a..70ab781 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -889,8 +889,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91RM9200_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91RM9200_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -903,7 +903,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91RM9200_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index cc0abc5..24e0c84 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -291,11 +291,9 @@ static void at91sam9260_poweroff(void)
 
 static void __init at91sam9xe_initialize(void)
 {
-	unsigned long cidr, sram_size;
+	unsigned long sram_size;
 
-	cidr = at91_sys_read(AT91_DBGU_CIDR);
-
-	switch (cidr & AT91_CIDR_SRAMSIZ) {
+	switch (at91_sram_size()) {
 		case AT91_CIDR_SRAMSIZ_32K:
 			sram_size = 2 * SZ_16K;
 			break;
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 1291e58..72d3fa6 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -850,8 +850,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9260_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9260_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -864,7 +864,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91SAM9260_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index c0bfcb6..dc8bfc3 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -827,8 +827,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9261_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9261_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -841,7 +841,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91SAM9261_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 0fbbba9..6f79f1f 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1208,8 +1208,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9263_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9263_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -1222,7 +1222,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91SAM9263_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 89df938..392fde2 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1331,8 +1331,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9G45_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9G45_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -1345,7 +1345,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91SAM9G45_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 2e39f88..d0c1506 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -254,14 +254,12 @@ static void at91sam9rl_poweroff(void)
 
 void __init at91sam9rl_initialize(unsigned long main_clock)
 {
-	unsigned long cidr, sram_size;
+	unsigned long sram_size;
 
 	/* Map peripherals */
 	iotable_init(at91sam9rl_io_desc, ARRAY_SIZE(at91sam9rl_io_desc));
 
-	cidr = at91_sys_read(AT91_DBGU_CIDR);
-
-	switch (cidr & AT91_CIDR_SRAMSIZ) {
+	switch (at91_sram_size()) {
 		case AT91_CIDR_SRAMSIZ_32K:
 			sram_size = 2 * SZ_16K;
 			break;
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index fbccccb..ee013c1 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -937,8 +937,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_VA_BASE_SYS + AT91SAM9RL_DBGU,
+		.end	= AT91_VA_BASE_SYS + AT91SAM9RL_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -951,7 +951,7 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91SAM9RL_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/include/mach/at572d940hf.h b/arch/arm/mach-at91/include/mach/at572d940hf.h
index 6dc66ab..fc97be0 100644
--- a/arch/arm/mach-at91/include/mach/at572d940hf.h
+++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
@@ -93,7 +93,7 @@
 #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
+#define AT572D940HF_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT572D940HF_PIOA	(0xfffff400 - AT91_BASE_SYS)
 #define AT572D940HF_PIOB	(0xfffff600 - AT91_BASE_SYS)
 #define AT572D940HF_PIOC	(0xfffff800 - AT91_BASE_SYS)
@@ -103,6 +103,7 @@
 #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
 #define AT572D940HF_WDT		(0xfffffd40 - AT91_BASE_SYS)
 
+#define AT91_DBGU	AT572D940HF_DBGU
 #define AT91_USART0	AT572D940HF_BASE_US0
 #define AT91_USART1	AT572D940HF_BASE_US1
 #define AT91_USART2	AT572D940HF_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91_dbgu.h b/arch/arm/mach-at91/include/mach/at91_dbgu.h
index 6dcaa77..1987ae1 100644
--- a/arch/arm/mach-at91/include/mach/at91_dbgu.h
+++ b/arch/arm/mach-at91/include/mach/at91_dbgu.h
@@ -17,21 +17,21 @@
 #define AT91_DBGU_H
 
 #ifdef AT91_DBGU
-#define AT91_DBGU_CR		(AT91_DBGU + 0x00)	/* Control Register */
-#define AT91_DBGU_MR		(AT91_DBGU + 0x04)	/* Mode Register */
-#define AT91_DBGU_IER		(AT91_DBGU + 0x08)	/* Interrupt Enable Register */
+#define AT91_DBGU_CR		0x00	/* Control Register */
+#define AT91_DBGU_MR		0x04	/* Mode Register */
+#define AT91_DBGU_IER		0x08	/* Interrupt Enable Register */
 #define		AT91_DBGU_TXRDY		(1 << 1)		/* Transmitter Ready */
 #define		AT91_DBGU_TXEMPTY	(1 << 9)		/* Transmitter Empty */
-#define AT91_DBGU_IDR		(AT91_DBGU + 0x0c)	/* Interrupt Disable Register */
-#define AT91_DBGU_IMR		(AT91_DBGU + 0x10)	/* Interrupt Mask Register */
-#define AT91_DBGU_SR		(AT91_DBGU + 0x14)	/* Status Register */
-#define AT91_DBGU_RHR		(AT91_DBGU + 0x18)	/* Receiver Holding Register */
-#define AT91_DBGU_THR		(AT91_DBGU + 0x1c)	/* Transmitter Holding Register */
-#define AT91_DBGU_BRGR		(AT91_DBGU + 0x20)	/* Baud Rate Generator Register */
+#define AT91_DBGU_IDR		0x0c	/* Interrupt Disable Register */
+#define AT91_DBGU_IMR		0x10	/* Interrupt Mask Register */
+#define AT91_DBGU_SR		0x14	/* Status Register */
+#define AT91_DBGU_RHR		0x18	/* Receiver Holding Register */
+#define AT91_DBGU_THR		0x1c	/* Transmitter Holding Register */
+#define AT91_DBGU_BRGR		0x20	/* Baud Rate Generator Register */
 
-#define AT91_DBGU_CIDR		(AT91_DBGU + 0x40)	/* Chip ID Register */
-#define AT91_DBGU_EXID		(AT91_DBGU + 0x44)	/* Chip ID Extension Register */
-#define AT91_DBGU_FNR		(AT91_DBGU + 0x48)	/* Force NTRST Register [SAM9 only] */
+#define AT91_DBGU_CIDR		0x40	/* Chip ID Register */
+#define AT91_DBGU_EXID		0x44	/* Chip ID Extension Register */
+#define AT91_DBGU_FNR		0x48	/* Force NTRST Register [SAM9 only] */
 #define		AT91_DBGU_FNTRST	(1 << 0)		/* Force NTRST */
 
 #endif /* AT91_DBGU */
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index 4b52d71..80566f6 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -89,7 +89,7 @@
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
 #define AT91CAP9_CCFG	(0xffffeb10 - AT91_BASE_SYS)
 #define AT91CAP9_DMA	(0xffffec00 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
+#define AT91CAP9_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91CAP9_PIOA	(0xfffff200 - AT91_BASE_SYS)
 #define AT91CAP9_PIOB	(0xfffff400 - AT91_BASE_SYS)
@@ -105,6 +105,7 @@
 			(0xfffffd50 - AT91_BASE_SYS) :	\
 			(0xfffffd60 - AT91_BASE_SYS))
 
+#define AT91_DBGU	AT91CAP9_DBGU
 #define AT91_USART0	AT91CAP9_BASE_US0
 #define AT91_USART1	AT91CAP9_BASE_US1
 #define AT91_USART2	AT91CAP9_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index f81a976..f6eec4f 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -83,7 +83,7 @@
  * System Peripherals (offset from AT91_BASE_SYS)
  */
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)	/* Advanced Interrupt Controller */
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)	/* Debug Unit */
+#define AT91RM9200_DBGU	(0xfffff200 - AT91_BASE_SYS)	/* Debug Unit */
 #define AT91RM9200_PIOA	(0xfffff400 - AT91_BASE_SYS)	/* PIO Controller A */
 #define AT91RM9200_PIOB	(0xfffff600 - AT91_BASE_SYS)	/* PIO Controller B */
 #define AT91RM9200_PIOC	(0xfffff800 - AT91_BASE_SYS)	/* PIO Controller C */
@@ -93,6 +93,7 @@
 #define AT91RM9200_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
 #define AT91_MC		(0xffffff00 - AT91_BASE_SYS)	/* Memory Controllers */
 
+#define AT91_DBGU	AT91RM9200_DBGU
 #define AT91_USART0	AT91RM9200_BASE_US0
 #define AT91_USART1	AT91RM9200_BASE_US1
 #define AT91_USART2	AT91RM9200_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 969c479..11a7920 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -89,7 +89,7 @@
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91SAM9260_CCFG	(0xffffef10 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
+#define AT91SAM9260_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91SAM9260_PIOA	(0xfffff400 - AT91_BASE_SYS)
 #define AT91SAM9260_PIOB	(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9260_PIOC	(0xfffff800 - AT91_BASE_SYS)
@@ -101,6 +101,7 @@
 #define AT91SAM9260_WDT		(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
+#define AT91_DBGU	AT91SAM9260_DBGU
 #define AT91_USART0	AT91SAM9260_BASE_US0
 #define AT91_USART1	AT91SAM9260_BASE_US1
 #define AT91_USART2	AT91SAM9260_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index 5ff812f..10565f3 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -72,7 +72,7 @@
 #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
+#define AT91SAM9261_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91SAM9261_PIOA	(0xfffff400 - AT91_BASE_SYS)
 #define AT91SAM9261_PIOB	(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9261_PIOC	(0xfffff800 - AT91_BASE_SYS)
@@ -84,6 +84,7 @@
 #define AT91SAM9261_WDT		(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
+#define AT91_DBGU	AT91SAM9261_DBGU
 #define AT91_USART0	AT91SAM9261_BASE_US0
 #define AT91_USART1	AT91SAM9261_BASE_US1
 #define AT91_USART2	AT91SAM9261_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index 3e879c9..30598de 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -85,7 +85,7 @@
 #define AT91_SMC1	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
 #define AT91SAM9263_CCFG	(0xffffed10 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
+#define AT91SAM9263_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91SAM9263_PIOA	(0xfffff200 - AT91_BASE_SYS)
 #define AT91SAM9263_PIOB	(0xfffff400 - AT91_BASE_SYS)
@@ -101,6 +101,7 @@
 #define AT91SAM9263_RTT1	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
+#define AT91_DBGU	AT91SAM9263_DBGU
 #define AT91_USART0	AT91SAM9263_BASE_US0
 #define AT91_USART1	AT91SAM9263_BASE_US1
 #define AT91_USART2	AT91SAM9263_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index ea3923e..6e3639e 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -95,7 +95,7 @@
 #define AT91_SMC	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
 #define AT91SAM9G45_DMA		(0xffffec00 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
+#define AT91SAM9G45_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91SAM9G45_PIOA	(0xfffff200 - AT91_BASE_SYS)
 #define AT91SAM9G45_PIOB	(0xfffff400 - AT91_BASE_SYS)
@@ -111,6 +111,7 @@
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91SAM9G45_RTC		(0xfffffdb0 - AT91_BASE_SYS)
 
+#define AT91_DBGU	AT91SAM9G45_DBGU
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
 #define AT91_USART2	AT91SAM9G45_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index ac3ce5a..6d11e5a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -79,7 +79,7 @@
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
 #define AT91SAM9RL_CCFG		(0xffffef10 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
-#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
+#define AT91SAM9RL_DBGU		(0xfffff200 - AT91_BASE_SYS)
 #define AT91SAM9RL_PIOA		(0xfffff400 - AT91_BASE_SYS)
 #define AT91SAM9RL_PIOB		(0xfffff600 - AT91_BASE_SYS)
 #define AT91SAM9RL_PIOC		(0xfffff800 - AT91_BASE_SYS)
@@ -94,6 +94,7 @@
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91SAM9RL_RTC		(0xfffffe00 - AT91_BASE_SYS)
 
+#define AT91_DBGU	AT91SAM9RL_DBGU
 #define AT91_USART0	AT91SAM9RL_BASE_US0
 #define AT91_USART1	AT91SAM9RL_BASE_US1
 #define AT91_USART2	AT91SAM9RL_BASE_US2
diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
index a2a9f86..a93d473 100644
--- a/arch/arm/mach-at91/include/mach/at91x40.h
+++ b/arch/arm/mach-at91/include/mach/at91x40.h
@@ -49,8 +49,9 @@
  * But it does have a chip identify register and extension ID, so define at
  * least these here.
  */
-#define AT91_DBGU_CIDR	(AT91X40_SF + 0)	/* CIDR in PS segment */
-#define AT91_DBGU_EXID	(AT91X40_SF + 4)	/* EXID in PS segment */
+#define AT91_DBGU	AT91X40_SF
+#define AT91_DBGU_CIDR	0x00	/* CIDR in PS segment */
+#define AT91_DBGU_EXID	0x04	/* EXID in PS segment */
 
 /*
  * Support defines for the simple Power Controller module.
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index b488a4c..521d8ed 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -42,12 +42,12 @@
 
 static inline unsigned long at91_cpu_identify(void)
 {
-	return (at91_sys_read(AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
+	return (at91_sys_read(AT91_DBGU + AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
 }
 
 static inline unsigned long at91_cpu_fully_identify(void)
 {
-	return at91_sys_read(AT91_DBGU_CIDR);
+	return at91_sys_read(AT91_DBGU + AT91_DBGU_CIDR);
 }
 
 #define ARCH_EXID_AT91SAM9M11	0x00000001
@@ -57,7 +57,7 @@ static inline unsigned long at91_cpu_fully_identify(void)
 
 static inline unsigned long at91_exid_identify(void)
 {
-	return at91_sys_read(AT91_DBGU_EXID);
+	return at91_sys_read(AT91_DBGU + AT91_DBGU_EXID);
 }
 
 
@@ -67,7 +67,12 @@ static inline unsigned long at91_exid_identify(void)
 
 static inline unsigned long at91_arch_identify(void)
 {
-	return (at91_sys_read(AT91_DBGU_CIDR) & AT91_CIDR_ARCH);
+	return (at91_sys_read(AT91_DBGU + AT91_DBGU_CIDR) & AT91_CIDR_ARCH);
+}
+
+static inline unsigned long at91_sram_size(void)
+{
+	return (at91_sys_read(AT91_DBGU + AT91_DBGU_CIDR) & AT91_CIDR_SRAMSIZ);
 }
 
 #ifdef CONFIG_ARCH_AT91CAP9
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index 0f959fa..b12ed99 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -20,17 +20,17 @@
 	.endm
 
 	.macro	senduart,rd,rx
-	strb	\rd, [\rx, #(AT91_DBGU_THR - AT91_DBGU)]	@ Write to Transmitter Holding Register
+	strb	\rd, [\rx, #(AT91_DBGU_THR)]			@ Write to Transmitter Holding Register
 	.endm
 
 	.macro	waituart,rd,rx
-1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR - AT91_DBGU)]		@ Read Status Register
+1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR)]			@ Read Status Register
 	tst	\rd, #AT91_DBGU_TXRDY				@ DBGU_TXRDY = 1 when ready to transmit
 	beq	1001b
 	.endm
 
 	.macro	busyuart,rd,rx
-1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR - AT91_DBGU)]		@ Read Status Register
+1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR)]			@ Read Status Register
 	tst	\rd, #AT91_DBGU_TXEMPTY				@ DBGU_TXEMPTY = 1 when transmission complete
 	beq	1001b
 	.endm
