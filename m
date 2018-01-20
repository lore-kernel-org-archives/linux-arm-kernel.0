From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:14:14 -0600
Subject: [PATCH v6 35/41] ARM: dm644x: Remove legacy clock init
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-36-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the unused legacy clock init code from
arch/arm/mach-davinci/dm644x.c.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- none

 arch/arm/mach-davinci/dm644x.c | 300 +----------------------------------------
 1 file changed, 1 insertion(+), 299 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 5b5de85..cf9cd69 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -32,11 +32,6 @@
 #include "davinci.h"
 #include "mux.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include "clock.h"
-#include "psc.h"
-#endif
-
 /*
  * Device specific clocks
  */
@@ -49,292 +44,6 @@
 #define DM644X_EMAC_CNTRL_RAM_OFFSET	0x2000
 #define DM644X_EMAC_CNTRL_RAM_SIZE	0x2000
 
-#ifndef CONFIG_COMMON_CLK
-static struct pll_data pll1_data = {
-	.num       = 1,
-	.phys_base = DAVINCI_PLL1_BASE,
-};
-
-static struct pll_data pll2_data = {
-	.num       = 2,
-	.phys_base = DAVINCI_PLL2_BASE,
-};
-
-static struct clk ref_clk = {
-	.name = "ref_clk",
-	.rate = DM644X_REF_FREQ,
-};
-
-static struct clk pll1_clk = {
-	.name = "pll1",
-	.parent = &ref_clk,
-	.pll_data = &pll1_data,
-	.flags = CLK_PLL,
-};
-
-static struct clk pll1_sysclk1 = {
-	.name = "pll1_sysclk1",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV1,
-};
-
-static struct clk pll1_sysclk2 = {
-	.name = "pll1_sysclk2",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV2,
-};
-
-static struct clk pll1_sysclk3 = {
-	.name = "pll1_sysclk3",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV3,
-};
-
-static struct clk pll1_sysclk5 = {
-	.name = "pll1_sysclk5",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV5,
-};
-
-static struct clk pll1_aux_clk = {
-	.name = "pll1_aux_clk",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll1_sysclkbp = {
-	.name = "pll1_sysclkbp",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
-};
-
-static struct clk pll2_clk = {
-	.name = "pll2",
-	.parent = &ref_clk,
-	.pll_data = &pll2_data,
-	.flags = CLK_PLL,
-};
-
-static struct clk pll2_sysclk1 = {
-	.name = "pll2_sysclk1",
-	.parent = &pll2_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV1,
-};
-
-static struct clk pll2_sysclk2 = {
-	.name = "pll2_sysclk2",
-	.parent = &pll2_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV2,
-};
-
-static struct clk pll2_sysclkbp = {
-	.name = "pll2_sysclkbp",
-	.parent = &pll2_clk,
-	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
-};
-
-static struct clk dsp_clk = {
-	.name = "dsp",
-	.parent = &pll1_sysclk1,
-	.lpsc = DAVINCI_LPSC_GEM,
-	.domain = DAVINCI_GPSC_DSPDOMAIN,
-	.usecount = 1,			/* REVISIT how to disable? */
-};
-
-static struct clk arm_clk = {
-	.name = "arm",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_ARM,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk vicp_clk = {
-	.name = "vicp",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_IMCOP,
-	.domain = DAVINCI_GPSC_DSPDOMAIN,
-	.usecount = 1,			/* REVISIT how to disable? */
-};
-
-static struct clk vpss_master_clk = {
-	.name = "vpss_master",
-	.parent = &pll1_sysclk3,
-	.lpsc = DAVINCI_LPSC_VPSSMSTR,
-	.flags = CLK_PSC,
-};
-
-static struct clk vpss_slave_clk = {
-	.name = "vpss_slave",
-	.parent = &pll1_sysclk3,
-	.lpsc = DAVINCI_LPSC_VPSSSLV,
-};
-
-static struct clk uart0_clk = {
-	.name = "uart0",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_UART0,
-};
-
-static struct clk uart1_clk = {
-	.name = "uart1",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_UART1,
-};
-
-static struct clk uart2_clk = {
-	.name = "uart2",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_UART2,
-};
-
-static struct clk emac_clk = {
-	.name = "emac",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_EMAC_WRAPPER,
-};
-
-static struct clk i2c_clk = {
-	.name = "i2c",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_I2C,
-};
-
-static struct clk ide_clk = {
-	.name = "ide",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_ATA,
-};
-
-static struct clk asp_clk = {
-	.name = "asp0",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_McBSP,
-};
-
-static struct clk mmcsd_clk = {
-	.name = "mmcsd",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_MMC_SD,
-};
-
-static struct clk spi_clk = {
-	.name = "spi",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_SPI,
-};
-
-static struct clk gpio_clk = {
-	.name = "gpio",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_GPIO,
-};
-
-static struct clk usb_clk = {
-	.name = "usb",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_USB,
-};
-
-static struct clk vlynq_clk = {
-	.name = "vlynq",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_VLYNQ,
-};
-
-static struct clk aemif_clk = {
-	.name = "aemif",
-	.parent = &pll1_sysclk5,
-	.lpsc = DAVINCI_LPSC_AEMIF,
-};
-
-static struct clk pwm0_clk = {
-	.name = "pwm0",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_PWM0,
-};
-
-static struct clk pwm1_clk = {
-	.name = "pwm1",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_PWM1,
-};
-
-static struct clk pwm2_clk = {
-	.name = "pwm2",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_PWM2,
-};
-
-static struct clk timer0_clk = {
-	.name = "timer0",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_TIMER0,
-};
-
-static struct clk timer1_clk = {
-	.name = "timer1",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_TIMER1,
-};
-
-static struct clk timer2_clk = {
-	.name = "timer2",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_TIMER2,
-	.usecount = 1,              /* REVISIT: why can't this be disabled? */
-};
-
-static struct clk_lookup dm644x_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk5", &pll1_sysclk5),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclk2", &pll2_sysclk2),
-	CLK(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
-	CLK(NULL, "dsp", &dsp_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "vicp", &vicp_clk),
-	CLK("vpss", "master", &vpss_master_clk),
-	CLK("vpss", "slave", &vpss_slave_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("serial8250.2", NULL, &uart2_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("davinci_mdio.0", "fck", &emac_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK("davinci-mcbsp", NULL, &asp_clk),
-	CLK("dm6441-mmc.0", NULL, &mmcsd_clk),
-	CLK(NULL, "spi", &spi_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK(NULL, "vlynq", &vlynq_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK(NULL, NULL, NULL),
-};
-#endif
-
 static struct emac_platform_data dm644x_emac_pdata = {
 	.ctrl_reg_offset	= DM644X_EMAC_CNTRL_OFFSET,
 	.ctrl_mod_reg_offset	= DM644X_EMAC_CNTRL_MOD_OFFSET,
@@ -827,8 +536,6 @@ static struct davinci_id dm644x_ids[] = {
 	},
 };
 
-static u32 dm644x_psc_bases[] = { DAVINCI_PWR_SLEEP_CNTRL_BASE };
-
 /*
  * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
  * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
@@ -913,8 +620,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm644x_ids,
 	.ids_num		= ARRAY_SIZE(dm644x_ids),
-	.psc_bases		= dm644x_psc_bases,
-	.psc_bases_num		= ARRAY_SIZE(dm644x_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
@@ -942,7 +647,6 @@ void __init dm644x_init(void)
 
 void __init dm644x_init_time(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	void __iomem *pll1, *pll2, *psc;
 
 	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_4K);
@@ -954,9 +658,7 @@ void __init dm644x_init_time(void)
 	dm644x_pll_clk_init(pll1, pll2);
 
 	dm644x_psc_clk_init(psc);
-#else
-	davinci_clk_init(dm644x_clks);
-#endif
+
 	davinci_timer_init();
 }
 
-- 
2.7.4
