From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 Feb 2014 17:26:08 +0900
Subject: [PATCH 01/03] ARM: shmobile: Remove legacy EMEV2 SoC support
In-Reply-To: <20140213082558.30630.93034.sendpatchset@w520>
References: <20140213082558.30630.93034.sendpatchset@w520>
Message-ID: <20140213082608.30630.40000.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Get rid of legacy EMEV2 SoC code including the legacy clock
framework implementation. The multiplatform implementation
together with DT board support shall be used instead.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile                  |    3 
 arch/arm/mach-shmobile/Kconfig              |    9 -
 arch/arm/mach-shmobile/Makefile             |    1 
 arch/arm/mach-shmobile/clock-emev2.c        |  231 ---------------------------
 arch/arm/mach-shmobile/include/mach/emev2.h |    1 
 arch/arm/mach-shmobile/setup-emev2.c        |    4 
 6 files changed, 1 insertion(+), 248 deletions(-)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2014-02-05 18:26:25.000000000 +0900
@@ -242,8 +242,7 @@ dtb-$(CONFIG_ARCH_U8500) += ste-snowball
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
 	s3c6410-smdk6410.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
-	r7s72100-genmai.dtb \
+dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
 	r7s72100-genmai-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
--- 0009/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-02-05 18:21:28.000000000 +0900
@@ -139,15 +139,6 @@ config ARCH_R8A7791
 	select RENESAS_IRQC
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
-config ARCH_EMEV2
-	bool "Emma Mobile EV2"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_GIC
-	select CPU_V7
-	select MIGHT_HAVE_PCI
-	select USE_OF
-	select AUTO_ZRELADDR
-
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-02-05 18:21:28.000000000 +0900
@@ -31,7 +31,6 @@ obj-$(CONFIG_ARCH_R8A7778)	+= clock-r8a7
 obj-$(CONFIG_ARCH_R8A7779)	+= clock-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= clock-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= clock-r8a7791.o
-obj-$(CONFIG_ARCH_EMEV2)	+= clock-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= clock-r7s72100.o
 endif
 
--- 0001/arch/arm/mach-shmobile/clock-emev2.c
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,231 +0,0 @@
-/*
- * Emma Mobile EV2 clock framework support
- *
- * Copyright (C) 2012  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/sh_clk.h>
-#include <linux/clkdev.h>
-#include <mach/common.h>
-
-#define EMEV2_SMU_BASE 0xe0110000
-
-/* EMEV2 SMU registers */
-#define USIAU0_RSTCTRL 0x094
-#define USIBU1_RSTCTRL 0x0ac
-#define USIBU2_RSTCTRL 0x0b0
-#define USIBU3_RSTCTRL 0x0b4
-#define STI_RSTCTRL 0x124
-#define USIAU0GCLKCTRL 0x4a0
-#define USIBU1GCLKCTRL 0x4b8
-#define USIBU2GCLKCTRL 0x4bc
-#define USIBU3GCLKCTRL 0x04c0
-#define STIGCLKCTRL 0x528
-#define USIAU0SCLKDIV 0x61c
-#define USIB2SCLKDIV 0x65c
-#define USIB3SCLKDIV 0x660
-#define STI_CLKSEL 0x688
-
-/* not pretty, but hey */
-static void __iomem *smu_base;
-
-static void emev2_smu_write(unsigned long value, int offs)
-{
-	BUG_ON(!smu_base || (offs >= PAGE_SIZE));
-	iowrite32(value, smu_base + offs);
-}
-
-static struct clk_mapping smu_mapping = {
-	.phys	= EMEV2_SMU_BASE,
-	.len	= PAGE_SIZE,
-};
-
-/* Fixed 32 KHz root clock from C32K pin */
-static struct clk c32k_clk = {
-	.rate           = 32768,
-	.mapping	= &smu_mapping,
-};
-
-/* PLL3 multiplies C32K with 7000 */
-static unsigned long pll3_recalc(struct clk *clk)
-{
-	return clk->parent->rate * 7000;
-}
-
-static struct sh_clk_ops pll3_clk_ops = {
-	.recalc		= pll3_recalc,
-};
-
-static struct clk pll3_clk = {
-	.ops		= &pll3_clk_ops,
-	.parent		= &c32k_clk,
-};
-
-static struct clk *main_clks[] = {
-	&c32k_clk,
-	&pll3_clk,
-};
-
-enum { SCLKDIV_USIAU0, SCLKDIV_USIBU2, SCLKDIV_USIBU1, SCLKDIV_USIBU3,
-	SCLKDIV_NR };
-
-#define SCLKDIV(_reg, _shift)			\
-{								\
-	.parent		= &pll3_clk,				\
-	.enable_reg	= IOMEM(EMEV2_SMU_BASE + (_reg)),	\
-	.enable_bit	= _shift,				\
-}
-
-static struct clk sclkdiv_clks[SCLKDIV_NR] = {
-	[SCLKDIV_USIAU0] = SCLKDIV(USIAU0SCLKDIV, 0),
-	[SCLKDIV_USIBU2] = SCLKDIV(USIB2SCLKDIV, 16),
-	[SCLKDIV_USIBU1] = SCLKDIV(USIB2SCLKDIV, 0),
-	[SCLKDIV_USIBU3] = SCLKDIV(USIB3SCLKDIV, 0),
-};
-
-enum { GCLK_USIAU0_SCLK, GCLK_USIBU1_SCLK, GCLK_USIBU2_SCLK, GCLK_USIBU3_SCLK,
-	GCLK_STI_SCLK,
-	GCLK_NR };
-
-#define GCLK_SCLK(_parent, _reg) \
-{								\
-	.parent		= _parent,				\
-	.enable_reg	= IOMEM(EMEV2_SMU_BASE + (_reg)),	\
-	.enable_bit	= 1, /* SCLK_GCC */			\
-}
-
-static struct clk gclk_clks[GCLK_NR] = {
-	[GCLK_USIAU0_SCLK] = GCLK_SCLK(&sclkdiv_clks[SCLKDIV_USIAU0],
-				       USIAU0GCLKCTRL),
-	[GCLK_USIBU1_SCLK] = GCLK_SCLK(&sclkdiv_clks[SCLKDIV_USIBU1],
-				       USIBU1GCLKCTRL),
-	[GCLK_USIBU2_SCLK] = GCLK_SCLK(&sclkdiv_clks[SCLKDIV_USIBU2],
-				       USIBU2GCLKCTRL),
-	[GCLK_USIBU3_SCLK] = GCLK_SCLK(&sclkdiv_clks[SCLKDIV_USIBU3],
-				       USIBU3GCLKCTRL),
-	[GCLK_STI_SCLK] = GCLK_SCLK(&c32k_clk, STIGCLKCTRL),
-};
-
-static int emev2_gclk_enable(struct clk *clk)
-{
-	iowrite32(ioread32(clk->mapped_reg) | (1 << clk->enable_bit),
-		  clk->mapped_reg);
-	return 0;
-}
-
-static void emev2_gclk_disable(struct clk *clk)
-{
-	iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
-		  clk->mapped_reg);
-}
-
-static struct sh_clk_ops emev2_gclk_clk_ops = {
-	.enable		= emev2_gclk_enable,
-	.disable	= emev2_gclk_disable,
-	.recalc		= followparent_recalc,
-};
-
-static int __init emev2_gclk_register(struct clk *clks, int nr)
-{
-	struct clk *clkp;
-	int ret = 0;
-	int k;
-
-	for (k = 0; !ret && (k < nr); k++) {
-		clkp = clks + k;
-		clkp->ops = &emev2_gclk_clk_ops;
-		ret |= clk_register(clkp);
-	}
-
-	return ret;
-}
-
-static unsigned long emev2_sclkdiv_recalc(struct clk *clk)
-{
-	unsigned int sclk_div;
-
-	sclk_div = (ioread32(clk->mapped_reg) >> clk->enable_bit) & 0xff;
-
-	return clk->parent->rate / (sclk_div + 1);
-}
-
-static struct sh_clk_ops emev2_sclkdiv_clk_ops = {
-	.recalc		= emev2_sclkdiv_recalc,
-};
-
-static int __init emev2_sclkdiv_register(struct clk *clks, int nr)
-{
-	struct clk *clkp;
-	int ret = 0;
-	int k;
-
-	for (k = 0; !ret && (k < nr); k++) {
-		clkp = clks + k;
-		clkp->ops = &emev2_sclkdiv_clk_ops;
-		ret |= clk_register(clkp);
-	}
-
-	return ret;
-}
-
-static struct clk_lookup lookups[] = {
-	CLKDEV_DEV_ID("serial8250-em.0", &gclk_clks[GCLK_USIAU0_SCLK]),
-	CLKDEV_DEV_ID("e1020000.uart", &gclk_clks[GCLK_USIAU0_SCLK]),
-	CLKDEV_DEV_ID("serial8250-em.1", &gclk_clks[GCLK_USIBU1_SCLK]),
-	CLKDEV_DEV_ID("e1030000.uart", &gclk_clks[GCLK_USIBU1_SCLK]),
-	CLKDEV_DEV_ID("serial8250-em.2", &gclk_clks[GCLK_USIBU2_SCLK]),
-	CLKDEV_DEV_ID("e1040000.uart", &gclk_clks[GCLK_USIBU2_SCLK]),
-	CLKDEV_DEV_ID("serial8250-em.3", &gclk_clks[GCLK_USIBU3_SCLK]),
-	CLKDEV_DEV_ID("e1050000.uart", &gclk_clks[GCLK_USIBU3_SCLK]),
-	CLKDEV_DEV_ID("em_sti.0", &gclk_clks[GCLK_STI_SCLK]),
-	CLKDEV_DEV_ID("e0180000.sti", &gclk_clks[GCLK_STI_SCLK]),
-};
-
-void __init emev2_clock_init(void)
-{
-	int k, ret = 0;
-
-	smu_base = ioremap(EMEV2_SMU_BASE, PAGE_SIZE);
-	BUG_ON(!smu_base);
-
-	/* setup STI timer to run on 32.768 kHz and deassert reset */
-	emev2_smu_write(0, STI_CLKSEL);
-	emev2_smu_write(1, STI_RSTCTRL);
-
-	/* deassert reset for UART0->UART3 */
-	emev2_smu_write(2, USIAU0_RSTCTRL);
-	emev2_smu_write(2, USIBU1_RSTCTRL);
-	emev2_smu_write(2, USIBU2_RSTCTRL);
-	emev2_smu_write(2, USIBU3_RSTCTRL);
-
-	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
-		ret = clk_register(main_clks[k]);
-
-	if (!ret)
-		ret = emev2_sclkdiv_register(sclkdiv_clks, SCLKDIV_NR);
-
-	if (!ret)
-		ret = emev2_gclk_register(gclk_clks, GCLK_NR);
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	if (!ret)
-		shmobile_clk_init();
-	else
-		panic("failed to setup emev2 clocks\n");
-}
--- 0001/arch/arm/mach-shmobile/include/mach/emev2.h
+++ work/arch/arm/mach-shmobile/include/mach/emev2.h	2014-02-05 18:21:28.000000000 +0900
@@ -3,7 +3,6 @@
 
 extern void emev2_map_io(void);
 extern void emev2_init_delay(void);
-extern void emev2_clock_init(void);
 extern struct smp_operations emev2_smp_ops;
 
 #endif /* __ASM_EMEV2_H__ */
--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2014-02-05 18:21:28.000000000 +0900
@@ -50,11 +50,7 @@ void __init emev2_init_delay(void)
 
 static void __init emev2_add_standard_devices_dt(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	of_clk_init(NULL);
-#else
-	emev2_clock_init();
-#endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
