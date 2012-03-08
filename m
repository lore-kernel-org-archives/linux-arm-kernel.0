From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Mar 2012 19:38:38 -0700
Subject: [PATCH 08/12] ARM: OMAP2xxx: hwmod data: share common hwmods between
 OMAP2420 and OMAP2430
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Message-ID: <20120308023837.8205.66638.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the link registration conversion, it's much easier to share some
hwmod data between OMAP2420 and 2430.  Move the shareable data into a
common file.  This should save some memory and lines of source, at the
cost of readability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  669 ++-----------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  688 ++------------------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  562 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   32 +
 4 files changed, 740 insertions(+), 1211 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index f74335f..75c57d3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -43,417 +43,12 @@
  * IP blocks
  */
 
-/* L3 */
-static struct omap_hwmod omap2420_l3_main_hwmod = {
-	.name		= "l3_main",
-	.class		= &l3_hwmod_class,
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-/* L4 CORE */
-static struct omap_hwmod omap2420_l4_core_hwmod = {
-	.name		= "l4_core",
-	.class		= &l4_hwmod_class,
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-/* L4 WKUP */
-static struct omap_hwmod omap2420_l4_wkup_hwmod = {
-	.name		= "l4_wkup",
-	.class		= &l4_hwmod_class,
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-/* MPU */
-static struct omap_hwmod omap2420_mpu_hwmod = {
-	.name		= "mpu",
-	.class		= &mpu_hwmod_class,
-	.main_clk	= "mpu_ck",
-};
-
 /* IVA2 (IVA2) */
 static struct omap_hwmod omap2420_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
 };
 
-/* always-on timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
-	.timer_capability	= OMAP_TIMER_ALWON,
-};
-
-/* pwm timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
-	.timer_capability	= OMAP_TIMER_HAS_PWM,
-};
-
-/* timer1 */
-static struct omap_hwmod omap2420_timer1_hwmod = {
-	.name		= "timer1",
-	.mpu_irqs	= omap2_timer1_mpu_irqs,
-	.main_clk	= "gpt1_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer2 */
-static struct omap_hwmod omap2420_timer2_hwmod = {
-	.name		= "timer2",
-	.mpu_irqs	= omap2_timer2_mpu_irqs,
-	.main_clk	= "gpt2_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT2_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer3 */
-static struct omap_hwmod omap2420_timer3_hwmod = {
-	.name		= "timer3",
-	.mpu_irqs	= omap2_timer3_mpu_irqs,
-	.main_clk	= "gpt3_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT3_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer4 */
-static struct omap_hwmod omap2420_timer4_hwmod = {
-	.name		= "timer4",
-	.mpu_irqs	= omap2_timer4_mpu_irqs,
-	.main_clk	= "gpt4_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT4_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer5 */
-static struct omap_hwmod omap2420_timer5_hwmod = {
-	.name		= "timer5",
-	.mpu_irqs	= omap2_timer5_mpu_irqs,
-	.main_clk	= "gpt5_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT5_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer6 */
-static struct omap_hwmod omap2420_timer6_hwmod = {
-	.name		= "timer6",
-	.mpu_irqs	= omap2_timer6_mpu_irqs,
-	.main_clk	= "gpt6_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT6_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer7 */
-static struct omap_hwmod omap2420_timer7_hwmod = {
-	.name		= "timer7",
-	.mpu_irqs	= omap2_timer7_mpu_irqs,
-	.main_clk	= "gpt7_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT7_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer8 */
-static struct omap_hwmod omap2420_timer8_hwmod = {
-	.name		= "timer8",
-	.mpu_irqs	= omap2_timer8_mpu_irqs,
-	.main_clk	= "gpt8_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT8_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer9 */
-static struct omap_hwmod omap2420_timer9_hwmod = {
-	.name		= "timer9",
-	.mpu_irqs	= omap2_timer9_mpu_irqs,
-	.main_clk	= "gpt9_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT9_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer10 */
-static struct omap_hwmod omap2420_timer10_hwmod = {
-	.name		= "timer10",
-	.mpu_irqs	= omap2_timer10_mpu_irqs,
-	.main_clk	= "gpt10_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT10_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer11 */
-static struct omap_hwmod omap2420_timer11_hwmod = {
-	.name		= "timer11",
-	.mpu_irqs	= omap2_timer11_mpu_irqs,
-	.main_clk	= "gpt11_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT11_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer12 */
-static struct omap_hwmod omap2420_timer12_hwmod = {
-	.name		= "timer12",
-	.mpu_irqs	= omap2xxx_timer12_mpu_irqs,
-	.main_clk	= "gpt12_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT12_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-static struct omap_hwmod omap2420_wd_timer2_hwmod = {
-	.name		= "wd_timer2",
-	.class		= &omap2xxx_wd_timer_hwmod_class,
-	.main_clk	= "mpu_wdt_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MPU_WDT_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_MPU_WDT_SHIFT,
-		},
-	},
-};
-
-/* UART1 */
-static struct omap_hwmod omap2420_uart1_hwmod = {
-	.name		= "uart1",
-	.mpu_irqs	= omap2_uart1_mpu_irqs,
-	.sdma_reqs	= omap2_uart1_sdma_reqs,
-	.main_clk	= "uart1_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_UART1_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
-		},
-	},
-	.class		= &omap2_uart_class,
-};
-
-/* UART2 */
-static struct omap_hwmod omap2420_uart2_hwmod = {
-	.name		= "uart2",
-	.mpu_irqs	= omap2_uart2_mpu_irqs,
-	.sdma_reqs	= omap2_uart2_sdma_reqs,
-	.main_clk	= "uart2_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_UART2_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
-		},
-	},
-	.class		= &omap2_uart_class,
-};
-
-/* UART3 */
-static struct omap_hwmod omap2420_uart3_hwmod = {
-	.name		= "uart3",
-	.mpu_irqs	= omap2_uart3_mpu_irqs,
-	.sdma_reqs	= omap2_uart3_sdma_reqs,
-	.main_clk	= "uart3_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 2,
-			.module_bit = OMAP24XX_EN_UART3_SHIFT,
-			.idlest_reg_id = 2,
-			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
-		},
-	},
-	.class		= &omap2_uart_class,
-};
-
-/* dss */
-
-static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	/*
-	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
-	 * driver does not use these clocks.
-	 */
-	{ .role = "tv_clk", .clk = "dss_54m_fck" },
-	{ .role = "sys_clk", .clk = "dss2_fck" },
-};
-
-static struct omap_hwmod omap2420_dss_core_hwmod = {
-	.name		= "dss_core",
-	.class		= &omap2_dss_hwmod_class,
-	.main_clk	= "dss1_fck", /* instead of dss_fck */
-	.sdma_reqs	= omap2xxx_dss_sdma_chs,
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.opt_clks	= dss_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
-	.flags		= HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-};
-
-static struct omap_hwmod omap2420_dss_dispc_hwmod = {
-	.name		= "dss_dispc",
-	.class		= &omap2_dispc_hwmod_class,
-	.mpu_irqs	= omap2_dispc_irqs,
-	.main_clk	= "dss1_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.flags		= HWMOD_NO_IDLEST,
-	.dev_attr	= &omap2_3_dss_dispc_dev_attr
-};
-
-static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
-	{ .role = "ick", .clk = "dss_ick" },
-};
-
-static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
-	.name		= "dss_rfbi",
-	.class		= &omap2_rfbi_hwmod_class,
-	.main_clk	= "dss1_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-		},
-	},
-	.opt_clks	= dss_rfbi_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-static struct omap_hwmod omap2420_dss_venc_hwmod = {
-	.name		= "dss_venc",
-	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss_54m_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-		},
-	},
-	.flags		= HWMOD_NO_IDLEST,
-};
-
 /* I2C common */
 static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.rev_offs	= 0x00,
@@ -517,88 +112,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG,
 };
 
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width = 32,
-	.dbck_flag = false,
-};
-
-/* gpio1 */
-static struct omap_hwmod omap2420_gpio1_hwmod = {
-	.name		= "gpio1",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio1_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
-/* gpio2 */
-static struct omap_hwmod omap2420_gpio2_hwmod = {
-	.name		= "gpio2",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio2_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
-/* gpio3 */
-static struct omap_hwmod omap2420_gpio3_hwmod = {
-	.name		= "gpio3",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio3_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
-/* gpio4 */
-static struct omap_hwmod omap2420_gpio4_hwmod = {
-	.name		= "gpio4",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio4_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
 /* dma attributes */
 static struct omap_dma_dev_attr dma_dev_attr = {
 	.dev_caps  = RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
@@ -638,52 +151,6 @@ static struct omap_hwmod omap2420_mailbox_hwmod = {
 	},
 };
 
-/* mcspi1 */
-static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
-	.num_chipselect = 4,
-};
-
-static struct omap_hwmod omap2420_mcspi1_hwmod = {
-	.name		= "mcspi1",
-	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
-	.main_clk	= "mcspi1_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCSPI1_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_MCSPI1_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_mcspi_class,
-	.dev_attr	= &omap_mcspi1_dev_attr,
-};
-
-/* mcspi2 */
-static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
-	.num_chipselect = 2,
-};
-
-static struct omap_hwmod omap2420_mcspi2_hwmod = {
-	.name		= "mcspi2",
-	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
-	.main_clk	= "mcspi2_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCSPI2_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_MCSPI2_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_mcspi_class,
-	.dev_attr	= &omap_mcspi2_dev_attr,
-};
-
 /*
  * 'mcbsp' class
  * multi channel buffered serial port controller
@@ -747,22 +214,22 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
-	.master	= &omap2420_l3_main_hwmod,
-	.slave	= &omap2420_l4_core_hwmod,
+	.master	= &omap2xxx_l3_main_hwmod,
+	.slave	= &omap2xxx_l4_core_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* MPU -> L3 interface */
 static struct omap_hwmod_ocp_if omap2420_mpu__l3_main = {
-	.master = &omap2420_mpu_hwmod,
-	.slave	= &omap2420_l3_main_hwmod,
+	.master = &omap2xxx_mpu_hwmod,
+	.slave	= &omap2xxx_l3_main_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
 /* DSS -> l3 */
 static struct omap_hwmod_ocp_if omap2420_dss__l3 = {
-	.master		= &omap2420_dss_core_hwmod,
-	.slave		= &omap2420_l3_main_hwmod,
+	.master		= &omap2xxx_dss_core_hwmod,
+	.slave		= &omap2xxx_l3_main_hwmod,
 	.fw = {
 		.omap2 = {
 			.l3_perm_bit  = OMAP2_L3_CORE_FW_CONNID_DSS,
@@ -774,8 +241,8 @@ static struct omap_hwmod_ocp_if omap2420_dss__l3 = {
 
 /* l4 core -> mcspi1 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi1 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_mcspi1_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_mcspi1_hwmod,
 	.clk		= "mcspi1_ick",
 	.addr		= omap2_mcspi1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -783,8 +250,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi1 = {
 
 /* l4 core -> mcspi2 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi2 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_mcspi2_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_mcspi2_hwmod,
 	.clk		= "mcspi2_ick",
 	.addr		= omap2_mcspi2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -792,15 +259,15 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi2 = {
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
-	.master	= &omap2420_l4_core_hwmod,
-	.slave	= &omap2420_l4_wkup_hwmod,
+	.master	= &omap2xxx_l4_core_hwmod,
+	.slave	= &omap2xxx_l4_wkup_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 CORE -> UART1 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_uart1_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart1_hwmod,
 	.clk		= "uart1_ick",
 	.addr		= omap2xxx_uart1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -808,8 +275,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
 
 /* L4 CORE -> UART2 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_uart2_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart2_hwmod,
 	.clk		= "uart2_ick",
 	.addr		= omap2xxx_uart2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -817,8 +284,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
 
 /* L4 PER -> UART3 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_uart3_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart3_hwmod,
 	.clk		= "uart3_ick",
 	.addr		= omap2xxx_uart3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -826,7 +293,7 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
 
 /* L4 CORE -> I2C1 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 = {
-	.master		= &omap2420_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_i2c1_hwmod,
 	.clk		= "i2c1_ick",
 	.addr		= omap2_i2c1_addr_space,
@@ -835,7 +302,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 = {
 
 /* L4 CORE -> I2C2 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 = {
-	.master		= &omap2420_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_i2c2_hwmod,
 	.clk		= "i2c2_ick",
 	.addr		= omap2_i2c2_addr_space,
@@ -844,7 +311,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 = {
 
 /* IVA <- L3 interface */
 static struct omap_hwmod_ocp_if omap2420_l3__iva = {
-	.master		= &omap2420_l3_main_hwmod,
+	.master		= &omap2xxx_l3_main_hwmod,
 	.slave		= &omap2420_iva_hwmod,
 	.clk		= "iva1_ifck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -861,8 +328,8 @@ static struct omap_hwmod_addr_space omap2420_timer1_addrs[] = {
 
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__timer1 = {
-	.master		= &omap2420_l4_wkup_hwmod,
-	.slave		= &omap2420_timer1_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_timer1_hwmod,
 	.clk		= "gpt1_ick",
 	.addr		= omap2420_timer1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -870,8 +337,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__timer1 = {
 
 /* l4_core -> timer2 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer2 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer2_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer2_hwmod,
 	.clk		= "gpt2_ick",
 	.addr		= omap2xxx_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -879,8 +346,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer2 = {
 
 /* l4_core -> timer3 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer3 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer3_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer3_hwmod,
 	.clk		= "gpt3_ick",
 	.addr		= omap2xxx_timer3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -888,8 +355,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer3 = {
 
 /* l4_core -> timer4 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer4 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer4_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer4_hwmod,
 	.clk		= "gpt4_ick",
 	.addr		= omap2xxx_timer4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -897,8 +364,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer4 = {
 
 /* l4_core -> timer5 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer5 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer5_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer5_hwmod,
 	.clk		= "gpt5_ick",
 	.addr		= omap2xxx_timer5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -906,8 +373,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer5 = {
 
 /* l4_core -> timer6 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer6 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer6_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer6_hwmod,
 	.clk		= "gpt6_ick",
 	.addr		= omap2xxx_timer6_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -915,8 +382,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer6 = {
 
 /* l4_core -> timer7 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer7 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer7_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer7_hwmod,
 	.clk		= "gpt7_ick",
 	.addr		= omap2xxx_timer7_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -924,8 +391,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer7 = {
 
 /* l4_core -> timer8 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer8 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer8_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer8_hwmod,
 	.clk		= "gpt8_ick",
 	.addr		= omap2xxx_timer8_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -933,8 +400,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer8 = {
 
 /* l4_core -> timer9 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer9 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer9_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer9_hwmod,
 	.clk		= "gpt9_ick",
 	.addr		= omap2xxx_timer9_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -942,8 +409,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer9 = {
 
 /* l4_core -> timer10 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer10 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer10_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer10_hwmod,
 	.clk		= "gpt10_ick",
 	.addr		= omap2_timer10_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -951,8 +418,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer10 = {
 
 /* l4_core -> timer11 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer11 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer11_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer11_hwmod,
 	.clk		= "gpt11_ick",
 	.addr		= omap2_timer11_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -960,8 +427,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__timer11 = {
 
 /* l4_core -> timer12 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer12 = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_timer12_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer12_hwmod,
 	.clk		= "gpt12_ick",
 	.addr		= omap2xxx_timer12_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -978,8 +445,8 @@ static struct omap_hwmod_addr_space omap2420_wd_timer2_addrs[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 = {
-	.master		= &omap2420_l4_wkup_hwmod,
-	.slave		= &omap2420_wd_timer2_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_wd_timer2_hwmod,
 	.clk		= "mpu_wdt_ick",
 	.addr		= omap2420_wd_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -987,8 +454,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 = {
 
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_dss_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_core_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_addrs,
 	.fw = {
@@ -1002,8 +469,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dss = {
 
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_dispc = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_dss_dispc_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_dispc_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_dispc_addrs,
 	.fw = {
@@ -1017,8 +484,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dss_dispc = {
 
 /* l4_core -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_rfbi = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_dss_rfbi_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_rfbi_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_rfbi_addrs,
 	.fw = {
@@ -1032,8 +499,8 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dss_rfbi = {
 
 /* l4_core -> dss_venc */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
-	.master		= &omap2420_l4_core_hwmod,
-	.slave		= &omap2420_dss_venc_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_venc_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.fw = {
@@ -1057,8 +524,8 @@ static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 = {
-	.master		= &omap2420_l4_wkup_hwmod,
-	.slave		= &omap2420_gpio1_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio1_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2420_gpio1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1075,8 +542,8 @@ static struct omap_hwmod_addr_space omap2420_gpio2_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 = {
-	.master		= &omap2420_l4_wkup_hwmod,
-	.slave		= &omap2420_gpio2_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio2_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2420_gpio2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1093,8 +560,8 @@ static struct omap_hwmod_addr_space omap2420_gpio3_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 = {
-	.master		= &omap2420_l4_wkup_hwmod,
-	.slave		= &omap2420_gpio3_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio3_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2420_gpio3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1111,8 +578,8 @@ static struct omap_hwmod_addr_space omap2420_gpio4_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
-	.master		= &omap2420_l4_wkup_hwmod,
-	.slave		= &omap2420_gpio4_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio4_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2420_gpio4_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1121,14 +588,14 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
 /* dma_system -> L3 */
 static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
 	.master		= &omap2420_dma_system_hwmod,
-	.slave		= &omap2420_l3_main_hwmod,
+	.slave		= &omap2xxx_l3_main_hwmod,
 	.clk		= "core_l3_ck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_core -> dma_system */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
-	.master		= &omap2420_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_dma_system_hwmod,
 	.clk		= "sdma_ick",
 	.addr		= omap2_dma_system_addrs,
@@ -1137,7 +604,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
 
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
-	.master		= &omap2420_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_mailbox_hwmod,
 	.addr		= omap2_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1145,7 +612,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
 
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 = {
-	.master		= &omap2420_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_mcbsp1_hwmod,
 	.clk		= "mcbsp1_ick",
 	.addr		= omap2_mcbsp1_addrs,
@@ -1154,7 +621,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 = {
 
 /* l4_core -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
-	.master		= &omap2420_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_mcbsp2_hwmod,
 	.clk		= "mcbsp2_ick",
 	.addr		= omap2xxx_mcbsp2_addrs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index da8fef0..8b04938 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -44,416 +44,12 @@
  * IP blocks
  */
 
-/* L3 */
-static struct omap_hwmod omap2430_l3_main_hwmod = {
-	.name		= "l3_main",
-	.class		= &l3_hwmod_class,
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-/* L4 CORE */
-static struct omap_hwmod omap2430_l4_core_hwmod = {
-	.name		= "l4_core",
-	.class		= &l4_hwmod_class,
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-/* L4 WKUP */
-static struct omap_hwmod omap2430_l4_wkup_hwmod = {
-	.name		= "l4_wkup",
-	.class		= &l4_hwmod_class,
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-/* MPU */
-static struct omap_hwmod omap2430_mpu_hwmod = {
-	.name		= "mpu",
-	.class		= &mpu_hwmod_class,
-	.main_clk	= "mpu_ck",
-};
-
 /* IVA2 (IVA2) */
 static struct omap_hwmod omap2430_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
 };
 
-/* always-on timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
-	.timer_capability	= OMAP_TIMER_ALWON,
-};
-
-/* pwm timers dev attribute */
-static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
-	.timer_capability	= OMAP_TIMER_HAS_PWM,
-};
-
-/* timer1 */
-static struct omap_hwmod omap2430_timer1_hwmod = {
-	.name		= "timer1",
-	.mpu_irqs	= omap2_timer1_mpu_irqs,
-	.main_clk	= "gpt1_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer2 */
-static struct omap_hwmod omap2430_timer2_hwmod = {
-	.name		= "timer2",
-	.mpu_irqs	= omap2_timer2_mpu_irqs,
-	.main_clk	= "gpt2_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT2_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer3 */
-static struct omap_hwmod omap2430_timer3_hwmod = {
-	.name		= "timer3",
-	.mpu_irqs	= omap2_timer3_mpu_irqs,
-	.main_clk	= "gpt3_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT3_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer4 */
-static struct omap_hwmod omap2430_timer4_hwmod = {
-	.name		= "timer4",
-	.mpu_irqs	= omap2_timer4_mpu_irqs,
-	.main_clk	= "gpt4_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT4_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer5 */
-static struct omap_hwmod omap2430_timer5_hwmod = {
-	.name		= "timer5",
-	.mpu_irqs	= omap2_timer5_mpu_irqs,
-	.main_clk	= "gpt5_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT5_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer6 */
-static struct omap_hwmod omap2430_timer6_hwmod = {
-	.name		= "timer6",
-	.mpu_irqs	= omap2_timer6_mpu_irqs,
-	.main_clk	= "gpt6_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT6_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer7 */
-static struct omap_hwmod omap2430_timer7_hwmod = {
-	.name		= "timer7",
-	.mpu_irqs	= omap2_timer7_mpu_irqs,
-	.main_clk	= "gpt7_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT7_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer8 */
-static struct omap_hwmod omap2430_timer8_hwmod = {
-	.name		= "timer8",
-	.mpu_irqs	= omap2_timer8_mpu_irqs,
-	.main_clk	= "gpt8_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT8_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer9 */
-static struct omap_hwmod omap2430_timer9_hwmod = {
-	.name		= "timer9",
-	.mpu_irqs	= omap2_timer9_mpu_irqs,
-	.main_clk	= "gpt9_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT9_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer10 */
-static struct omap_hwmod omap2430_timer10_hwmod = {
-	.name		= "timer10",
-	.mpu_irqs	= omap2_timer10_mpu_irqs,
-	.main_clk	= "gpt10_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT10_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer11 */
-static struct omap_hwmod omap2430_timer11_hwmod = {
-	.name		= "timer11",
-	.mpu_irqs	= omap2_timer11_mpu_irqs,
-	.main_clk	= "gpt11_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT11_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-/* timer12 */
-static struct omap_hwmod omap2430_timer12_hwmod = {
-	.name		= "timer12",
-	.mpu_irqs	= omap2xxx_timer12_mpu_irqs,
-	.main_clk	= "gpt12_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT12_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
-		},
-	},
-	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap2xxx_timer_hwmod_class,
-};
-
-static struct omap_hwmod omap2430_wd_timer2_hwmod = {
-	.name		= "wd_timer2",
-	.class		= &omap2xxx_wd_timer_hwmod_class,
-	.main_clk	= "mpu_wdt_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MPU_WDT_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_MPU_WDT_SHIFT,
-		},
-	},
-};
-
-/* UART1 */
-static struct omap_hwmod omap2430_uart1_hwmod = {
-	.name		= "uart1",
-	.mpu_irqs	= omap2_uart1_mpu_irqs,
-	.sdma_reqs	= omap2_uart1_sdma_reqs,
-	.main_clk	= "uart1_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_UART1_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
-		},
-	},
-	.class		= &omap2_uart_class,
-};
-
-/* UART2 */
-static struct omap_hwmod omap2430_uart2_hwmod = {
-	.name		= "uart2",
-	.mpu_irqs	= omap2_uart2_mpu_irqs,
-	.sdma_reqs	= omap2_uart2_sdma_reqs,
-	.main_clk	= "uart2_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_UART2_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
-		},
-	},
-	.class		= &omap2_uart_class,
-};
-
-/* UART3 */
-static struct omap_hwmod omap2430_uart3_hwmod = {
-	.name		= "uart3",
-	.mpu_irqs	= omap2_uart3_mpu_irqs,
-	.sdma_reqs	= omap2_uart3_sdma_reqs,
-	.main_clk	= "uart3_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 2,
-			.module_bit = OMAP24XX_EN_UART3_SHIFT,
-			.idlest_reg_id = 2,
-			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
-		},
-	},
-	.class		= &omap2_uart_class,
-};
-
-/* dss */
-static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	/*
-	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
-	 * driver does not use these clocks.
-	 */
-	{ .role = "tv_clk", .clk = "dss_54m_fck" },
-	{ .role = "sys_clk", .clk = "dss2_fck" },
-};
-
-static struct omap_hwmod omap2430_dss_core_hwmod = {
-	.name		= "dss_core",
-	.class		= &omap2_dss_hwmod_class,
-	.main_clk	= "dss1_fck", /* instead of dss_fck */
-	.sdma_reqs	= omap2xxx_dss_sdma_chs,
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.opt_clks	= dss_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
-	.flags		= HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-};
-
-static struct omap_hwmod omap2430_dss_dispc_hwmod = {
-	.name		= "dss_dispc",
-	.class		= &omap2_dispc_hwmod_class,
-	.mpu_irqs	= omap2_dispc_irqs,
-	.main_clk	= "dss1_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
-		},
-	},
-	.flags		= HWMOD_NO_IDLEST,
-	.dev_attr	= &omap2_3_dss_dispc_dev_attr
-};
-
-static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
-	{ .role = "ick", .clk = "dss_ick" },
-};
-
-static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
-	.name		= "dss_rfbi",
-	.class		= &omap2_rfbi_hwmod_class,
-	.main_clk	= "dss1_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-		},
-	},
-	.opt_clks	= dss_rfbi_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
-	.flags		= HWMOD_NO_IDLEST,
-};
-
-static struct omap_hwmod omap2430_dss_venc_hwmod = {
-	.name		= "dss_venc",
-	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss_54m_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
-			.module_offs = CORE_MOD,
-		},
-	},
-	.flags		= HWMOD_NO_IDLEST,
-};
-
 /* I2C common */
 static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.rev_offs	= 0x00,
@@ -526,88 +122,6 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.dev_attr	= &i2c_dev_attr,
 };
 
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width = 32,
-	.dbck_flag = false,
-};
-
-/* gpio1 */
-static struct omap_hwmod omap2430_gpio1_hwmod = {
-	.name		= "gpio1",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio1_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_EN_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
-/* gpio2 */
-static struct omap_hwmod omap2430_gpio2_hwmod = {
-	.name		= "gpio2",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio2_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
-/* gpio3 */
-static struct omap_hwmod omap2430_gpio3_hwmod = {
-	.name		= "gpio3",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio3_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
-/* gpio4 */
-static struct omap_hwmod omap2430_gpio4_hwmod = {
-	.name		= "gpio4",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio4_irqs,
-	.main_clk	= "gpios_fck",
-	.prcm		= {
-		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
-			.module_offs = WKUP_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
-};
-
 /* gpio5 */
 static struct omap_hwmod_irq_info omap243x_gpio5_irqs[] = {
 	{ .irq = 33 }, /* INT_24XX_GPIO_BANK5 */
@@ -629,7 +143,7 @@ static struct omap_hwmod omap2430_gpio5_hwmod = {
 		},
 	},
 	.class		= &omap2xxx_gpio_hwmod_class,
-	.dev_attr	= &gpio_dev_attr,
+	.dev_attr	= &omap2xxx_gpio_dev_attr,
 };
 
 /* dma attributes */
@@ -670,52 +184,6 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 	},
 };
 
-/* mcspi1 */
-static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
-	.num_chipselect = 4,
-};
-
-static struct omap_hwmod omap2430_mcspi1_hwmod = {
-	.name		= "mcspi1",
-	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
-	.main_clk	= "mcspi1_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCSPI1_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_MCSPI1_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_mcspi_class,
-	.dev_attr	= &omap_mcspi1_dev_attr,
-};
-
-/* mcspi2 */
-static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
-	.num_chipselect = 2,
-};
-
-static struct omap_hwmod omap2430_mcspi2_hwmod = {
-	.name		= "mcspi2",
-	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
-	.main_clk	= "mcspi2_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCSPI2_SHIFT,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP24XX_ST_MCSPI2_SHIFT,
-		},
-	},
-	.class		= &omap2xxx_mcspi_class,
-	.dev_attr	= &omap_mcspi2_dev_attr,
-};
-
 /* mcspi3 */
 static struct omap_hwmod_irq_info omap2430_mcspi3_mpu_irqs[] = {
 	{ .irq = 91 },
@@ -1057,22 +525,22 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
-	.master	= &omap2430_l3_main_hwmod,
-	.slave	= &omap2430_l4_core_hwmod,
+	.master	= &omap2xxx_l3_main_hwmod,
+	.slave	= &omap2xxx_l4_core_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* MPU -> L3 interface */
 static struct omap_hwmod_ocp_if omap2430_mpu__l3_main = {
-	.master = &omap2430_mpu_hwmod,
-	.slave	= &omap2430_l3_main_hwmod,
+	.master = &omap2xxx_mpu_hwmod,
+	.slave	= &omap2xxx_l3_main_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
 /* DSS -> l3 */
 static struct omap_hwmod_ocp_if omap2430_dss__l3 = {
-	.master		= &omap2430_dss_core_hwmod,
-	.slave		= &omap2430_l3_main_hwmod,
+	.master		= &omap2xxx_dss_core_hwmod,
+	.slave		= &omap2xxx_l3_main_hwmod,
 	.fw = {
 		.omap2 = {
 			.l3_perm_bit  = OMAP2_L3_CORE_FW_CONNID_DSS,
@@ -1085,14 +553,14 @@ static struct omap_hwmod_ocp_if omap2430_dss__l3 = {
 /* l3_core -> usbhsotg  interface */
 static struct omap_hwmod_ocp_if omap2430_usbhsotg__l3 = {
 	.master		= &omap2430_usbhsotg_hwmod,
-	.slave		= &omap2430_l3_main_hwmod,
+	.slave		= &omap2xxx_l3_main_hwmod,
 	.clk		= "core_l3_ck",
 	.user		= OCP_USER_MPU,
 };
 
 /* L4 CORE -> I2C1 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_i2c1_hwmod,
 	.clk		= "i2c1_ick",
 	.addr		= omap2_i2c1_addr_space,
@@ -1101,7 +569,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 = {
 
 /* L4 CORE -> I2C2 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_i2c2_hwmod,
 	.clk		= "i2c2_ick",
 	.addr		= omap2_i2c2_addr_space,
@@ -1110,15 +578,15 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 = {
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
-	.master	= &omap2430_l4_core_hwmod,
-	.slave	= &omap2430_l4_wkup_hwmod,
+	.master	= &omap2xxx_l4_core_hwmod,
+	.slave	= &omap2xxx_l4_wkup_hwmod,
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 CORE -> UART1 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_uart1_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart1_hwmod,
 	.clk		= "uart1_ick",
 	.addr		= omap2xxx_uart1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1126,8 +594,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
 
 /* L4 CORE -> UART2 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_uart2_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart2_hwmod,
 	.clk		= "uart2_ick",
 	.addr		= omap2xxx_uart2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1135,8 +603,8 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
 
 /* L4 PER -> UART3 interface */
 static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_uart3_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart3_hwmod,
 	.clk		= "uart3_ick",
 	.addr		= omap2xxx_uart3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1153,7 +621,7 @@ static struct omap_hwmod_addr_space omap2430_usbhsotg_addrs[] = {
 
 /*  l4_core ->usbhsotg  interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__usbhsotg = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_usbhsotg_hwmod,
 	.clk		= "usb_l4_ick",
 	.addr		= omap2430_usbhsotg_addrs,
@@ -1162,7 +630,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__usbhsotg = {
 
 /* L4 CORE -> MMC1 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mmc1_hwmod,
 	.clk		= "mmchs1_ick",
 	.addr		= omap2430_mmc1_addr_space,
@@ -1171,7 +639,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
 
 /* L4 CORE -> MMC2 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mmc2_hwmod,
 	.clk		= "mmchs2_ick",
 	.addr		= omap2430_mmc2_addr_space,
@@ -1180,8 +648,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
 
 /* l4 core -> mcspi1 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi1 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_mcspi1_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_mcspi1_hwmod,
 	.clk		= "mcspi1_ick",
 	.addr		= omap2_mcspi1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1189,8 +657,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi1 = {
 
 /* l4 core -> mcspi2 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi2 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_mcspi2_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_mcspi2_hwmod,
 	.clk		= "mcspi2_ick",
 	.addr		= omap2_mcspi2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1198,7 +666,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi2 = {
 
 /* l4 core -> mcspi3 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcspi3_hwmod,
 	.clk		= "mcspi3_ick",
 	.addr		= omap2430_mcspi3_addr_space,
@@ -1207,7 +675,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 = {
 
 /* IVA2 <- L3 interface */
 static struct omap_hwmod_ocp_if omap2430_l3__iva = {
-	.master		= &omap2430_l3_main_hwmod,
+	.master		= &omap2xxx_l3_main_hwmod,
 	.slave		= &omap2430_iva_hwmod,
 	.clk		= "dsp_fck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1224,8 +692,8 @@ static struct omap_hwmod_addr_space omap2430_timer1_addrs[] = {
 
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__timer1 = {
-	.master		= &omap2430_l4_wkup_hwmod,
-	.slave		= &omap2430_timer1_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_timer1_hwmod,
 	.clk		= "gpt1_ick",
 	.addr		= omap2430_timer1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1233,8 +701,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__timer1 = {
 
 /* l4_core -> timer2 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer2 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer2_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer2_hwmod,
 	.clk		= "gpt2_ick",
 	.addr		= omap2xxx_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1242,8 +710,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer2 = {
 
 /* l4_core -> timer3 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer3 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer3_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer3_hwmod,
 	.clk		= "gpt3_ick",
 	.addr		= omap2xxx_timer3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1251,8 +719,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer3 = {
 
 /* l4_core -> timer4 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer4 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer4_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer4_hwmod,
 	.clk		= "gpt4_ick",
 	.addr		= omap2xxx_timer4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1260,8 +728,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer4 = {
 
 /* l4_core -> timer5 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer5 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer5_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer5_hwmod,
 	.clk		= "gpt5_ick",
 	.addr		= omap2xxx_timer5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1269,8 +737,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer5 = {
 
 /* l4_core -> timer6 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer6 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer6_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer6_hwmod,
 	.clk		= "gpt6_ick",
 	.addr		= omap2xxx_timer6_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1278,8 +746,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer6 = {
 
 /* l4_core -> timer7 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer7 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer7_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer7_hwmod,
 	.clk		= "gpt7_ick",
 	.addr		= omap2xxx_timer7_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1287,8 +755,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer7 = {
 
 /* l4_core -> timer8 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer8 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer8_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer8_hwmod,
 	.clk		= "gpt8_ick",
 	.addr		= omap2xxx_timer8_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1296,8 +764,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer8 = {
 
 /* l4_core -> timer9 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer9 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer9_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer9_hwmod,
 	.clk		= "gpt9_ick",
 	.addr		= omap2xxx_timer9_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1305,8 +773,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer9 = {
 
 /* l4_core -> timer10 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer10 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer10_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer10_hwmod,
 	.clk		= "gpt10_ick",
 	.addr		= omap2_timer10_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1314,8 +782,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer10 = {
 
 /* l4_core -> timer11 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer11 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer11_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer11_hwmod,
 	.clk		= "gpt11_ick",
 	.addr		= omap2_timer11_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1323,8 +791,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__timer11 = {
 
 /* l4_core -> timer12 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer12 = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_timer12_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer12_hwmod,
 	.clk		= "gpt12_ick",
 	.addr		= omap2xxx_timer12_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1341,8 +809,8 @@ static struct omap_hwmod_addr_space omap2430_wd_timer2_addrs[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 = {
-	.master		= &omap2430_l4_wkup_hwmod,
-	.slave		= &omap2430_wd_timer2_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_wd_timer2_hwmod,
 	.clk		= "mpu_wdt_ick",
 	.addr		= omap2430_wd_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1350,8 +818,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 = {
 
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_dss_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_core_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1359,8 +827,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dss = {
 
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_dispc = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_dss_dispc_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_dispc_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_dispc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1368,8 +836,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dss_dispc = {
 
 /* l4_core -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_rfbi = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_dss_rfbi_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_rfbi_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_rfbi_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1377,8 +845,8 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dss_rfbi = {
 
 /* l4_core -> dss_venc */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
-	.master		= &omap2430_l4_core_hwmod,
-	.slave		= &omap2430_dss_venc_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_venc_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.flags		= OCPIF_SWSUP_IDLE,
@@ -1396,8 +864,8 @@ static struct omap_hwmod_addr_space omap2430_gpio1_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio1 = {
-	.master		= &omap2430_l4_wkup_hwmod,
-	.slave		= &omap2430_gpio1_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio1_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2430_gpio1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1414,8 +882,8 @@ static struct omap_hwmod_addr_space omap2430_gpio2_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio2 = {
-	.master		= &omap2430_l4_wkup_hwmod,
-	.slave		= &omap2430_gpio2_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio2_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2430_gpio2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1432,8 +900,8 @@ static struct omap_hwmod_addr_space omap2430_gpio3_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio3 = {
-	.master		= &omap2430_l4_wkup_hwmod,
-	.slave		= &omap2430_gpio3_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio3_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2430_gpio3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1450,8 +918,8 @@ static struct omap_hwmod_addr_space omap2430_gpio4_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio4 = {
-	.master		= &omap2430_l4_wkup_hwmod,
-	.slave		= &omap2430_gpio4_hwmod,
+	.master		= &omap2xxx_l4_wkup_hwmod,
+	.slave		= &omap2xxx_gpio4_hwmod,
 	.clk		= "gpios_ick",
 	.addr		= omap2430_gpio4_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1468,7 +936,7 @@ static struct omap_hwmod_addr_space omap2430_gpio5_addr_space[] = {
 };
 
 static struct omap_hwmod_ocp_if omap2430_l4_core__gpio5 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_gpio5_hwmod,
 	.clk		= "gpio5_ick",
 	.addr		= omap2430_gpio5_addr_space,
@@ -1478,14 +946,14 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__gpio5 = {
 /* dma_system -> L3 */
 static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
 	.master		= &omap2430_dma_system_hwmod,
-	.slave		= &omap2430_l3_main_hwmod,
+	.slave		= &omap2xxx_l3_main_hwmod,
 	.clk		= "core_l3_ck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_core -> dma_system */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_dma_system_hwmod,
 	.clk		= "sdma_ick",
 	.addr		= omap2_dma_system_addrs,
@@ -1494,7 +962,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
 
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mailbox_hwmod,
 	.addr		= omap2_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1502,7 +970,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
 
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp1 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp1_hwmod,
 	.clk		= "mcbsp1_ick",
 	.addr		= omap2_mcbsp1_addrs,
@@ -1511,7 +979,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp1 = {
 
 /* l4_core -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp2 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp2_hwmod,
 	.clk		= "mcbsp2_ick",
 	.addr		= omap2xxx_mcbsp2_addrs,
@@ -1530,7 +998,7 @@ static struct omap_hwmod_addr_space omap2430_mcbsp3_addrs[] = {
 
 /* l4_core -> mcbsp3 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp3 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp3_hwmod,
 	.clk		= "mcbsp3_ick",
 	.addr		= omap2430_mcbsp3_addrs,
@@ -1549,7 +1017,7 @@ static struct omap_hwmod_addr_space omap2430_mcbsp4_addrs[] = {
 
 /* l4_core -> mcbsp4 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp4 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp4_hwmod,
 	.clk		= "mcbsp4_ick",
 	.addr		= omap2430_mcbsp4_addrs,
@@ -1568,7 +1036,7 @@ static struct omap_hwmod_addr_space omap2430_mcbsp5_addrs[] = {
 
 /* l4_core -> mcbsp5 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 = {
-	.master		= &omap2430_l4_core_hwmod,
+	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp5_hwmod,
 	.clk		= "mcbsp5_ick",
 	.addr		= omap2430_mcbsp5_addrs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 2a67297..45aaa07 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -10,6 +10,7 @@
  */
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
+#include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/mcspi.h>
@@ -17,6 +18,8 @@
 #include <mach/irqs.h>
 
 #include "omap_hwmod_common_data.h"
+#include "cm-regbits-24xx.h"
+#include "prm-regbits-24xx.h"
 #include "wd_timer.h"
 
 struct omap_hwmod_irq_info omap2xxx_timer12_mpu_irqs[] = {
@@ -170,3 +173,562 @@ struct omap_hwmod_class omap2xxx_mcspi_class = {
 	.sysc	= &omap2xxx_mcspi_sysc,
 	.rev	= OMAP2_MCSPI_REV,
 };
+
+/*
+ * IP blocks
+ */
+
+/* L3 */
+struct omap_hwmod omap2xxx_l3_main_hwmod = {
+	.name		= "l3_main",
+	.class		= &l3_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* L4 CORE */
+struct omap_hwmod omap2xxx_l4_core_hwmod = {
+	.name		= "l4_core",
+	.class		= &l4_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* L4 WKUP */
+struct omap_hwmod omap2xxx_l4_wkup_hwmod = {
+	.name		= "l4_wkup",
+	.class		= &l4_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* MPU */
+struct omap_hwmod omap2xxx_mpu_hwmod = {
+	.name		= "mpu",
+	.class		= &mpu_hwmod_class,
+	.main_clk	= "mpu_ck",
+};
+
+/* IVA2 */
+struct omap_hwmod omap2xxx_iva_hwmod = {
+	.name		= "iva",
+	.class		= &iva_hwmod_class,
+};
+
+/* always-on timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
+	.timer_capability       = OMAP_TIMER_ALWON,
+};
+
+/* pwm timers dev attribute */
+static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
+	.timer_capability       = OMAP_TIMER_HAS_PWM,
+};
+
+/* timer1 */
+
+struct omap_hwmod omap2xxx_timer1_hwmod = {
+	.name		= "timer1",
+	.mpu_irqs	= omap2_timer1_mpu_irqs,
+	.main_clk	= "gpt1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer2 */
+
+struct omap_hwmod omap2xxx_timer2_hwmod = {
+	.name		= "timer2",
+	.mpu_irqs	= omap2_timer2_mpu_irqs,
+	.main_clk	= "gpt2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT2_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer3 */
+
+struct omap_hwmod omap2xxx_timer3_hwmod = {
+	.name		= "timer3",
+	.mpu_irqs	= omap2_timer3_mpu_irqs,
+	.main_clk	= "gpt3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT3_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer4 */
+
+struct omap_hwmod omap2xxx_timer4_hwmod = {
+	.name		= "timer4",
+	.mpu_irqs	= omap2_timer4_mpu_irqs,
+	.main_clk	= "gpt4_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT4_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer5 */
+
+struct omap_hwmod omap2xxx_timer5_hwmod = {
+	.name		= "timer5",
+	.mpu_irqs	= omap2_timer5_mpu_irqs,
+	.main_clk	= "gpt5_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT5_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer6 */
+
+struct omap_hwmod omap2xxx_timer6_hwmod = {
+	.name		= "timer6",
+	.mpu_irqs	= omap2_timer6_mpu_irqs,
+	.main_clk	= "gpt6_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT6_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer7 */
+
+struct omap_hwmod omap2xxx_timer7_hwmod = {
+	.name		= "timer7",
+	.mpu_irqs	= omap2_timer7_mpu_irqs,
+	.main_clk	= "gpt7_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT7_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer8 */
+
+struct omap_hwmod omap2xxx_timer8_hwmod = {
+	.name		= "timer8",
+	.mpu_irqs	= omap2_timer8_mpu_irqs,
+	.main_clk	= "gpt8_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT8_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_alwon_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer9 */
+
+struct omap_hwmod omap2xxx_timer9_hwmod = {
+	.name		= "timer9",
+	.mpu_irqs	= omap2_timer9_mpu_irqs,
+	.main_clk	= "gpt9_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT9_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_pwm_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer10 */
+
+struct omap_hwmod omap2xxx_timer10_hwmod = {
+	.name		= "timer10",
+	.mpu_irqs	= omap2_timer10_mpu_irqs,
+	.main_clk	= "gpt10_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT10_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_pwm_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer11 */
+
+struct omap_hwmod omap2xxx_timer11_hwmod = {
+	.name		= "timer11",
+	.mpu_irqs	= omap2_timer11_mpu_irqs,
+	.main_clk	= "gpt11_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT11_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_pwm_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* timer12 */
+
+struct omap_hwmod omap2xxx_timer12_hwmod = {
+	.name		= "timer12",
+	.mpu_irqs	= omap2xxx_timer12_mpu_irqs,
+	.main_clk	= "gpt12_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT12_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
+		},
+	},
+	.dev_attr	= &capability_pwm_dev_attr,
+	.class		= &omap2xxx_timer_hwmod_class,
+};
+
+/* wd_timer2 */
+struct omap_hwmod omap2xxx_wd_timer2_hwmod = {
+	.name		= "wd_timer2",
+	.class		= &omap2xxx_wd_timer_hwmod_class,
+	.main_clk	= "mpu_wdt_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MPU_WDT_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MPU_WDT_SHIFT,
+		},
+	},
+};
+
+/* UART1 */
+
+struct omap_hwmod omap2xxx_uart1_hwmod = {
+	.name		= "uart1",
+	.mpu_irqs	= omap2_uart1_mpu_irqs,
+	.sdma_reqs	= omap2_uart1_sdma_reqs,
+	.main_clk	= "uart1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
+		},
+	},
+	.class		= &omap2_uart_class,
+};
+
+/* UART2 */
+
+struct omap_hwmod omap2xxx_uart2_hwmod = {
+	.name		= "uart2",
+	.mpu_irqs	= omap2_uart2_mpu_irqs,
+	.sdma_reqs	= omap2_uart2_sdma_reqs,
+	.main_clk	= "uart2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
+		},
+	},
+	.class		= &omap2_uart_class,
+};
+
+/* UART3 */
+
+struct omap_hwmod omap2xxx_uart3_hwmod = {
+	.name		= "uart3",
+	.mpu_irqs	= omap2_uart3_mpu_irqs,
+	.sdma_reqs	= omap2_uart3_sdma_reqs,
+	.main_clk	= "uart3_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 2,
+			.module_bit = OMAP24XX_EN_UART3_SHIFT,
+			.idlest_reg_id = 2,
+			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
+		},
+	},
+	.class		= &omap2_uart_class,
+};
+
+/* dss */
+
+static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
+	{ .role = "tv_clk", .clk = "dss_54m_fck" },
+	{ .role = "sys_clk", .clk = "dss2_fck" },
+};
+
+struct omap_hwmod omap2xxx_dss_core_hwmod = {
+	.name		= "dss_core",
+	.class		= &omap2_dss_hwmod_class,
+	.main_clk	= "dss1_fck", /* instead of dss_fck */
+	.sdma_reqs	= omap2xxx_dss_sdma_chs,
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.opt_clks	= dss_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
+	.flags		= HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+};
+
+struct omap_hwmod omap2xxx_dss_dispc_hwmod = {
+	.name		= "dss_dispc",
+	.class		= &omap2_dispc_hwmod_class,
+	.mpu_irqs	= omap2_dispc_irqs,
+	.main_clk	= "dss1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
+		},
+	},
+	.flags		= HWMOD_NO_IDLEST,
+	.dev_attr	= &omap2_3_dss_dispc_dev_attr
+};
+
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
+struct omap_hwmod omap2xxx_dss_rfbi_hwmod = {
+	.name		= "dss_rfbi",
+	.class		= &omap2_rfbi_hwmod_class,
+	.main_clk	= "dss1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+		},
+	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+struct omap_hwmod omap2xxx_dss_venc_hwmod = {
+	.name		= "dss_venc",
+	.class		= &omap2_venc_hwmod_class,
+	.main_clk	= "dss_54m_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
+			.module_offs = CORE_MOD,
+		},
+	},
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* gpio dev_attr */
+struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr = {
+	.bank_width = 32,
+	.dbck_flag = false,
+};
+
+/* gpio1 */
+struct omap_hwmod omap2xxx_gpio1_hwmod = {
+	.name		= "gpio1",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	= omap2_gpio1_irqs,
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		= &omap2xxx_gpio_hwmod_class,
+	.dev_attr	= &omap2xxx_gpio_dev_attr,
+};
+
+/* gpio2 */
+struct omap_hwmod omap2xxx_gpio2_hwmod = {
+	.name		= "gpio2",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	= omap2_gpio2_irqs,
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		= &omap2xxx_gpio_hwmod_class,
+	.dev_attr	= &omap2xxx_gpio_dev_attr,
+};
+
+/* gpio3 */
+struct omap_hwmod omap2xxx_gpio3_hwmod = {
+	.name		= "gpio3",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	= omap2_gpio3_irqs,
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		= &omap2xxx_gpio_hwmod_class,
+	.dev_attr	= &omap2xxx_gpio_dev_attr,
+};
+
+/* gpio4 */
+struct omap_hwmod omap2xxx_gpio4_hwmod = {
+	.name		= "gpio4",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.mpu_irqs	= omap2_gpio4_irqs,
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
+		},
+	},
+	.class		= &omap2xxx_gpio_hwmod_class,
+	.dev_attr	= &omap2xxx_gpio_dev_attr,
+};
+
+/* mcspi1 */
+static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
+	.num_chipselect = 4,
+};
+
+struct omap_hwmod omap2xxx_mcspi1_hwmod = {
+	.name		= "mcspi1",
+	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
+	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
+	.main_clk	= "mcspi1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MCSPI1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MCSPI1_SHIFT,
+		},
+	},
+	.class		= &omap2xxx_mcspi_class,
+	.dev_attr	= &omap_mcspi1_dev_attr,
+};
+
+/* mcspi2 */
+static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
+	.num_chipselect = 2,
+};
+
+struct omap_hwmod omap2xxx_mcspi2_hwmod = {
+	.name		= "mcspi2",
+	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
+	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
+	.main_clk	= "mcspi2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MCSPI2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MCSPI2_SHIFT,
+		},
+	},
+	.class		= &omap2xxx_mcspi_class,
+	.dev_attr	= &omap_mcspi2_dev_attr,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index ad5d8f0..65757f3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -54,6 +54,38 @@ extern struct omap_hwmod_addr_space omap2_mcbsp1_addrs[];
 /* Common IP block data across OMAP2xxx */
 extern struct omap_hwmod_irq_info omap2xxx_timer12_mpu_irqs[];
 extern struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[];
+extern struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr;
+extern struct omap_hwmod omap2xxx_l3_main_hwmod;
+extern struct omap_hwmod omap2xxx_l4_core_hwmod;
+extern struct omap_hwmod omap2xxx_l4_wkup_hwmod;
+extern struct omap_hwmod omap2xxx_mpu_hwmod;
+extern struct omap_hwmod omap2xxx_iva_hwmod;
+extern struct omap_hwmod omap2xxx_timer1_hwmod;
+extern struct omap_hwmod omap2xxx_timer2_hwmod;
+extern struct omap_hwmod omap2xxx_timer3_hwmod;
+extern struct omap_hwmod omap2xxx_timer4_hwmod;
+extern struct omap_hwmod omap2xxx_timer5_hwmod;
+extern struct omap_hwmod omap2xxx_timer6_hwmod;
+extern struct omap_hwmod omap2xxx_timer7_hwmod;
+extern struct omap_hwmod omap2xxx_timer8_hwmod;
+extern struct omap_hwmod omap2xxx_timer9_hwmod;
+extern struct omap_hwmod omap2xxx_timer10_hwmod;
+extern struct omap_hwmod omap2xxx_timer11_hwmod;
+extern struct omap_hwmod omap2xxx_timer12_hwmod;
+extern struct omap_hwmod omap2xxx_wd_timer2_hwmod;
+extern struct omap_hwmod omap2xxx_uart1_hwmod;
+extern struct omap_hwmod omap2xxx_uart2_hwmod;
+extern struct omap_hwmod omap2xxx_uart3_hwmod;
+extern struct omap_hwmod omap2xxx_dss_core_hwmod;
+extern struct omap_hwmod omap2xxx_dss_dispc_hwmod;
+extern struct omap_hwmod omap2xxx_dss_rfbi_hwmod;
+extern struct omap_hwmod omap2xxx_dss_venc_hwmod;
+extern struct omap_hwmod omap2xxx_gpio1_hwmod;
+extern struct omap_hwmod omap2xxx_gpio2_hwmod;
+extern struct omap_hwmod omap2xxx_gpio3_hwmod;
+extern struct omap_hwmod omap2xxx_gpio4_hwmod;
+extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
+extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
 
 /* Common IP block data */
 extern struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[];
