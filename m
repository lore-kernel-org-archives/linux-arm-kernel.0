From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 16 Feb 2014 18:34:07 +0100
Subject: [PATCH 2/2] ARM: SAMSUNG: remove all custom uncompress.h
In-Reply-To: <3594365.ORKU4Q2jDp@phil>
References: <3594365.ORKU4Q2jDp@phil>
Message-ID: <2212191.1gWzhui2bt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung platforms now use the generic uncompress.h so all the custom
ones can be removed.

Suggested-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-exynos/include/mach/uncompress.h  |  48 -------
 arch/arm/mach-s3c24xx/include/mach/uncompress.h |  57 --------
 arch/arm/mach-s3c64xx/include/mach/uncompress.h |  31 -----
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |  34 -----
 arch/arm/mach-s5pc100/include/mach/uncompress.h |  30 ----
 arch/arm/mach-s5pv210/include/mach/uncompress.h |  28 ----
 arch/arm/plat-samsung/include/plat/uncompress.h | 175 ------------------------
 7 files changed, 403 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/uncompress.h

diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
deleted file mode 100644
index 5d7ce36..0000000
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H __FILE__
-
-#include <asm/mach-types.h>
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static unsigned int __raw_readl(unsigned int ptr)
-{
-	return *((volatile unsigned int *)ptr);
-}
-
-static void arch_detect_cpu(void)
-{
-	u32 chip_id = __raw_readl(EXYNOS_PA_CHIPID);
-
-	/*
-	 * product_id is bits 31:12
-	 * bits 23:20 describe the exynosX family
-	 * bits 27:24 describe the exynosX family in exynos5420
-	 */
-	chip_id >>= 20;
-
-	if ((chip_id & 0x0f) == 0x5 || (chip_id & 0xf0) == 0x50)
-		uart_base = (volatile u8 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-	else
-		uart_base = (volatile u8 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-
-	/*
-	 * For preventing FIFO overrun or infinite loop of UART console,
-	 * fifo_max should be the minimum fifo size of all of the UART channels
-	 */
-	fifo_mask = S5PV210_UFSTAT_TXMASK;
-	fifo_max = 15 << S5PV210_UFSTAT_TXSHIFT;
-}
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/uncompress.h b/arch/arm/mach-s3c24xx/include/mach/uncompress.h
deleted file mode 100644
index 7d2ce20..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/uncompress.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/uncompress.h
- *
- * Copyright (c) 2003-2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/regs-gpio.h>
-#include <mach/map.h>
-
-/* working in physical space... */
-#undef S3C2410_GPIOREG
-#define S3C2410_GPIOREG(x) ((S3C24XX_PA_GPIO + (x)))
-
-#include <plat/uncompress.h>
-
-static inline int is_arm926(void)
-{
-	unsigned int cpuid;
-
-	asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r" (cpuid));
-
-	return ((cpuid & 0xff0) == 0x260);
-}
-
-static void arch_detect_cpu(void)
-{
-	unsigned int cpuid;
-
-	cpuid = *((volatile unsigned int *)S3C2410_GSTATUS1);
-	cpuid &= S3C2410_GSTATUS1_IDMASK;
-
-	if (is_arm926() || cpuid == S3C2410_GSTATUS1_2440 ||
-	    cpuid == S3C2410_GSTATUS1_2442 ||
-	    cpuid == S3C2410_GSTATUS1_2416 ||
-	    cpuid == S3C2410_GSTATUS1_2450) {
-		fifo_mask = S3C2440_UFSTAT_TXMASK;
-		fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
-	} else {
-		fifo_mask = S3C2410_UFSTAT_TXMASK;
-		fifo_max = 15 << S3C2410_UFSTAT_TXSHIFT;
-	}
-
-	uart_base = (volatile u8 *) S3C_PA_UART +
-		(S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/uncompress.h b/arch/arm/mach-s3c64xx/include/mach/uncompress.h
deleted file mode 100644
index 1c95673..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/uncompress.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* arch/arm/mach-s3c6400/include/mach/uncompress.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C6400 - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static void arch_detect_cpu(void)
-{
-	/* we do not need to do any cpu detection here at the moment. */
-	fifo_mask = S3C2440_UFSTAT_TXMASK;
-	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
-
-	uart_base = (volatile u8 *)S3C_PA_UART +
-		(S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
deleted file mode 100644
index bbcc3f6..0000000
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/uncompress.h
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5P64X0 - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static void arch_detect_cpu(void)
-{
-	unsigned int chipid;
-
-	chipid = *(const volatile unsigned int __force *) 0xE0100118;
-
-	if ((chipid & 0xff000) == 0x50000)
-		uart_base = (volatile u8 *)S5P6450_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
-	else
-		uart_base = (volatile u8 *)S5P6440_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
-
-	fifo_mask = S3C2440_UFSTAT_TXMASK;
-	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/uncompress.h b/arch/arm/mach-s5pc100/include/mach/uncompress.h
deleted file mode 100644
index 720e133..0000000
--- a/arch/arm/mach-s5pc100/include/mach/uncompress.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/uncompress.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - uncompress code
- *
- * Based on mach-s3c6400/include/mach/uncompress.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static void arch_detect_cpu(void)
-{
-	/* we do not need to do any cpu detection here at the moment. */
-	fifo_mask = S3C2440_UFSTAT_TXMASK;
-	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
-
-	uart_base = (volatile u8 *)S5P_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/uncompress.h b/arch/arm/mach-s5pv210/include/mach/uncompress.h
deleted file mode 100644
index 231cb07..0000000
--- a/arch/arm/mach-s5pv210/include/mach/uncompress.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/uncompress.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV210 - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static void arch_detect_cpu(void)
-{
-	/* we do not need to do any cpu detection here at the moment. */
-	fifo_mask = S5PV210_UFSTAT_TXMASK;
-	fifo_max = 63 << S5PV210_UFSTAT_TXSHIFT;
-
-	uart_base = (volatile u8 *)S5P_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
deleted file mode 100644
index f48dc0a..0000000
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ /dev/null
@@ -1,175 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/uncompress.h
- *
- * Copyright 2003, 2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_PLAT_UNCOMPRESS_H
-#define __ASM_PLAT_UNCOMPRESS_H
-
-typedef unsigned int upf_t;	/* cannot include linux/serial_core.h */
-
-/* uart setup */
-
-unsigned int fifo_mask;
-unsigned int fifo_max;
-
-volatile u8 *uart_base;
-
-/* forward declerations */
-
-static void arch_detect_cpu(void);
-
-/* defines for UART registers */
-
-#include <plat/regs-serial.h>
-
-/* working in physical space... */
-#define S3C_WDOGREG(x)	((S3C_PA_WDT + (x)))
-
-#define S3C2410_WTCON	S3C_WDOGREG(0x00)
-#define S3C2410_WTDAT	S3C_WDOGREG(0x04)
-#define S3C2410_WTCNT	S3C_WDOGREG(0x08)
-
-#define S3C2410_WTCON_RSTEN	(1 << 0)
-#define S3C2410_WTCON_ENABLE	(1 << 5)
-
-#define S3C2410_WTCON_DIV128	(3 << 3)
-
-#define S3C2410_WTCON_PRESCALE(x)	((x) << 8)
-
-/* how many bytes we allow into the FIFO@a time in FIFO mode */
-#define FIFO_MAX	 (14)
-
-static __inline__ void
-uart_wr(unsigned int reg, unsigned int val)
-{
-	volatile unsigned int *ptr;
-
-	ptr = (volatile unsigned int *)(reg + uart_base);
-	*ptr = val;
-}
-
-static __inline__ unsigned int
-uart_rd(unsigned int reg)
-{
-	volatile unsigned int *ptr;
-
-	ptr = (volatile unsigned int *)(reg + uart_base);
-	return *ptr;
-}
-
-/* we can deal with the case the UARTs are being run
- * in FIFO mode, so that we don't hold up our execution
- * waiting for tx to happen...
-*/
-
-static void putc(int ch)
-{
-	if (!config_enabled(CONFIG_DEBUG_LL))
-		return;
-
-	if (uart_rd(S3C2410_UFCON) & S3C2410_UFCON_FIFOMODE) {
-		int level;
-
-		while (1) {
-			level = uart_rd(S3C2410_UFSTAT);
-			level &= fifo_mask;
-
-			if (level < fifo_max)
-				break;
-		}
-
-	} else {
-		/* not using fifos */
-
-		while ((uart_rd(S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE) != S3C2410_UTRSTAT_TXE)
-			barrier();
-	}
-
-	/* write byte to transmission register */
-	uart_wr(S3C2410_UTXH, ch);
-}
-
-static inline void flush(void)
-{
-}
-
-#define __raw_writel(d, ad)			\
-	do {							\
-		*((volatile unsigned int __force *)(ad)) = (d); \
-	} while (0)
-
-#ifdef CONFIG_S3C_BOOT_ERROR_RESET
-
-static void arch_decomp_error(const char *x)
-{
-	putstr("\n\n");
-	putstr(x);
-	putstr("\n\n -- System resetting\n");
-
-	__raw_writel(0x4000, S3C2410_WTDAT);
-	__raw_writel(0x4000, S3C2410_WTCNT);
-	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128 | S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x40), S3C2410_WTCON);
-
-	while(1);
-}
-
-#define arch_error arch_decomp_error
-#endif
-
-#ifdef CONFIG_S3C_BOOT_UART_FORCE_FIFO
-static inline void arch_enable_uart_fifo(void)
-{
-	u32 fifocon;
-
-	if (!config_enabled(CONFIG_DEBUG_LL))
-		return;
-
-	fifocon = uart_rd(S3C2410_UFCON);
-
-	if (!(fifocon & S3C2410_UFCON_FIFOMODE)) {
-		fifocon |= S3C2410_UFCON_RESETBOTH;
-		uart_wr(S3C2410_UFCON, fifocon);
-
-		/* wait for fifo reset to complete */
-		while (1) {
-			fifocon = uart_rd(S3C2410_UFCON);
-			if (!(fifocon & S3C2410_UFCON_RESETBOTH))
-				break;
-		}
-
-		uart_wr(S3C2410_UFCON, S3C2410_UFCON_FIFOMODE);
-	}
-}
-#else
-#define arch_enable_uart_fifo() do { } while(0)
-#endif
-
-
-static void
-arch_decomp_setup(void)
-{
-	/* we may need to setup the uart(s) here if we are not running
-	 * on an BAST... the BAST will have left the uarts configured
-	 * after calling linux.
-	 */
-
-	arch_detect_cpu();
-
-	/* Enable the UART FIFOs if they where not enabled and our
-	 * configuration says we should turn them on.
-	 */
-
-	arch_enable_uart_fifo();
-}
-
-
-#endif /* __ASM_PLAT_UNCOMPRESS_H */
-- 
1.8.5.3
