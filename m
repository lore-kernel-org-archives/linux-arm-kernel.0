From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 03:07:05 -0700
Subject: [PATCH 5/8] OMAP3 clock: convert clock34xx.h to clock34xx_data.c
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
Message-ID: <20091203100705.1203.96919.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP3 clock code currently #includes a large .h file full of static
data structures.  Instead, define the data in a .c file.

Russell King <rmk+kernel@arm.linux.org.uk> proposed this new arrangement:

    http://marc.info/?l=linux-omap&m=125967425908895&w=2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/Makefile                  |    2 
 arch/arm/mach-omap2/clock.h                   |    2 
 arch/arm/mach-omap2/clock24xx.c               |   21 
 arch/arm/mach-omap2/clock34xx.c               |  439 ----
 arch/arm/mach-omap2/clock34xx.h               | 3013 -------------------------
 arch/arm/mach-omap2/clock34xx_data.c          |  364 +++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   35 
 7 files changed, 464 insertions(+), 3412 deletions(-)
 copy arch/arm/mach-omap2/{clock34xx.h => clock34xx_data.c} (86%)
 create mode 100644 arch/arm/plat-omap/include/plat/clkdev_omap.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..27cb2f8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clock34xx_data.o
 
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 43b6bed..b1991e3 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -77,6 +77,8 @@ extern const struct clkops clkops_omap2_dflt;
 
 extern u8 cpu_mask;
 
+extern struct clk_functions omap2_clk_functions;
+
 /* clksel_rate data common to 24xx/343x */
 static const struct clksel_rate gpt_32k_rates[] = {
 	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 5f201d2..a422174 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -31,6 +31,7 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/prcm.h>
+#include <plat/clkdev_omap.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
@@ -59,24 +60,6 @@ static const struct clkops clkops_omap2430_i2chs_wait = {
 
 #include "clock24xx.h"
 
-struct omap_clk {
-	u32		cpu;
-	struct clk_lookup lk;
-};
-
-#define CLK(dev, con, ck, cp) 		\
-	{				\
-		 .cpu = cp,		\
-		.lk = {			\
-			.dev_id = dev,	\
-			.con_id = con,	\
-			.clk = ck,	\
-		},			\
-	}
-
-#define CK_243X			RATE_IN_243X
-#define CK_242X			RATE_IN_242X
-
 static struct omap_clk omap24xx_clks[] = {
 	/* external root sources */
 	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X | CK_242X),
@@ -658,7 +641,7 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 }
 #endif
 
-static struct clk_functions omap2_clk_functions = {
+struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 3929544..1fc962f 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -30,292 +30,18 @@
 #include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
+#include <plat/sdrc.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include <plat/sdrc.h>
 #include "clock.h"
+#include "clock34xx.h"
+#include "sdrc.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 
-static const struct clkops clkops_noncore_dpll_ops;
-
-static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
-					    void __iomem **idlest_reg,
-					    u8 *idlest_bit);
-static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
-					    void __iomem **idlest_reg,
-					    u8 *idlest_bit);
-static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
-						    void __iomem **idlest_reg,
-						    u8 *idlest_bit);
-
-static const struct clkops clkops_omap3430es2_ssi_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-static const struct clkops clkops_omap3430es2_hsotgusb_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-static const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-#include "clock34xx.h"
-
-struct omap_clk {
-	u32		cpu;
-	struct clk_lookup lk;
-};
-
-#define CLK(dev, con, ck, cp) 		\
-	{				\
-		 .cpu = cp,		\
-		.lk = {			\
-			.dev_id = dev,	\
-			.con_id = con,	\
-			.clk = ck,	\
-		},			\
-	}
-
-#define CK_343X		(1 << 0)
-#define CK_3430ES1	(1 << 1)
-#define CK_3430ES2	(1 << 2)
-
-static struct omap_clk omap34xx_clks[] = {
-	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_343X),
-	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_343X),
-	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X),
-	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
-	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_343X),
-	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_343X),
-	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_343X),
-	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_343X),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_343X),
-	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_343X),
-	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_343X),
-	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_343X),
-	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_343X),
-	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_343X),
-	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_343X),
-	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_343X),
-	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_343X),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_343X),
-	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
-	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
-	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
-	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_343X),
-	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_343X),
-	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
-	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_343X),
-	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_343X),
-	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_343X),
-	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck,	CK_343X),
-	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_343X),
-	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
-	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
-	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
-	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2),
-	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_343X),
-	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_343X),
-	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_343X),
-	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_343X),
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_343X),
-	CLK(NULL,	"arm_fck",	&arm_fck,	CK_343X),
-	CLK(NULL,	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
-	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_343X),
-	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_343X),
-	CLK(NULL,	"l3_ick",	&l3_ick,	CK_343X),
-	CLK(NULL,	"l4_ick",	&l4_ick,	CK_343X),
-	CLK(NULL,	"rm_ick",	&rm_ick,	CK_343X),
-	CLK(NULL,	"gfx_l3_ck",	&gfx_l3_ck,	CK_3430ES1),
-	CLK(NULL,	"gfx_l3_fck",	&gfx_l3_fck,	CK_3430ES1),
-	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
-	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
-	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
-	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2),
-	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2),
-	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
-	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
-	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
-	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_343X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_343X),
-	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2),
-	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2),
-	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2),
-	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_343X),
-	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2),
-	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_343X),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
-	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_343X),
-	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_343X),
-	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_343X),
-	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_343X),
-	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_343X),
-	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_343X),
-	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_343X),
-	CLK("omap2_mcspi.4", "fck",	&mcspi4_fck,	CK_343X),
-	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_343X),
-	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_343X),
-	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_343X),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_343X),
-	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_343X),
-	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
-	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_343X),
-	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_343X),
-	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2),
-	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2,	CK_3430ES2),
-	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
-	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
-	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2),
-	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_343X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_343X),
-	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_343X),
-	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_343X),
-	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2),
-	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2),
-	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
-	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_343X),
-	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_343X),
-	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
-	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_343X),
-	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_343X),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_343X),
-	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_343X),
-	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_343X),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_343X),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_343X),
-	CLK("i2c_omap.3", "ick",	&i2c3_ick,	CK_343X),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_343X),
-	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_343X),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_343X),
-	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_343X),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_343X),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_343X),
-	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_343X),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_343X),
-	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_343X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_343X),
-	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
-	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_343X),
-	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_343X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
-	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
-	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2),
-	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_343X),
-	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_343X),
-	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
-	CLK("omapdss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2),
-	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
-	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
-	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
-	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
-	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
-	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2),
-	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
-	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
-	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
-	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
-	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
-	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
-	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_343X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
-	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
-	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_343X),
-	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_343X),
-	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_343X),
-	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_343X),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_343X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_343X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_343X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_343X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_343X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_343X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_343X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_343X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_343X),
-	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_343X),
-	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_343X),
-	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_343X),
-	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_343X),
-	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_343X),
-	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_343X),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_343X),
-	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_343X),
-	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_343X),
-	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_343X),
-	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_343X),
-	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_343X),
-	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_343X),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_343X),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_343X),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_343X),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_343X),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_343X),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_343X),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_343X),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_343X),
-	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_343X),
-	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_343X),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_343X),
-	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_343X),
-	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_343X),
-	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_343X),
-	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_343X),
-	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_343X),
-	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_343X),
-	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_343X),
-	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_343X),
-	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_343X),
-	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_343X),
-	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_343X),
-	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_343X),
-	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
-	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
-	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
-	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
-};
-
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE			0x0
 #define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
@@ -331,6 +57,9 @@ static struct omap_clk omap34xx_clks[] = {
  */
 #define DPLL5_FREQ_FOR_USBHOST		120000000
 
+/* needed by omap3_core_dpll_m2_set_rate() */
+struct clk *sdrc_ick_p, *arm_fck_p;
+
 /**
  * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
  * @clk: struct clk * being enabled
@@ -341,9 +70,9 @@ static struct omap_clk omap34xx_clks[] = {
  * from the CM_{I,F}CLKEN bit.  Pass back the correct info via
  * @idlest_reg and @idlest_bit.  No return value.
  */
-static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
-					    void __iomem **idlest_reg,
-					    u8 *idlest_bit)
+void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
+				     void __iomem **idlest_reg,
+				     u8 *idlest_bit)
 {
 	u32 r;
 
@@ -365,9 +94,9 @@ static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
  * default find_idlest code assumes that they are@the same
  * position.)  No return value.
  */
-static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
-						    void __iomem **idlest_reg,
-						    u8 *idlest_bit)
+void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
+					     void __iomem **idlest_reg,
+					     u8 *idlest_bit)
 {
 	u32 r;
 
@@ -387,9 +116,9 @@ static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
  * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
  * @idlest_reg and @idlest_bit.  No return value.
  */
-static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
-						 void __iomem **idlest_reg,
-						 u8 *idlest_bit)
+void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
+					  void __iomem **idlest_reg,
+					  u8 *idlest_bit)
 {
 	u32 r;
 
@@ -404,7 +133,7 @@ static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
  *
  * Recalculate and propagate the DPLL rate.
  */
-static unsigned long omap3_dpll_recalc(struct clk *clk)
+unsigned long omap3_dpll_recalc(struct clk *clk)
 {
 	return omap2_get_dpll_rate(clk);
 }
@@ -604,7 +333,7 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
  * support low-power stop, or if the DPLL took too long to enter
  * bypass or lock, return -EINVAL; otherwise, return 0.
  */
-static int omap3_noncore_dpll_enable(struct clk *clk)
+int omap3_noncore_dpll_enable(struct clk *clk)
 {
 	int r;
 	struct dpll_data *dd;
@@ -641,7 +370,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
  * support low-power stop, or if the DPLL took too long to enter
  * bypass or lock, return -EINVAL; otherwise, return 0.
  */
-static void omap3_noncore_dpll_disable(struct clk *clk)
+void omap3_noncore_dpll_disable(struct clk *clk)
 {
 	_omap3_noncore_dpll_stop(clk);
 }
@@ -700,7 +429,7 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
  * target rate if it hasn't been done already, then program and lock
  * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
  */
-static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
+int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk *new_parent = NULL;
 	u16 freqsel;
@@ -771,7 +500,7 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
+int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 {
 	/*
 	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
@@ -802,12 +531,12 @@ static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
  * Program the DPLL M2 divider with the rounded target rate.  Returns
  * -EINVAL upon error, or 0 upon success.
  */
-static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
+int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 {
 	u32 new_div = 0;
 	u32 unlock_dll = 0;
 	u32 c;
-	unsigned long validrate, sdrcrate, mpurate;
+	unsigned long validrate, sdrcrate, _mpurate;
 	struct omap_sdrc_params *sdrc_cs0;
 	struct omap_sdrc_params *sdrc_cs1;
 	int ret;
@@ -819,7 +548,7 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	if (validrate != rate)
 		return -EINVAL;
 
-	sdrcrate = sdrc_ick.rate;
+	sdrcrate = sdrc_ick_p->rate;
 	if (rate > clk->rate)
 		sdrcrate <<= ((rate / clk->rate) >> 1);
 	else
@@ -837,8 +566,8 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	/*
 	 * XXX This only needs to be done when the CPU frequency changes
 	 */
-	mpurate = arm_fck.rate / CYCLES_PER_MHZ;
-	c = (mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
+	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
+	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
 	c += 1;  /* for safety */
 	c *= SDRC_MPURATE_LOOPS;
 	c >>= SDRC_MPURATE_SCALE;
@@ -875,11 +604,6 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 }
 
 
-static const struct clkops clkops_noncore_dpll_ops = {
-	.enable		= &omap3_noncore_dpll_enable,
-	.disable	= &omap3_noncore_dpll_disable,
-};
-
 /* DPLL autoidle read/set code */
 
 
@@ -891,7 +615,7 @@ static const struct clkops clkops_noncore_dpll_ops = {
  * -EINVAL if passed a null pointer or if the struct clk does not
  * appear to refer to a DPLL.
  */
-static u32 omap3_dpll_autoidle_read(struct clk *clk)
+u32 omap3_dpll_autoidle_read(struct clk *clk)
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -917,7 +641,7 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk)
  * OMAP3430.  The DPLL will enter low-power stop when its downstream
  * clocks are gated.  No return value.
  */
-static void omap3_dpll_allow_idle(struct clk *clk)
+void omap3_dpll_allow_idle(struct clk *clk)
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -944,7 +668,7 @@ static void omap3_dpll_allow_idle(struct clk *clk)
  *
  * Disable DPLL automatic idle control.  No return value.
  */
-static void omap3_dpll_deny_idle(struct clk *clk)
+void omap3_dpll_deny_idle(struct clk *clk)
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -969,7 +693,7 @@ static void omap3_dpll_deny_idle(struct clk *clk)
  * Using parent clock DPLL data, look up DPLL state.  If locked, set our
  * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
  */
-static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
+unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 {
 	const struct dpll_data *dd;
 	unsigned long rate;
@@ -1005,7 +729,7 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
  */
 #if defined(CONFIG_ARCH_OMAP3)
 
-static struct clk_functions omap2_clk_functions = {
+struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
@@ -1031,7 +755,7 @@ void omap2_clk_prepare_for_reboot(void)
 #endif
 }
 
-static void omap3_clk_lock_dpll5(void)
+void omap3_clk_lock_dpll5(void)
 {
 	struct clk *dpll5_clk;
 	struct clk *dpll5_m2_clk;
@@ -1061,19 +785,32 @@ static void omap3_clk_lock_dpll5(void)
  */
 static int __init omap2_clk_arch_init(void)
 {
+	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
+	unsigned long osc_sys_rate;
+
 	if (!mpurate)
 		return -EINVAL;
 
+	/* XXX test these for success */
+	dpll1_ck = clk_get(NULL, "dpll1_ck");
+	arm_fck = clk_get(NULL, "arm_fck");
+	core_ck = clk_get(NULL, "core_ck");
+	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
+
 	/* REVISIT: not yet ready for 343x */
-	if (clk_set_rate(&dpll1_ck, mpurate))
+	if (clk_set_rate(dpll1_ck, mpurate))
 		printk(KERN_ERR "*** Unable to set MPU rate\n");
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Switched to new clocking rate (Crystal/Core/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (osc_sys_ck.rate / 1000000), ((osc_sys_ck.rate / 100000) % 10),
-	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000)) ;
+	osc_sys_rate = clk_get_rate(osc_sys_ck);
+
+	pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
+		"%ld.%01ld/%ld/%ld MHz\n",
+		(osc_sys_rate / 1000000),
+		((osc_sys_rate / 100000) % 10),
+		(clk_get_rate(core_ck) / 1000000),
+		(clk_get_rate(arm_fck) / 1000000));
 
 	calibrate_delay();
 
@@ -1081,83 +818,5 @@ static int __init omap2_clk_arch_init(void)
 }
 arch_initcall(omap2_clk_arch_init);
 
-int __init omap2_clk_init(void)
-{
-	/* struct prcm_config *prcm; */
-	struct omap_clk *c;
-	/* u32 clkrate; */
-	u32 cpu_clkflg;
-
-	if (cpu_is_omap34xx()) {
-		cpu_mask = RATE_IN_343X;
-		cpu_clkflg = CK_343X;
-
-		/*
-		 * Update this if there are further clock changes between ES2
-		 * and production parts
-		 */
-		if (omap_rev() == OMAP3430_REV_ES1_0) {
-			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
-			cpu_clkflg |= CK_3430ES1;
-		} else {
-			cpu_mask |= RATE_IN_3430ES2;
-			cpu_clkflg |= CK_3430ES2;
-		}
-	}
-
-	clk_init(&omap2_clk_functions);
-
-	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
-		clk_preinit(c->lk.clk);
-
-	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			clk_register(c->lk.clk);
-			omap2_init_clk_clkdm(c->lk.clk);
-		}
-
-	/* REVISIT: Not yet ready for OMAP3 */
-#if 0
-	/* Check the MPU rate set by bootloader */
-	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-		if (prcm->dpll_speed <= clkrate)
-			 break;
-	}
-	curr_prcm_set = prcm;
-#endif
-
-	recalculate_root_clocks();
-
-	printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
-
-	/*
-	 * Only enable those clocks we will need, let the drivers
-	 * enable other clocks as necessary
-	 */
-	clk_enable_init_clocks();
-
-	/*
-	 * Lock DPLL5 and put it in autoidle.
-	 */
-	if (omap_rev() >= OMAP3430_REV_ES2_0)
-		omap3_clk_lock_dpll5();
-
-	/* Avoid sleeping during omap2_clk_prepare_for_reboot() */
-	/* REVISIT: not yet ready for 343x */
-#if 0
-	vclk = clk_get(NULL, "virt_prcm_set");
-	sclk = clk_get(NULL, "sys_ck");
-#endif
-	return 0;
-}
 
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 8fe1bcb..792a1b3 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1,2993 +1,40 @@
 /*
- * OMAP3 clock framework
+ * OMAP3 clock function prototypes and macros
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
- *
- * Written by Paul Walmsley
- * With many device clock fixes by Kevin Hilman and Jouni H?gander
- * DPLL bypass clock support added by Roman Tereshonkov
- *
- */
-
-/*
- * Virtual clocks are introduced as convenient tools.
- * They are sources for other clocks and not supposed
- * to be requested from drivers directly.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
-
-#include <plat/control.h>
-
-#include "clock.h"
-#include "cm.h"
-#include "cm-regbits-34xx.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
-
-#define OMAP_CM_REGADDR		OMAP34XX_CM_REGADDR
-
-static unsigned long omap3_dpll_recalc(struct clk *clk);
-static unsigned long omap3_clkoutx2_recalc(struct clk *clk);
-static void omap3_dpll_allow_idle(struct clk *clk);
-static void omap3_dpll_deny_idle(struct clk *clk);
-static u32 omap3_dpll_autoidle_read(struct clk *clk);
-static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
-static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
-static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
-
-/* Maximum DPLL multiplier, divider values for OMAP3 */
-#define OMAP3_MAX_DPLL_MULT		2048
-#define OMAP3_MAX_DPLL_DIV		128
-
-/*
- * DPLL1 supplies clock to the MPU.
- * DPLL2 supplies clock to the IVA2.
- * DPLL3 supplies CORE domain clocks.
- * DPLL4 supplies peripheral clocks.
- * DPLL5 supplies other peripheral clocks (USBHOST, USIM).
- */
-
-/* Forward declarations for DPLL bypass clocks */
-static struct clk dpll1_fck;
-static struct clk dpll2_fck;
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
+
+unsigned long omap3_dpll_recalc(struct clk *clk);
+unsigned long omap3_clkoutx2_recalc(struct clk *clk);
+void omap3_dpll_allow_idle(struct clk *clk);
+void omap3_dpll_deny_idle(struct clk *clk);
+u32 omap3_dpll_autoidle_read(struct clk *clk);
+int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
+int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
+int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
+void omap3_clk_lock_dpll5(void);
+int omap3_noncore_dpll_enable(struct clk *clk);
+void omap3_noncore_dpll_disable(struct clk *clk);
+void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
+				     void __iomem **idlest_reg,
+				     u8 *idlest_bit);
+void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
+					     void __iomem **idlest_reg,
+					     u8 *idlest_bit);
+void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
+					  void __iomem **idlest_reg,
+					  u8 *idlest_bit);
 
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP		0x1
 #define DPLL_LOW_POWER_BYPASS		0x5
 #define DPLL_LOCKED			0x7
 
-/* PRM CLOCKS */
-
-/* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
-static struct clk omap_32k_fck = {
-	.name		= "omap_32k_fck",
-	.ops		= &clkops_null,
-	.rate		= 32768,
-	.flags		= RATE_FIXED,
-};
-
-static struct clk secure_32k_fck = {
-	.name		= "secure_32k_fck",
-	.ops		= &clkops_null,
-	.rate		= 32768,
-	.flags		= RATE_FIXED,
-};
-
-/* Virtual source clocks for osc_sys_ck */
-static struct clk virt_12m_ck = {
-	.name		= "virt_12m_ck",
-	.ops		= &clkops_null,
-	.rate		= 12000000,
-	.flags		= RATE_FIXED,
-};
-
-static struct clk virt_13m_ck = {
-	.name		= "virt_13m_ck",
-	.ops		= &clkops_null,
-	.rate		= 13000000,
-	.flags		= RATE_FIXED,
-};
-
-static struct clk virt_16_8m_ck = {
-	.name		= "virt_16_8m_ck",
-	.ops		= &clkops_null,
-	.rate		= 16800000,
-	.flags		= RATE_FIXED,
-};
-
-static struct clk virt_19_2m_ck = {
-	.name		= "virt_19_2m_ck",
-	.ops		= &clkops_null,
-	.rate		= 19200000,
-	.flags		= RATE_FIXED,
-};
-
-static struct clk virt_26m_ck = {
-	.name		= "virt_26m_ck",
-	.ops		= &clkops_null,
-	.rate		= 26000000,
-	.flags		= RATE_FIXED,
-};
-
-static struct clk virt_38_4m_ck = {
-	.name		= "virt_38_4m_ck",
-	.ops		= &clkops_null,
-	.rate		= 38400000,
-	.flags		= RATE_FIXED,
-};
-
-static const struct clksel_rate osc_sys_12m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate osc_sys_13m_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate osc_sys_16_8m_rates[] = {
-	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2 | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate osc_sys_19_2m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate osc_sys_26m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate osc_sys_38_4m_rates[] = {
-	{ .div = 1, .val = 4, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel osc_sys_clksel[] = {
-	{ .parent = &virt_12m_ck,   .rates = osc_sys_12m_rates },
-	{ .parent = &virt_13m_ck,   .rates = osc_sys_13m_rates },
-	{ .parent = &virt_16_8m_ck, .rates = osc_sys_16_8m_rates },
-	{ .parent = &virt_19_2m_ck, .rates = osc_sys_19_2m_rates },
-	{ .parent = &virt_26m_ck,   .rates = osc_sys_26m_rates },
-	{ .parent = &virt_38_4m_ck, .rates = osc_sys_38_4m_rates },
-	{ .parent = NULL },
-};
-
-/* Oscillator clock */
-/* 12, 13, 16.8, 19.2, 26, or 38.4 MHz */
-static struct clk osc_sys_ck = {
-	.name		= "osc_sys_ck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP3430_PRM_CLKSEL,
-	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
-	.clksel		= osc_sys_clksel,
-	/* REVISIT: deal with autoextclkmode? */
-	.flags		= RATE_FIXED,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate div2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 0 }
-};
-
-static const struct clksel sys_clksel[] = {
-	{ .parent = &osc_sys_ck, .rates = div2_rates },
-	{ .parent = NULL }
-};
-
-/* Latency: this clock is only enabled after PRM_CLKSETUP.SETUP_TIME */
-/* Feeds DPLLs - divided first by PRM_CLKSRC_CTRL.SYSCLKDIV? */
-static struct clk sys_ck = {
-	.name		= "sys_ck",
-	.ops		= &clkops_null,
-	.parent		= &osc_sys_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP3430_PRM_CLKSRC_CTRL,
-	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
-	.clksel		= sys_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk sys_altclk = {
-	.name		= "sys_altclk",
-	.ops		= &clkops_null,
-};
-
-/* Optional external clock input for some McBSPs */
-static struct clk mcbsp_clks = {
-	.name		= "mcbsp_clks",
-	.ops		= &clkops_null,
-};
-
-/* PRM EXTERNAL CLOCK OUTPUT */
-
-static struct clk sys_clkout1 = {
-	.name		= "sys_clkout1",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &osc_sys_ck,
-	.enable_reg	= OMAP3430_PRM_CLKOUT_CTRL,
-	.enable_bit	= OMAP3430_CLKOUT_EN_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/* DPLLS */
-
-/* CM CLOCKS */
-
-static const struct clksel_rate div16_dpll_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 5, .val = 5, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 7, .val = 7, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
-	{ .div = 9, .val = 9, .flags = RATE_IN_343X },
-	{ .div = 10, .val = 10, .flags = RATE_IN_343X },
-	{ .div = 11, .val = 11, .flags = RATE_IN_343X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_343X },
-	{ .div = 13, .val = 13, .flags = RATE_IN_343X },
-	{ .div = 14, .val = 14, .flags = RATE_IN_343X },
-	{ .div = 15, .val = 15, .flags = RATE_IN_343X },
-	{ .div = 16, .val = 16, .flags = RATE_IN_343X },
-	{ .div = 0 }
-};
-
-/* DPLL1 */
-/* MPU clock source */
-/* Type: DPLL */
-static struct dpll_data dpll1_dd = {
-	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
-	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
-	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
-	.clk_bypass	= &dpll1_fck,
-	.clk_ref	= &sys_ck,
-	.freqsel_mask	= OMAP3430_MPU_DPLL_FREQSEL_MASK,
-	.control_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
-	.enable_mask	= OMAP3430_EN_MPU_DPLL_MASK,
-	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.auto_recal_bit	= OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
-	.recal_en_bit	= OMAP3430_MPU_DPLL_RECAL_EN_SHIFT,
-	.recal_st_bit	= OMAP3430_MPU_DPLL_ST_SHIFT,
-	.autoidle_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
-	.autoidle_mask	= OMAP3430_AUTO_MPU_DPLL_MASK,
-	.idlest_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_mask	= OMAP3430_ST_MPU_CLK_MASK,
-	.max_multiplier = OMAP3_MAX_DPLL_MULT,
-	.min_divider	= 1,
-	.max_divider	= OMAP3_MAX_DPLL_DIV,
-	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll1_ck = {
-	.name		= "dpll1_ck",
-	.ops		= &clkops_null,
-	.parent		= &sys_ck,
-	.dpll_data	= &dpll1_dd,
-	.round_rate	= &omap2_dpll_round_rate,
-	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.clkdm_name	= "dpll1_clkdm",
-	.recalc		= &omap3_dpll_recalc,
-};
-
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed.
- */
-static struct clk dpll1_x2_ck = {
-	.name		= "dpll1_x2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll1_ck,
-	.clkdm_name	= "dpll1_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-/* On DPLL1, unlike other DPLLs, the divider is downstream from CLKOUTX2 */
-static const struct clksel div16_dpll1_x2m2_clksel[] = {
-	{ .parent = &dpll1_x2_ck, .rates = div16_dpll_rates },
-	{ .parent = NULL }
-};
-
-/*
- * Does not exist in the TRM - needed to separate the M2 divider from
- * bypass selection in mpu_ck
- */
-static struct clk dpll1_x2m2_ck = {
-	.name		= "dpll1_x2m2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll1_x2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
-	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
-	.clksel		= div16_dpll1_x2m2_clksel,
-	.clkdm_name	= "dpll1_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* DPLL2 */
-/* IVA2 clock source */
-/* Type: DPLL */
-
-static struct dpll_data dpll2_dd = {
-	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
-	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
-	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
-	.clk_bypass	= &dpll2_fck,
-	.clk_ref	= &sys_ck,
-	.freqsel_mask	= OMAP3430_IVA2_DPLL_FREQSEL_MASK,
-	.control_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL),
-	.enable_mask	= OMAP3430_EN_IVA2_DPLL_MASK,
-	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
-				(1 << DPLL_LOW_POWER_BYPASS),
-	.auto_recal_bit	= OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
-	.recal_en_bit	= OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT,
-	.recal_st_bit	= OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT,
-	.autoidle_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL),
-	.autoidle_mask	= OMAP3430_AUTO_IVA2_DPLL_MASK,
-	.idlest_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_mask	= OMAP3430_ST_IVA2_CLK_MASK,
-	.max_multiplier = OMAP3_MAX_DPLL_MULT,
-	.min_divider	= 1,
-	.max_divider	= OMAP3_MAX_DPLL_DIV,
-	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll2_ck = {
-	.name		= "dpll2_ck",
-	.ops		= &clkops_noncore_dpll_ops,
-	.parent		= &sys_ck,
-	.dpll_data	= &dpll2_dd,
-	.round_rate	= &omap2_dpll_round_rate,
-	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.clkdm_name	= "dpll2_clkdm",
-	.recalc		= &omap3_dpll_recalc,
-};
-
-static const struct clksel div16_dpll2_m2x2_clksel[] = {
-	{ .parent = &dpll2_ck, .rates = div16_dpll_rates },
-	{ .parent = NULL }
-};
-
-/*
- * The TRM is conflicted on whether IVA2 clock comes from DPLL2 CLKOUT
- * or CLKOUTX2. CLKOUT seems most plausible.
- */
-static struct clk dpll2_m2_ck = {
-	.name		= "dpll2_m2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
-					  OMAP3430_CM_CLKSEL2_PLL),
-	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
-	.clksel		= div16_dpll2_m2x2_clksel,
-	.clkdm_name	= "dpll2_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/*
- * DPLL3
- * Source clock for all interfaces and for some device fclks
- * REVISIT: Also supports fast relock bypass - not included below
- */
-static struct dpll_data dpll3_dd = {
-	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.mult_mask	= OMAP3430_CORE_DPLL_MULT_MASK,
-	.div1_mask	= OMAP3430_CORE_DPLL_DIV_MASK,
-	.clk_bypass	= &sys_ck,
-	.clk_ref	= &sys_ck,
-	.freqsel_mask	= OMAP3430_CORE_DPLL_FREQSEL_MASK,
-	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_mask	= OMAP3430_EN_CORE_DPLL_MASK,
-	.auto_recal_bit	= OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
-	.recal_en_bit	= OMAP3430_CORE_DPLL_RECAL_EN_SHIFT,
-	.recal_st_bit	= OMAP3430_CORE_DPLL_ST_SHIFT,
-	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
-	.autoidle_mask	= OMAP3430_AUTO_CORE_DPLL_MASK,
-	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.idlest_mask	= OMAP3430_ST_CORE_CLK_MASK,
-	.max_multiplier = OMAP3_MAX_DPLL_MULT,
-	.min_divider	= 1,
-	.max_divider	= OMAP3_MAX_DPLL_DIV,
-	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll3_ck = {
-	.name		= "dpll3_ck",
-	.ops		= &clkops_null,
-	.parent		= &sys_ck,
-	.dpll_data	= &dpll3_dd,
-	.round_rate	= &omap2_dpll_round_rate,
-	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &omap3_dpll_recalc,
-};
-
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed
- */
-static struct clk dpll3_x2_ck = {
-	.name		= "dpll3_x2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll3_ck,
-	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-static const struct clksel_rate div31_dpll3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2 },
-	{ .div = 4, .val = 4, .flags = RATE_IN_3430ES2 },
-	{ .div = 5, .val = 5, .flags = RATE_IN_3430ES2 },
-	{ .div = 6, .val = 6, .flags = RATE_IN_3430ES2 },
-	{ .div = 7, .val = 7, .flags = RATE_IN_3430ES2 },
-	{ .div = 8, .val = 8, .flags = RATE_IN_3430ES2 },
-	{ .div = 9, .val = 9, .flags = RATE_IN_3430ES2 },
-	{ .div = 10, .val = 10, .flags = RATE_IN_3430ES2 },
-	{ .div = 11, .val = 11, .flags = RATE_IN_3430ES2 },
-	{ .div = 12, .val = 12, .flags = RATE_IN_3430ES2 },
-	{ .div = 13, .val = 13, .flags = RATE_IN_3430ES2 },
-	{ .div = 14, .val = 14, .flags = RATE_IN_3430ES2 },
-	{ .div = 15, .val = 15, .flags = RATE_IN_3430ES2 },
-	{ .div = 16, .val = 16, .flags = RATE_IN_3430ES2 },
-	{ .div = 17, .val = 17, .flags = RATE_IN_3430ES2 },
-	{ .div = 18, .val = 18, .flags = RATE_IN_3430ES2 },
-	{ .div = 19, .val = 19, .flags = RATE_IN_3430ES2 },
-	{ .div = 20, .val = 20, .flags = RATE_IN_3430ES2 },
-	{ .div = 21, .val = 21, .flags = RATE_IN_3430ES2 },
-	{ .div = 22, .val = 22, .flags = RATE_IN_3430ES2 },
-	{ .div = 23, .val = 23, .flags = RATE_IN_3430ES2 },
-	{ .div = 24, .val = 24, .flags = RATE_IN_3430ES2 },
-	{ .div = 25, .val = 25, .flags = RATE_IN_3430ES2 },
-	{ .div = 26, .val = 26, .flags = RATE_IN_3430ES2 },
-	{ .div = 27, .val = 27, .flags = RATE_IN_3430ES2 },
-	{ .div = 28, .val = 28, .flags = RATE_IN_3430ES2 },
-	{ .div = 29, .val = 29, .flags = RATE_IN_3430ES2 },
-	{ .div = 30, .val = 30, .flags = RATE_IN_3430ES2 },
-	{ .div = 31, .val = 31, .flags = RATE_IN_3430ES2 },
-	{ .div = 0 },
-};
-
-static const struct clksel div31_dpll3m2_clksel[] = {
-	{ .parent = &dpll3_ck, .rates = div31_dpll3_rates },
-	{ .parent = NULL }
-};
-
-/* DPLL3 output M2 - primary control point for CORE speed */
-static struct clk dpll3_m2_ck = {
-	.name		= "dpll3_m2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll3_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
-	.clksel		= div31_dpll3m2_clksel,
-	.clkdm_name	= "dpll3_clkdm",
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap3_core_dpll_m2_set_rate,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk core_ck = {
-	.name		= "core_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll3_m2_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dpll3_m2x2_ck = {
-	.name		= "dpll3_m2x2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll3_m2_ck,
-	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static const struct clksel div16_dpll3_clksel[] = {
-	{ .parent = &dpll3_ck, .rates = div16_dpll_rates },
-	{ .parent = NULL }
-};
-
-/* This virtual clock is the source for dpll3_m3x2_ck */
-static struct clk dpll3_m3_ck = {
-	.name		= "dpll3_m3_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll3_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
-	.clksel		= div16_dpll3_clksel,
-	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll3_m3x2_ck = {
-	.name		= "dpll3_m3x2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dpll3_m3_ck,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
-	.flags		= INVERT_ENABLE,
-	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-static struct clk emu_core_alwon_ck = {
-	.name		= "emu_core_alwon_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll3_m3x2_ck,
-	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* DPLL4 */
-/* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
-/* Type: DPLL */
-static struct dpll_data dpll4_dd = {
-	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
-	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
-	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
-	.clk_bypass	= &sys_ck,
-	.clk_ref	= &sys_ck,
-	.freqsel_mask	= OMAP3430_PERIPH_DPLL_FREQSEL_MASK,
-	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_mask	= OMAP3430_EN_PERIPH_DPLL_MASK,
-	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
-	.auto_recal_bit	= OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
-	.recal_en_bit	= OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
-	.recal_st_bit	= OMAP3430_PERIPH_DPLL_ST_SHIFT,
-	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
-	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
-	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
-	.max_multiplier = OMAP3_MAX_DPLL_MULT,
-	.min_divider	= 1,
-	.max_divider	= OMAP3_MAX_DPLL_DIV,
-	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll4_ck = {
-	.name		= "dpll4_ck",
-	.ops		= &clkops_noncore_dpll_ops,
-	.parent		= &sys_ck,
-	.dpll_data	= &dpll4_dd,
-	.round_rate	= &omap2_dpll_round_rate,
-	.set_rate	= &omap3_dpll4_set_rate,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap3_dpll_recalc,
-};
-
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed --
- * XXX does this serve any downstream clocks?
- */
-static struct clk dpll4_x2_ck = {
-	.name		= "dpll4_x2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-static const struct clksel div16_dpll4_clksel[] = {
-	{ .parent = &dpll4_ck, .rates = div16_dpll_rates },
-	{ .parent = NULL }
-};
-
-/* This virtual clock is the source for dpll4_m2x2_ck */
-static struct clk dpll4_m2_ck = {
-	.name		= "dpll4_m2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
-	.clksel_mask	= OMAP3430_DIV_96M_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m2x2_ck = {
-	.name		= "dpll4_m2x2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dpll4_m2_ck,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
-	.flags		= INVERT_ENABLE,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-/*
- * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
- * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
- * 96M_ALWON_FCLK (called "omap_96m_alwon_fck" below) and
- * CM_96K_(F)CLK.
- */
-static struct clk omap_96m_alwon_fck = {
-	.name		= "omap_96m_alwon_fck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_m2x2_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk cm_96m_fck = {
-	.name		= "cm_96m_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_96m_alwon_fck,
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel_rate omap_96m_dpll_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate omap_96m_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel omap_96m_fck_clksel[] = {
-	{ .parent = &cm_96m_fck, .rates = omap_96m_dpll_rates },
-	{ .parent = &sys_ck,	 .rates = omap_96m_sys_rates },
-	{ .parent = NULL }
-};
-
-static struct clk omap_96m_fck = {
-	.name		= "omap_96m_fck",
-	.ops		= &clkops_null,
-	.parent		= &sys_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_SOURCE_96M_MASK,
-	.clksel		= omap_96m_fck_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* This virtual clock is the source for dpll4_m3x2_ck */
-static struct clk dpll4_m3_ck = {
-	.name		= "dpll4_m3_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m3x2_ck = {
-	.name		= "dpll4_m3x2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dpll4_m3_ck,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
-	.flags		= INVERT_ENABLE,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-static const struct clksel_rate omap_54m_d4m3x2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate omap_54m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel omap_54m_clksel[] = {
-	{ .parent = &dpll4_m3x2_ck, .rates = omap_54m_d4m3x2_rates },
-	{ .parent = &sys_altclk,    .rates = omap_54m_alt_rates },
-	{ .parent = NULL }
-};
-
-static struct clk omap_54m_fck = {
-	.name		= "omap_54m_fck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_SOURCE_54M_MASK,
-	.clksel		= omap_54m_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate omap_48m_cm96m_rates[] = {
-	{ .div = 2, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate omap_48m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel omap_48m_clksel[] = {
-	{ .parent = &cm_96m_fck, .rates = omap_48m_cm96m_rates },
-	{ .parent = &sys_altclk, .rates = omap_48m_alt_rates },
-	{ .parent = NULL }
-};
-
-static struct clk omap_48m_fck = {
-	.name		= "omap_48m_fck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_SOURCE_48M_MASK,
-	.clksel		= omap_48m_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk omap_12m_fck = {
-	.name		= "omap_12m_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_48m_fck,
-	.fixed_div	= 4,
-	.recalc		= &omap2_fixed_divisor_recalc,
-};
-
-/* This virstual clock is the source for dpll4_m4x2_ck */
-static struct clk dpll4_m4_ck = {
-	.name		= "dpll4_m4_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-	.set_rate	= &omap2_clksel_set_rate,
-	.round_rate	= &omap2_clksel_round_rate,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m4x2_ck = {
-	.name		= "dpll4_m4x2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dpll4_m4_ck,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.flags		= INVERT_ENABLE,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-/* This virtual clock is the source for dpll4_m5x2_ck */
-static struct clk dpll4_m5_ck = {
-	.name		= "dpll4_m5_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m5x2_ck = {
-	.name		= "dpll4_m5x2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dpll4_m5_ck,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.flags		= INVERT_ENABLE,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-/* This virtual clock is the source for dpll4_m6x2_ck */
-static struct clk dpll4_m6_ck = {
-	.name		= "dpll4_m6_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
-	.clksel		= div16_dpll4_clksel,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* The PWRDN bit is apparently only available on 3430ES2 and above */
-static struct clk dpll4_m6x2_ck = {
-	.name		= "dpll4_m6x2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dpll4_m6_ck,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
-	.flags		= INVERT_ENABLE,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-static struct clk emu_per_alwon_ck = {
-	.name		= "emu_per_alwon_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll4_m6x2_ck,
-	.clkdm_name	= "dpll4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* DPLL5 */
-/* Supplies 120MHz clock, USIM source clock */
-/* Type: DPLL */
-/* 3430ES2 only */
-static struct dpll_data dpll5_dd = {
-	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL4),
-	.mult_mask	= OMAP3430ES2_PERIPH2_DPLL_MULT_MASK,
-	.div1_mask	= OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
-	.clk_bypass	= &sys_ck,
-	.clk_ref	= &sys_ck,
-	.freqsel_mask	= OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK,
-	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKEN2),
-	.enable_mask	= OMAP3430ES2_EN_PERIPH2_DPLL_MASK,
-	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
-	.auto_recal_bit	= OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT,
-	.recal_en_bit	= OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT,
-	.recal_st_bit	= OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT,
-	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_PLL),
-	.autoidle_mask	= OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
-	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
-	.idlest_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
-	.max_multiplier = OMAP3_MAX_DPLL_MULT,
-	.min_divider	= 1,
-	.max_divider	= OMAP3_MAX_DPLL_DIV,
-	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
-};
-
-static struct clk dpll5_ck = {
-	.name		= "dpll5_ck",
-	.ops		= &clkops_noncore_dpll_ops,
-	.parent		= &sys_ck,
-	.dpll_data	= &dpll5_dd,
-	.round_rate	= &omap2_dpll_round_rate,
-	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.clkdm_name	= "dpll5_clkdm",
-	.recalc		= &omap3_dpll_recalc,
-};
-
-static const struct clksel div16_dpll5_clksel[] = {
-	{ .parent = &dpll5_ck, .rates = div16_dpll_rates },
-	{ .parent = NULL }
-};
-
-static struct clk dpll5_m2_ck = {
-	.name		= "dpll5_m2_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll5_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
-	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
-	.clksel		= div16_dpll5_clksel,
-	.clkdm_name	= "dpll5_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* CM EXTERNAL CLOCK OUTPUTS */
-
-static const struct clksel_rate clkout2_src_core_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate clkout2_src_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate clkout2_src_96m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate clkout2_src_54m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel clkout2_src_clksel[] = {
-	{ .parent = &core_ck,		.rates = clkout2_src_core_rates },
-	{ .parent = &sys_ck,		.rates = clkout2_src_sys_rates },
-	{ .parent = &cm_96m_fck,	.rates = clkout2_src_96m_rates },
-	{ .parent = &omap_54m_fck,	.rates = clkout2_src_54m_rates },
-	{ .parent = NULL }
-};
-
-static struct clk clkout2_src_ck = {
-	.name		= "clkout2_src_ck",
-	.ops		= &clkops_omap2_dflt,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP3430_CM_CLKOUT_CTRL,
-	.enable_bit	= OMAP3430_CLKOUT2_EN_SHIFT,
-	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
-	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
-	.clksel		= clkout2_src_clksel,
-	.clkdm_name	= "core_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate sys_clkout2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 16, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel sys_clkout2_clksel[] = {
-	{ .parent = &clkout2_src_ck, .rates = sys_clkout2_rates },
-	{ .parent = NULL },
-};
-
-static struct clk sys_clkout2 = {
-	.name		= "sys_clkout2",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
-	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
-	.clksel		= sys_clkout2_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* CM OUTPUT CLOCKS */
-
-static struct clk corex2_fck = {
-	.name		= "corex2_fck",
-	.ops		= &clkops_null,
-	.parent		= &dpll3_m2x2_ck,
-	.recalc		= &followparent_recalc,
-};
-
-/* DPLL power domain clock controls */
-
-static const struct clksel_rate div4_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 0 }
-};
-
-static const struct clksel div4_core_clksel[] = {
-	{ .parent = &core_ck, .rates = div4_rates },
-	{ .parent = NULL }
-};
-
-/*
- * REVISIT: Are these in DPLL power domain or CM power domain? docs
- * may be inconsistent here?
- */
-static struct clk dpll1_fck = {
-	.name		= "dpll1_fck",
-	.ops		= &clkops_null,
-	.parent		= &core_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
-	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
-	.clksel		= div4_core_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk mpu_ck = {
-	.name		= "mpu_ck",
-	.ops		= &clkops_null,
-	.parent		= &dpll1_x2m2_ck,
-	.clkdm_name	= "mpu_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu_ck */
-static const struct clksel_rate arm_fck_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel arm_fck_clksel[] = {
-	{ .parent = &mpu_ck, .rates = arm_fck_rates },
-	{ .parent = NULL }
-};
-
-static struct clk arm_fck = {
-	.name		= "arm_fck",
-	.ops		= &clkops_null,
-	.parent		= &mpu_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
-	.clksel		= arm_fck_clksel,
-	.clkdm_name	= "mpu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* XXX What about neon_clkdm ? */
-
-/*
- * REVISIT: This clock is never specifically defined in the 3430 TRM,
- * although it is referenced - so this is a guess
- */
-static struct clk emu_mpu_alwon_ck = {
-	.name		= "emu_mpu_alwon_ck",
-	.ops		= &clkops_null,
-	.parent		= &mpu_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dpll2_fck = {
-	.name		= "dpll2_fck",
-	.ops		= &clkops_null,
-	.parent		= &core_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
-	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
-	.clksel		= div4_core_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk iva2_ck = {
-	.name		= "iva2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dpll2_m2_ck,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
-	.clkdm_name	= "iva2_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* Common interface clocks */
-
-static const struct clksel div2_core_clksel[] = {
-	{ .parent = &core_ck, .rates = div2_rates },
-	{ .parent = NULL }
-};
-
-static struct clk l3_ick = {
-	.name		= "l3_ick",
-	.ops		= &clkops_null,
-	.parent		= &core_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
-	.clksel		= div2_core_clksel,
-	.clkdm_name	= "core_l3_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel div2_l3_clksel[] = {
-	{ .parent = &l3_ick, .rates = div2_rates },
-	{ .parent = NULL }
-};
-
-static struct clk l4_ick = {
-	.name		= "l4_ick",
-	.ops		= &clkops_null,
-	.parent		= &l3_ick,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
-	.clksel		= div2_l3_clksel,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-
-};
-
-static const struct clksel div2_l4_clksel[] = {
-	{ .parent = &l4_ick, .rates = div2_rates },
-	{ .parent = NULL }
-};
-
-static struct clk rm_ick = {
-	.name		= "rm_ick",
-	.ops		= &clkops_null,
-	.parent		= &l4_ick,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_RM_MASK,
-	.clksel		= div2_l4_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* GFX power domain */
-
-/* GFX clocks are in 3430ES1 only. 3430ES2 and later uses the SGX instead */
-
-static const struct clksel gfx_l3_clksel[] = {
-	{ .parent = &l3_ick, .rates = gfx_l3_rates },
-	{ .parent = NULL }
-};
-
-/* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
-static struct clk gfx_l3_ck = {
-	.name		= "gfx_l3_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l3_ick,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP_EN_GFX_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gfx_l3_fck = {
-	.name		= "gfx_l3_fck",
-	.ops		= &clkops_null,
-	.parent		= &gfx_l3_ck,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
-	.clksel		= gfx_l3_clksel,
-	.clkdm_name	= "gfx_3430es1_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gfx_l3_ick = {
-	.name		= "gfx_l3_ick",
-	.ops		= &clkops_null,
-	.parent		= &gfx_l3_ck,
-	.clkdm_name	= "gfx_3430es1_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gfx_cg1_ck = {
-	.name		= "gfx_cg1_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES1_EN_2D_SHIFT,
-	.clkdm_name	= "gfx_3430es1_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gfx_cg2_ck = {
-	.name		= "gfx_cg2_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES1_EN_3D_SHIFT,
-	.clkdm_name	= "gfx_3430es1_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* SGX power domain - 3430ES2 only */
-
-static const struct clksel_rate sgx_core_rates[] = {
-	{ .div = 3, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 4, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate sgx_96m_rates[] = {
-	{ .div = 1,  .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 },
-};
-
-static const struct clksel sgx_clksel[] = {
-	{ .parent = &core_ck,	 .rates = sgx_core_rates },
-	{ .parent = &cm_96m_fck, .rates = sgx_96m_rates },
-	{ .parent = NULL },
-};
-
-static struct clk sgx_fck = {
-	.name		= "sgx_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430ES2_CLKSEL_SGX_MASK,
-	.clksel		= sgx_clksel,
-	.clkdm_name	= "sgx_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk sgx_ick = {
-	.name		= "sgx_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l3_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT,
-	.clkdm_name	= "sgx_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* CORE power domain */
-
-static struct clk d2d_26m_fck = {
-	.name		= "d2d_26m_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &sys_ck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430ES1_EN_D2D_SHIFT,
-	.clkdm_name	= "d2d_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk modem_fck = {
-	.name		= "modem_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &sys_ck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MODEM_SHIFT,
-	.clkdm_name	= "d2d_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk sad2d_ick = {
-	.name		= "sad2d_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l3_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_SAD2D_SHIFT,
-	.clkdm_name	= "d2d_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mad2d_ick = {
-	.name		= "mad2d_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l3_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
-	.enable_bit	= OMAP3430_EN_MAD2D_SHIFT,
-	.clkdm_name	= "d2d_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel omap343x_gpt_clksel[] = {
-	{ .parent = &omap_32k_fck, .rates = gpt_32k_rates },
-	{ .parent = &sys_ck,	   .rates = gpt_sys_rates },
-	{ .parent = NULL}
-};
-
-static struct clk gpt10_fck = {
-	.name		= "gpt10_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &sys_ck,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT10_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt11_fck = {
-	.name		= "gpt11_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &sys_ck,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT11_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk cpefuse_fck = {
-	.name		= "cpefuse_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &sys_ck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
-	.enable_bit	= OMAP3430ES2_EN_CPEFUSE_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk ts_fck = {
-	.name		= "ts_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &omap_32k_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
-	.enable_bit	= OMAP3430ES2_EN_TS_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usbtll_fck = {
-	.name		= "usbtll_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &dpll5_m2_ck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
-	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/* CORE 96M FCLK-derived clocks */
-
-static struct clk core_96m_fck = {
-	.name		= "core_96m_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_96m_fck,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs3_fck = {
-	.name		= "mmchs_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs2_fck = {
-	.name		= "mmchs_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mspro_fck = {
-	.name		= "mspro_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs1_fck = {
-	.name		= "mmchs_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk i2c3_fck = {
-	.name		= "i2c_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk i2c2_fck = {
-	.name		= "i2c_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk i2c1_fck = {
-	.name		= "i2c_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/*
- * MCBSP 1 & 5 get their 96MHz clock from core_96m_fck;
- * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
- */
-static const struct clksel_rate common_mcbsp_96m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel mcbsp_15_clksel[] = {
-	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
-	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
-	{ .parent = NULL }
-};
-
-static struct clk mcbsp5_fck = {
-	.name		= "mcbsp_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 5,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
-	.clksel		= mcbsp_15_clksel,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk mcbsp1_fck = {
-	.name		= "mcbsp_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
-	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
-	.clksel		= mcbsp_15_clksel,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* CORE_48M_FCK-derived clocks */
-
-static struct clk core_48m_fck = {
-	.name		= "core_48m_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_48m_fck,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi4_fck = {
-	.name		= "mcspi_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
-	.parent		= &core_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi3_fck = {
-	.name		= "mcspi_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
-	.parent		= &core_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi2_fck = {
-	.name		= "mcspi_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.parent		= &core_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi1_fck = {
-	.name		= "mcspi_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.parent		= &core_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart2_fck = {
-	.name		= "uart2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart1_fck = {
-	.name		= "uart1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk fshostusb_fck = {
-	.name		= "fshostusb_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/* CORE_12M_FCK based clocks */
-
-static struct clk core_12m_fck = {
-	.name		= "core_12m_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_12m_fck,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk hdq_fck = {
-	.name		= "hdq_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_12m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/* DPLL3-derived clock */
-
-static const struct clksel_rate ssi_ssr_corex2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
-	{ .div = 0 }
-};
-
-static const struct clksel ssi_ssr_clksel[] = {
-	{ .parent = &corex2_fck, .rates = ssi_ssr_corex2_rates },
-	{ .parent = NULL }
-};
-
-static struct clk ssi_ssr_fck_3430es1 = {
-	.name		= "ssi_ssr_fck",
-	.ops		= &clkops_omap2_dflt,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
-	.clksel		= ssi_ssr_clksel,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk ssi_ssr_fck_3430es2 = {
-	.name		= "ssi_ssr_fck",
-	.ops		= &clkops_omap3430es2_ssi_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
-	.clksel		= ssi_ssr_clksel,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk ssi_sst_fck_3430es1 = {
-	.name		= "ssi_sst_fck",
-	.ops		= &clkops_null,
-	.parent		= &ssi_ssr_fck_3430es1,
-	.fixed_div	= 2,
-	.recalc		= &omap2_fixed_divisor_recalc,
-};
-
-static struct clk ssi_sst_fck_3430es2 = {
-	.name		= "ssi_sst_fck",
-	.ops		= &clkops_null,
-	.parent		= &ssi_ssr_fck_3430es2,
-	.fixed_div	= 2,
-	.recalc		= &omap2_fixed_divisor_recalc,
-};
-
-
-
-/* CORE_L3_ICK based clocks */
-
-/*
- * XXX must add clk_enable/clk_disable for these if standard code won't
- * handle it
- */
-static struct clk core_l3_ick = {
-	.name		= "core_l3_ick",
-	.ops		= &clkops_null,
-	.parent		= &l3_ick,
-	.clkdm_name	= "core_l3_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk hsotgusb_ick_3430es1 = {
-	.name		= "hsotgusb_ick",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &core_l3_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
-	.clkdm_name	= "core_l3_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk hsotgusb_ick_3430es2 = {
-	.name		= "hsotgusb_ick",
-	.ops		= &clkops_omap3430es2_hsotgusb_wait,
-	.parent		= &core_l3_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
-	.clkdm_name	= "core_l3_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk sdrc_ick = {
-	.name		= "sdrc_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l3_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
-	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l3_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpmc_fck = {
-	.name		= "gpmc_fck",
-	.ops		= &clkops_null,
-	.parent		= &core_l3_ick,
-	.flags		= ENABLE_ON_INIT, /* huh? */
-	.clkdm_name	= "core_l3_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* SECURITY_L3_ICK based clocks */
-
-static struct clk security_l3_ick = {
-	.name		= "security_l3_ick",
-	.ops		= &clkops_null,
-	.parent		= &l3_ick,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk pka_ick = {
-	.name		= "pka_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &security_l3_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP3430_EN_PKA_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/* CORE_L4_ICK based clocks */
-
-static struct clk core_l4_ick = {
-	.name		= "core_l4_ick",
-	.ops		= &clkops_null,
-	.parent		= &l4_ick,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usbtll_ick = {
-	.name		= "usbtll_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
-	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs3_ick = {
-	.name		= "mmchs_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* Intersystem Communication Registers - chassis mode only */
-static struct clk icr_ick = {
-	.name		= "icr_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_ICR_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk aes2_ick = {
-	.name		= "aes2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_AES2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk sha12_ick = {
-	.name		= "sha12_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_SHA12_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk des2_ick = {
-	.name		= "des2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_DES2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs2_ick = {
-	.name		= "mmchs_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs1_ick = {
-	.name		= "mmchs_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mspro_ick = {
-	.name		= "mspro_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk hdq_ick = {
-	.name		= "hdq_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi4_ick = {
-	.name		= "mcspi_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi3_ick = {
-	.name		= "mcspi_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi2_ick = {
-	.name		= "mcspi_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi1_ick = {
-	.name		= "mcspi_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk i2c3_ick = {
-	.name		= "i2c_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk i2c2_ick = {
-	.name		= "i2c_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk i2c1_ick = {
-	.name		= "i2c_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart2_ick = {
-	.name		= "uart2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart1_ick = {
-	.name		= "uart1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt11_ick = {
-	.name		= "gpt11_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt10_ick = {
-	.name		= "gpt10_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp5_ick = {
-	.name		= "mcbsp_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 5,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp1_ick = {
-	.name		= "mcbsp_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk fac_ick = {
-	.name		= "fac_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430ES1_EN_FAC_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mailboxes_ick = {
-	.name		= "mailboxes_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_MAILBOXES_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk omapctrl_ick = {
-	.name		= "omapctrl_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
-	.flags		= ENABLE_ON_INIT,
-	.recalc		= &followparent_recalc,
-};
-
-/* SSI_L4_ICK based clocks */
-
-static struct clk ssi_l4_ick = {
-	.name		= "ssi_l4_ick",
-	.ops		= &clkops_null,
-	.parent		= &l4_ick,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk ssi_ick_3430es1 = {
-	.name		= "ssi_ick",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &ssi_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk ssi_ick_3430es2 = {
-	.name		= "ssi_ick",
-	.ops		= &clkops_omap3430es2_ssi_wait,
-	.parent		= &ssi_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* REVISIT: Technically the TRM claims that this is CORE_CLK based,
- * but l4_ick makes more sense to me */
-
-static const struct clksel usb_l4_clksel[] = {
-	{ .parent = &l4_ick, .rates = div2_rates },
-	{ .parent = NULL },
-};
-
-static struct clk usb_l4_ick = {
-	.name		= "usb_l4_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ick,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
-	.clksel		= usb_l4_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* SECURITY_L4_ICK2 based clocks */
-
-static struct clk security_l4_ick2 = {
-	.name		= "security_l4_ick2",
-	.ops		= &clkops_null,
-	.parent		= &l4_ick,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk aes1_ick = {
-	.name		= "aes1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &security_l4_ick2,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP3430_EN_AES1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk rng_ick = {
-	.name		= "rng_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &security_l4_ick2,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP3430_EN_RNG_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk sha11_ick = {
-	.name		= "sha11_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &security_l4_ick2,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP3430_EN_SHA11_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk des1_ick = {
-	.name		= "des1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &security_l4_ick2,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP3430_EN_DES1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/* DSS */
-static struct clk dss1_alwon_fck_3430es1 = {
-	.name		= "dss1_alwon_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &dpll4_m4x2_ck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
-	.clkdm_name	= "dss_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dss1_alwon_fck_3430es2 = {
-	.name		= "dss1_alwon_fck",
-	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
-	.parent		= &dpll4_m4x2_ck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
-	.clkdm_name	= "dss_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dss_tv_fck = {
-	.name		= "dss_tv_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &omap_54m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_TV_SHIFT,
-	.clkdm_name	= "dss_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dss_96m_fck = {
-	.name		= "dss_96m_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &omap_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_TV_SHIFT,
-	.clkdm_name	= "dss_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dss2_alwon_fck = {
-	.name		= "dss2_alwon_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &sys_ck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_DSS2_SHIFT,
-	.clkdm_name	= "dss_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dss_ick_3430es1 = {
-	/* Handles both L3 and L4 clocks */
-	.name		= "dss_ick",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
-	.clkdm_name	= "dss_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dss_ick_3430es2 = {
-	/* Handles both L3 and L4 clocks */
-	.name		= "dss_ick",
-	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
-	.parent		= &l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
-	.clkdm_name	= "dss_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* CAM */
-
-static struct clk cam_mclk = {
-	.name		= "cam_mclk",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &dpll4_m5x2_ck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
-	.clkdm_name	= "cam_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk cam_ick = {
-	/* Handles both L3 and L4 clocks */
-	.name		= "cam_ick",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
-	.clkdm_name	= "cam_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk csi2_96m_fck = {
-	.name		= "csi2_96m_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &core_96m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
-	.clkdm_name	= "cam_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* USBHOST - 3430ES2 only */
-
-static struct clk usbhost_120m_fck = {
-	.name		= "usbhost_120m_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &dpll5_m2_ck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES2_EN_USBHOST2_SHIFT,
-	.clkdm_name	= "usbhost_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usbhost_48m_fck = {
-	.name		= "usbhost_48m_fck",
-	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
-	.parent		= &omap_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES2_EN_USBHOST1_SHIFT,
-	.clkdm_name	= "usbhost_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usbhost_ick = {
-	/* Handles both L3 and L4 clocks */
-	.name		= "usbhost_ick",
-	.ops		= &clkops_omap3430es2_dss_usbhost_wait,
-	.parent		= &l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
-	.clkdm_name	= "usbhost_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* WKUP */
-
-static const struct clksel_rate usim_96m_rates[] = {
-	{ .div = 2,  .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 4,  .val = 4, .flags = RATE_IN_343X },
-	{ .div = 8,  .val = 5, .flags = RATE_IN_343X },
-	{ .div = 10, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate usim_120m_rates[] = {
-	{ .div = 4,  .val = 7,	.flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 8,  .val = 8,	.flags = RATE_IN_343X },
-	{ .div = 16, .val = 9,	.flags = RATE_IN_343X },
-	{ .div = 20, .val = 10, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel usim_clksel[] = {
-	{ .parent = &omap_96m_fck,	.rates = usim_96m_rates },
-	{ .parent = &dpll5_m2_ck,	.rates = usim_120m_rates },
-	{ .parent = &sys_ck,		.rates = div2_rates },
-	{ .parent = NULL },
-};
-
-/* 3430ES2 only */
-static struct clk usim_fck = {
-	.name		= "usim_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430ES2_CLKSEL_USIMOCP_MASK,
-	.clksel		= usim_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
-static struct clk gpt1_fck = {
-	.name		= "gpt1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT1_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk wkup_32k_fck = {
-	.name		= "wkup_32k_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_32k_fck,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio1_dbck = {
-	.name		= "gpio1_dbck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &wkup_32k_fck,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wdt2_fck = {
-	.name		= "wdt2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_32k_fck,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wkup_l4_ick = {
-	.name		= "wkup_l4_ick",
-	.ops		= &clkops_null,
-	.parent		= &sys_ck,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* 3430ES2 only */
-/* Never specifically named in the TRM, so we have to infer a likely name */
-static struct clk usim_ick = {
-	.name		= "usim_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wdt2_ick = {
-	.name		= "wdt2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wdt1_ick = {
-	.name		= "wdt1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio1_ick = {
-	.name		= "gpio1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk omap_32ksync_ick = {
-	.name		= "omap_32ksync_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_32KSYNC_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* XXX This clock no longer exists in 3430 TRM rev F */
-static struct clk gpt12_ick = {
-	.name		= "gpt12_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT12_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt1_ick = {
-	.name		= "gpt1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &wkup_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
-	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-
-
-/* PER clock domain */
-
-static struct clk per_96m_fck = {
-	.name		= "per_96m_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_96m_alwon_fck,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk per_48m_fck = {
-	.name		= "per_48m_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_48m_fck,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart3_fck = {
-	.name		= "uart3_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_48m_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt2_fck = {
-	.name		= "gpt2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT2_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt3_fck = {
-	.name		= "gpt3_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT3_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt4_fck = {
-	.name		= "gpt4_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT4_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt5_fck = {
-	.name		= "gpt5_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT5_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt6_fck = {
-	.name		= "gpt6_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT6_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt7_fck = {
-	.name		= "gpt7_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT7_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt8_fck = {
-	.name		= "gpt8_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT8_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gpt9_fck = {
-	.name		= "gpt9_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_GPT9_MASK,
-	.clksel		= omap343x_gpt_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk per_32k_alwon_fck = {
-	.name		= "per_32k_alwon_fck",
-	.ops		= &clkops_null,
-	.parent		= &omap_32k_fck,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio6_dbck = {
-	.name		= "gpio6_dbck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &per_32k_alwon_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio5_dbck = {
-	.name		= "gpio5_dbck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &per_32k_alwon_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio4_dbck = {
-	.name		= "gpio4_dbck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &per_32k_alwon_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio3_dbck = {
-	.name		= "gpio3_dbck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &per_32k_alwon_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio2_dbck = {
-	.name		= "gpio2_dbck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &per_32k_alwon_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wdt3_fck = {
-	.name		= "wdt3_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_32k_alwon_fck,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk per_l4_ick = {
-	.name		= "per_l4_ick",
-	.ops		= &clkops_null,
-	.parent		= &l4_ick,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio6_ick = {
-	.name		= "gpio6_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio5_ick = {
-	.name		= "gpio5_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio4_ick = {
-	.name		= "gpio4_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio3_ick = {
-	.name		= "gpio3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio2_ick = {
-	.name		= "gpio2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wdt3_ick = {
-	.name		= "wdt3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk uart3_ick = {
-	.name		= "uart3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt9_ick = {
-	.name		= "gpt9_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt8_ick = {
-	.name		= "gpt8_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt7_ick = {
-	.name		= "gpt7_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt6_ick = {
-	.name		= "gpt6_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt5_ick = {
-	.name		= "gpt5_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt4_ick = {
-	.name		= "gpt4_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt3_ick = {
-	.name		= "gpt3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpt2_ick = {
-	.name		= "gpt2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp2_ick = {
-	.name		= "mcbsp_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp3_ick = {
-	.name		= "mcbsp_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp4_ick = {
-	.name		= "mcbsp_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
-	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel mcbsp_234_clksel[] = {
-	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
-	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
-	{ .parent = NULL }
-};
-
-static struct clk mcbsp2_fck = {
-	.name		= "mcbsp_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
-	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
-	.clksel		= mcbsp_234_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk mcbsp3_fck = {
-	.name		= "mcbsp_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
-	.clksel		= mcbsp_234_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk mcbsp4_fck = {
-	.name		= "mcbsp_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
-	.init		= &omap2_init_clksel_parent,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
-	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
-	.clksel		= mcbsp_234_clksel,
-	.clkdm_name	= "per_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* EMU clocks */
-
-/* More information: ARM Cortex-A8 Technical Reference Manual, sect 10.1 */
-
-static const struct clksel_rate emu_src_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate emu_src_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate emu_src_per_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate emu_src_mpu_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 0 },
-};
-
-static const struct clksel emu_src_clksel[] = {
-	{ .parent = &sys_ck,		.rates = emu_src_sys_rates },
-	{ .parent = &emu_core_alwon_ck, .rates = emu_src_core_rates },
-	{ .parent = &emu_per_alwon_ck,	.rates = emu_src_per_rates },
-	{ .parent = &emu_mpu_alwon_ck,	.rates = emu_src_mpu_rates },
-	{ .parent = NULL },
-};
-
-/*
- * Like the clkout_src clocks, emu_src_clk is a virtual clock, existing only
- * to switch the source of some of the EMU clocks.
- * XXX Are there CLKEN bits for these EMU clks?
- */
-static struct clk emu_src_ck = {
-	.name		= "emu_src_ck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
-	.clksel		= emu_src_clksel,
-	.clkdm_name	= "emu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate pclk_emu_rates[] = {
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel pclk_emu_clksel[] = {
-	{ .parent = &emu_src_ck, .rates = pclk_emu_rates },
-	{ .parent = NULL },
-};
-
-static struct clk pclk_fck = {
-	.name		= "pclk_fck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
-	.clksel		= pclk_emu_clksel,
-	.clkdm_name	= "emu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate pclkx2_emu_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel pclkx2_emu_clksel[] = {
-	{ .parent = &emu_src_ck, .rates = pclkx2_emu_rates },
-	{ .parent = NULL },
-};
-
-static struct clk pclkx2_fck = {
-	.name		= "pclkx2_fck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
-	.clksel		= pclkx2_emu_clksel,
-	.clkdm_name	= "emu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel atclk_emu_clksel[] = {
-	{ .parent = &emu_src_ck, .rates = div2_rates },
-	{ .parent = NULL },
-};
-
-static struct clk atclk_fck = {
-	.name		= "atclk_fck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
-	.clksel		= atclk_emu_clksel,
-	.clkdm_name	= "emu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk traceclk_src_fck = {
-	.name		= "traceclk_src_fck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
-	.clksel		= emu_src_clksel,
-	.clkdm_name	= "emu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static const struct clksel_rate traceclk_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
-static const struct clksel traceclk_clksel[] = {
-	{ .parent = &traceclk_src_fck, .rates = traceclk_rates },
-	{ .parent = NULL },
-};
-
-static struct clk traceclk_fck = {
-	.name		= "traceclk_fck",
-	.ops		= &clkops_null,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_CLKSEL_TRACECLK_MASK,
-	.clksel		= traceclk_clksel,
-	.clkdm_name	= "emu_clkdm",
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* SR clocks */
-
-/* SmartReflex fclk (VDD1) */
-static struct clk sr1_fck = {
-	.name		= "sr1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &sys_ck,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/* SmartReflex fclk (VDD2) */
-static struct clk sr2_fck = {
-	.name		= "sr2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &sys_ck,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk sr_l4_ick = {
-	.name		= "sr_l4_ick",
-	.ops		= &clkops_null, /* RMK: missing? */
-	.parent		= &l4_ick,
-	.clkdm_name	= "core_l4_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
-/* SECURE_32K_FCK clocks */
-
-static struct clk gpt12_fck = {
-	.name		= "gpt12_fck",
-	.ops		= &clkops_null,
-	.parent		= &secure_32k_fck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wdt1_fck = {
-	.name		= "wdt1_fck",
-	.ops		= &clkops_null,
-	.parent		= &secure_32k_fck,
-	.recalc		= &followparent_recalc,
-};
+extern struct clk *sdrc_ick_p;
+extern struct clk *arm_fck_p;
 
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx_data.c
similarity index 86%
copy from arch/arm/mach-omap2/clock34xx.h
copy to arch/arm/mach-omap2/clock34xx_data.c
index 8fe1bcb..22ab592 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -1,8 +1,8 @@
 /*
- * OMAP3 clock framework
+ * OMAP3 clock data
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * With many device clock fixes by Kevin Hilman and Jouni H?gander
@@ -16,27 +16,55 @@
  * to be requested from drivers directly.
  */
 
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
 
 #include <plat/control.h>
+#include <plat/clkdev_omap.h>
 
 #include "clock.h"
+#include "clock34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 
-#define OMAP_CM_REGADDR		OMAP34XX_CM_REGADDR
+/*
+ * clkops
+ */
+
+static const struct clkops clkops_omap3430es2_ssi_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
+	.find_companion = omap2_clk_dflt_find_companion,
+};
+
+static const struct clkops clkops_omap3430es2_hsotgusb_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
+	.find_companion = omap2_clk_dflt_find_companion,
+};
+
+static const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
+	.find_companion = omap2_clk_dflt_find_companion,
+};
+
+static const struct clkops clkops_noncore_dpll_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+};
+
+/*
+ * clocks
+ */
 
-static unsigned long omap3_dpll_recalc(struct clk *clk);
-static unsigned long omap3_clkoutx2_recalc(struct clk *clk);
-static void omap3_dpll_allow_idle(struct clk *clk);
-static void omap3_dpll_deny_idle(struct clk *clk);
-static u32 omap3_dpll_autoidle_read(struct clk *clk);
-static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
-static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
-static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
+#define OMAP_CM_REGADDR		OMAP34XX_CM_REGADDR
 
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
@@ -54,11 +82,6 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
 static struct clk dpll1_fck;
 static struct clk dpll2_fck;
 
-/* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
-#define DPLL_LOW_POWER_STOP		0x1
-#define DPLL_LOW_POWER_BYPASS		0x5
-#define DPLL_LOCKED			0x7
-
 /* PRM CLOCKS */
 
 /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
@@ -2990,4 +3013,307 @@ static struct clk wdt1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+
+/*
+ * clkdev
+ */
+
+static struct omap_clk omap34xx_clks[] = {
+	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_343X),
+	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_343X),
+	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X),
+	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
+	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_343X),
+	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_343X),
+	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_343X),
+	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_343X),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_343X),
+	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_343X),
+	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_343X),
+	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_343X),
+	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_343X),
+	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_343X),
+	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_343X),
+	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_343X),
+	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_343X),
+	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_343X),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_343X),
+	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_343X),
+	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_343X),
+	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
+	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_343X),
+	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
+	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
+	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_343X),
+	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_343X),
+	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
+	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_343X),
+	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_343X),
+	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_343X),
+	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck,	CK_343X),
+	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_343X),
+	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
+	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
+	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
+	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2),
+	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_343X),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_343X),
+	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_343X),
+	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_343X),
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_343X),
+	CLK(NULL,	"arm_fck",	&arm_fck,	CK_343X),
+	CLK(NULL,	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
+	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_343X),
+	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_343X),
+	CLK(NULL,	"l3_ick",	&l3_ick,	CK_343X),
+	CLK(NULL,	"l4_ick",	&l4_ick,	CK_343X),
+	CLK(NULL,	"rm_ick",	&rm_ick,	CK_343X),
+	CLK(NULL,	"gfx_l3_ck",	&gfx_l3_ck,	CK_3430ES1),
+	CLK(NULL,	"gfx_l3_fck",	&gfx_l3_fck,	CK_3430ES1),
+	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
+	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
+	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
+	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2),
+	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2),
+	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
+	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
+	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
+	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_343X),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_343X),
+	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2),
+	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2),
+	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2),
+	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_343X),
+	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2),
+	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_343X),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
+	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_343X),
+	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_343X),
+	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_343X),
+	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_343X),
+	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_343X),
+	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_343X),
+	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_343X),
+	CLK("omap2_mcspi.4", "fck",	&mcspi4_fck,	CK_343X),
+	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_343X),
+	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_343X),
+	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_343X),
+	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_343X),
+	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_343X),
+	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
+	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_343X),
+	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_343X),
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1,	CK_3430ES1),
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1,	CK_3430ES1),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2,	CK_3430ES2),
+	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
+	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
+	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_343X),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_343X),
+	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_343X),
+	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_343X),
+	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2),
+	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2),
+	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
+	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_343X),
+	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_343X),
+	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
+	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_343X),
+	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_343X),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
+	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_343X),
+	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_343X),
+	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_343X),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_343X),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_343X),
+	CLK("i2c_omap.3", "ick",	&i2c3_ick,	CK_343X),
+	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_343X),
+	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_343X),
+	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_343X),
+	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_343X),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_343X),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_343X),
+	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_343X),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_343X),
+	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_343X),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_343X),
+	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1,	CK_3430ES1),
+	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
+	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_343X),
+	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_343X),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
+	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
+	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
+	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
+	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2),
+	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_343X),
+	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_343X),
+	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
+	CLK("omapdss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
+	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2),
+	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
+	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
+	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
+	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
+	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
+	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2),
+	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
+	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
+	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
+	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
+	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
+	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
+	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_343X),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
+	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
+	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_343X),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_343X),
+	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_343X),
+	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_343X),
+	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_343X),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_343X),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_343X),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_343X),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_343X),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_343X),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_343X),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_343X),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_343X),
+	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_343X),
+	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_343X),
+	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_343X),
+	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_343X),
+	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_343X),
+	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_343X),
+	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_343X),
+	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_343X),
+	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_343X),
+	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_343X),
+	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_343X),
+	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_343X),
+	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_343X),
+	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_343X),
+	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_343X),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_343X),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_343X),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_343X),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_343X),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_343X),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_343X),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_343X),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_343X),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_343X),
+	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_343X),
+	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_343X),
+	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_343X),
+	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_343X),
+	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_343X),
+	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_343X),
+	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_343X),
+	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_343X),
+	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_343X),
+	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_343X),
+	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_343X),
+	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_343X),
+	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
+	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
+	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
+	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
+};
+
+
+int __init omap2_clk_init(void)
+{
+	/* struct prcm_config *prcm; */
+	struct omap_clk *c;
+	/* u32 clkrate; */
+	u32 cpu_clkflg;
+
+	if (cpu_is_omap34xx()) {
+		cpu_mask = RATE_IN_343X;
+		cpu_clkflg = CK_343X;
+
+		/*
+		 * Update this if there are further clock changes between ES2
+		 * and production parts
+		 */
+		if (omap_rev() == OMAP3430_REV_ES1_0) {
+			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
+			cpu_clkflg |= CK_3430ES1;
+		} else {
+			cpu_mask |= RATE_IN_3430ES2;
+			cpu_clkflg |= CK_3430ES2;
+		}
+	}
+
+	clk_init(&omap2_clk_functions);
+
+	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
+		clk_preinit(c->lk.clk);
+
+	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
+		if (c->cpu & cpu_clkflg) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
+			omap2_init_clk_clkdm(c->lk.clk);
+		}
+
+	/* REVISIT: Not yet ready for OMAP3 */
+#if 0
+	/* Check the MPU rate set by bootloader */
+	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+		if (prcm->dpll_speed <= clkrate)
+			break;
+	}
+	curr_prcm_set = prcm;
 #endif
+
+	recalculate_root_clocks();
+
+	printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
+	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable_init_clocks();
+
+	/*
+	 * Lock DPLL5 and put it in autoidle.
+	 */
+	if (omap_rev() >= OMAP3430_REV_ES2_0)
+		omap3_clk_lock_dpll5();
+
+	/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
+	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
+	arm_fck_p = clk_get(NULL, "arm_fck");
+
+	return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
new file mode 100644
index 0000000..d6121c0
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -0,0 +1,35 @@
+/*
+ * clkdev <-> OMAP integration
+ *
+ */
+
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_CLKDEV_OMAP_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_CLKDEV_OMAP_H
+
+#include <asm/clkdev.h>
+
+struct omap_clk {
+	u32		cpu;
+	struct clk_lookup lk;
+};
+
+#define CLK(dev, con, ck, cp) 		\
+	{				\
+		 .cpu = cp,		\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+			.clk = ck,	\
+		},			\
+	}
+
+
+#define CK_243X		(1 << 0)
+#define CK_242X		(1 << 1)
+#define CK_343X		(1 << 2)
+#define CK_3430ES1	(1 << 3)
+#define CK_3430ES2	(1 << 4)
+
+
+#endif
+
