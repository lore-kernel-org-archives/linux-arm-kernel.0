From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:36:01 +0100
Subject: [PATCH 10/15] ARM: S3C2416: Add basic clock support
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic clock support for the PLLs, HSMMC channels and
PWM clocks. This is enough to get a basic system up and
running.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/regs-clock.h |    2 +
 arch/arm/mach-s3c2416/Kconfig                   |    2 +
 arch/arm/mach-s3c2416/Makefile                  |    2 +-
 arch/arm/mach-s3c2416/clock.c                   |  135 +++++++++++++++++++++++
 arch/arm/plat-s3c24xx/include/plat/pll.h        |   25 ++++
 5 files changed, 165 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s3c2416/clock.c

diff --git a/arch/arm/mach-s3c2410/include/mach/regs-clock.h b/arch/arm/mach-s3c2410/include/mach/regs-clock.h
index 9a0d169..3415b60 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-clock.h
@@ -161,4 +161,6 @@
 
 #endif /* CONFIG_CPU_S3C2412 | CONFIG_CPU_S3C2413 */
 
+#define S3C2416_CLKDIV2		S3C2410_CLKREG(0x28)
+
 #endif /* __ASM_ARM_REGS_CLOCK */
diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 528f273..677f963 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -10,6 +10,8 @@ config CPU_S3C2416
 	select CPU_ARM926T
 	select S3C2416_DMA if S3C2410_DMA
 	select CPU_LLSERIAL_S3C2440
+	select SAMSUNG_CLKSRC
+	select S3C2443_CLOCK
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
 
diff --git a/arch/arm/mach-s3c2416/Makefile b/arch/arm/mach-s3c2416/Makefile
index 9183e81..6c12c7b 100644
--- a/arch/arm/mach-s3c2416/Makefile
+++ b/arch/arm/mach-s3c2416/Makefile
@@ -9,7 +9,7 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o
+obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o clock.o
 obj-$(CONFIG_CPU_S3C2416)	+= irq.o
 
 #obj-$(CONFIG_S3C2416_DMA)	+= dma.o
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
new file mode 100644
index 0000000..7ccf5a2
--- /dev/null
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -0,0 +1,135 @@
+/* linux/arch/arm/mach-s3c2416/clock.c
+ *
+ * Copyright (c) 2010 Simtec Electronics
+ * Copyright (c) 2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * S3C2416 Clock control support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/clk.h>
+
+#include <plat/s3c2416.h>
+#include <plat/s3c2443.h>
+#include <plat/clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/cpu.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/pll6553x.h>
+#include <plat/pll.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/regs-clock.h>
+#include <mach/regs-s3c2443-clock.h>
+
+static unsigned int armdiv[8] = {
+	[0] = 1,
+	[1] = 2,
+	[2] = 3,
+	[3] = 4,
+	[5] = 6,
+	[7] = 8,
+};
+
+/* ID to hardware numbering, 0 is HSMMC1, 1 is HSMMC0 */
+static struct clksrc_clk hsmmc_div[] = {
+	[0] = {
+		.clk = {
+			.name	= "hsmmc-div",
+			.id	= 1,
+			.parent	= &clk_esysclk.clk,
+		},
+		.reg_div = { .reg = S3C2416_CLKDIV2, .size = 2, .shift = 6 },
+	},
+	[1] = {
+		.clk = {
+			.name	= "hsmmc-div",
+			.id	= 0,
+			.parent	= &clk_esysclk.clk,
+		},
+		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 6 },
+	},
+};
+
+static struct clksrc_clk hsmmc_mux[] = {
+	[0] = {
+		.clk	= {
+			.id	= 1,
+			.name	= "hsmmc-if",
+			.ctrlbit = (1 << 6),
+			.enable = s3c2443_clkcon_enable_s,
+		},
+		.sources = &(struct clksrc_sources) {
+			.nr_sources = 2,
+			.sources = (struct clk *[]) {
+				[0] = &hsmmc_div[0].clk,
+				[1] = NULL, /* to fix */
+			},
+		},
+		.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 16 },
+	},
+	[1] = {
+		.clk	= {
+			.id	= 0,
+			.name	= "hsmmc-if",
+			.ctrlbit = (1 << 12),
+			.enable = s3c2443_clkcon_enable_s,
+		},
+		.sources = &(struct clksrc_sources) {
+			.nr_sources = 2,
+			.sources = (struct clk *[]) {
+				[0] = &hsmmc_div[1].clk,
+				[1] = NULL, /* to fix */
+			},
+		},
+		.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 17 },
+	},
+};
+
+
+static inline unsigned int s3c2416_fclk_div(unsigned long clkcon0)
+{
+	clkcon0 &= 7 << S3C2443_CLKDIV0_ARMDIV_SHIFT;
+
+	return armdiv[clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT];
+}
+
+void __init_or_cpufreq s3c2416_setup_clocks(void)
+{
+	s3c2443_common_setup_clocks(s3c2416_get_pll, s3c2416_fclk_div);
+}
+
+
+static struct clksrc_clk *clksrcs[] __initdata = {
+	&hsmmc_div[0],
+	&hsmmc_div[1],
+	&hsmmc_mux[0],
+	&hsmmc_mux[1],
+};
+
+void __init s3c2416_init_clocks(int xtal)
+{
+	u32 epllcon = __raw_readl(S3C2443_EPLLCON);
+	u32 epllcon1 = __raw_readl(S3C2443_EPLLCON+4);
+	int ptr;
+
+	/* s3c2416 EPLL compatible with s3c64xx */
+	clk_epll.rate = s3c_get_pll6553x(xtal, epllcon, epllcon1);
+
+	clk_epll.parent = &clk_epllref.clk;
+
+	s3c2443_common_init_clocks(xtal, s3c2416_get_pll, s3c2416_fclk_div);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c_register_clksrc(clksrcs[ptr], 1);
+
+	s3c_pwmclk_init();
+
+}
diff --git a/arch/arm/plat-s3c24xx/include/plat/pll.h b/arch/arm/plat-s3c24xx/include/plat/pll.h
index 7ea8bff..005729a 100644
--- a/arch/arm/plat-s3c24xx/include/plat/pll.h
+++ b/arch/arm/plat-s3c24xx/include/plat/pll.h
@@ -35,3 +35,28 @@ s3c24xx_get_pll(unsigned int pllval, unsigned int baseclk)
 
 	return (unsigned int)fvco;
 }
+
+#define S3C2416_PLL_M_SHIFT	(14)
+#define S3C2416_PLL_P_SHIFT	(5)
+#define S3C2416_PLL_S_MASK	(7)
+#define S3C2416_PLL_M_MASK	((1 << 10) - 1)
+#define S3C2416_PLL_P_MASK	(63)
+
+static inline unsigned int
+s3c2416_get_pll(unsigned int pllval, unsigned int baseclk)
+{
+	unsigned int m, p, s;
+	uint64_t fvco;
+
+	m = pllval >> S3C2416_PLL_M_SHIFT;
+	p = pllval >> S3C2416_PLL_P_SHIFT;
+
+	s = pllval & S3C2416_PLL_S_MASK;
+	m &= S3C2416_PLL_M_MASK;
+	p &= S3C2416_PLL_P_MASK;
+
+	fvco = (uint64_t)baseclk * m;
+	do_div(fvco, (p << s));
+
+	return (unsigned int)fvco;
+}
-- 
1.6.3.3
