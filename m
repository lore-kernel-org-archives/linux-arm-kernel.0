From: ben-linux@fluff.org (Ben Dooks)
Date: Tue,  8 Dec 2009 02:07:20 +0000
Subject: [[clock v2]] ARM: S3C64XX: Compress s3c6400-clock.c code
In-Reply-To: <1260238045-12694-1-git-send-email-ben-linux@fluff.org>
References: <1260238045-12694-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1260238045-12694-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The individually named clocks are all static to the code
and thus can be compressed into a single array and then
the array can be referenced. This removes the need for
a seperate array of pointers to clocks.

Fix a minor problem of re-initialising the pointers in
s3c6400_set_clksrc() as this is also called by the cpufreq
code. Move these initialisations to the code that does the
registration.

Based on Harald Welte's original clock changes patch.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |  334 +++++++++++++++------------------
 1 files changed, 154 insertions(+), 180 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 5882470..a07e5c9 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -259,7 +259,6 @@ static struct clk_sources clkset_uhost = {
 	.nr_sources	= ARRAY_SIZE(clkset_uhost_list),
 };
 
-
 /* The peripheral clocks are all controlled via clocksource followed
  * by an optional divider and gate stage. We currently roll this into
  * one clock which hides the intermediate clock from the mux.
@@ -358,105 +357,7 @@ static unsigned long s3c64xx_roundrate_clksrc(struct clk *clk,
 	return rate;
 }
 
-static struct clksrc_clk clk_mmc0 = {
-	.clk	= {
-		.name		= "mmc_bus",
-		.id		= 0,
-		.ctrlbit        = S3C_CLKCON_SCLK_MMC0,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_MMC0_SHIFT,
-	.mask		= S3C6400_CLKSRC_MMC0_MASK,
-	.sources	= &clkset_spi_mmc,
-	.divider_shift	= S3C6400_CLKDIV1_MMC0_SHIFT,
-	.reg_divider	= S3C_CLK_DIV1,
-};
-
-static struct clksrc_clk clk_mmc1 = {
-	.clk	= {
-		.name		= "mmc_bus",
-		.id		= 1,
-		.ctrlbit        = S3C_CLKCON_SCLK_MMC1,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_MMC1_SHIFT,
-	.mask		= S3C6400_CLKSRC_MMC1_MASK,
-	.sources	= &clkset_spi_mmc,
-	.divider_shift	= S3C6400_CLKDIV1_MMC1_SHIFT,
-	.reg_divider	= S3C_CLK_DIV1,
-};
-
-static struct clksrc_clk clk_mmc2 = {
-	.clk	= {
-		.name		= "mmc_bus",
-		.id		= 2,
-		.ctrlbit        = S3C_CLKCON_SCLK_MMC2,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_MMC2_SHIFT,
-	.mask		= S3C6400_CLKSRC_MMC2_MASK,
-	.sources	= &clkset_spi_mmc,
-	.divider_shift	= S3C6400_CLKDIV1_MMC2_SHIFT,
-	.reg_divider	= S3C_CLK_DIV1,
-};
-
-static struct clksrc_clk clk_usbhost = {
-	.clk	= {
-		.name		= "usb-bus-host",
-		.id		= -1,
-		.ctrlbit        = S3C_CLKCON_SCLK_UHOST,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_UHOST_SHIFT,
-	.mask		= S3C6400_CLKSRC_UHOST_MASK,
-	.sources	= &clkset_uhost,
-	.divider_shift	= S3C6400_CLKDIV1_UHOST_SHIFT,
-	.reg_divider	= S3C_CLK_DIV1,
-};
-
-static struct clksrc_clk clk_uart_uclk1 = {
-	.clk	= {
-		.name		= "uclk1",
-		.id		= -1,
-		.ctrlbit        = S3C_CLKCON_SCLK_UART,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_UART_SHIFT,
-	.mask		= S3C6400_CLKSRC_UART_MASK,
-	.sources	= &clkset_uart,
-	.divider_shift	= S3C6400_CLKDIV2_UART_SHIFT,
-	.reg_divider	= S3C_CLK_DIV2,
-};
-
-/* Where does UCLK0 come from? */
-
-static struct clksrc_clk clk_spi0 = {
-	.clk	= {
-		.name		= "spi-bus",
-		.id		= 0,
-		.ctrlbit        = S3C_CLKCON_SCLK_SPI0,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_SPI0_SHIFT,
-	.mask		= S3C6400_CLKSRC_SPI0_MASK,
-	.sources	= &clkset_spi_mmc,
-	.divider_shift	= S3C6400_CLKDIV2_SPI0_SHIFT,
-	.reg_divider	= S3C_CLK_DIV2,
-};
-
-static struct clksrc_clk clk_spi1 = {
-	.clk	= {
-		.name		= "spi-bus",
-		.id		= 1,
-		.ctrlbit        = S3C_CLKCON_SCLK_SPI1,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_SPI1_SHIFT,
-	.mask		= S3C6400_CLKSRC_SPI1_MASK,
-	.sources	= &clkset_spi_mmc,
-	.divider_shift	= S3C6400_CLKDIV2_SPI1_SHIFT,
-	.reg_divider	= S3C_CLK_DIV2,
-};
+/* clocks that feed other parts of the clock source tree */
 
 static struct clk clk_iis_cd0 = {
 	.name		= "iis_cdclk0",
@@ -486,20 +387,6 @@ static struct clk_sources clkset_audio0 = {
 	.nr_sources	= ARRAY_SIZE(clkset_audio0_list),
 };
 
-static struct clksrc_clk clk_audio0 = {
-	.clk	= {
-		.name		= "audio-bus",
-		.id		= 0,
-		.ctrlbit        = S3C_CLKCON_SCLK_AUDIO0,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_AUDIO0_SHIFT,
-	.mask		= S3C6400_CLKSRC_AUDIO0_MASK,
-	.sources	= &clkset_audio0,
-	.divider_shift	= S3C6400_CLKDIV2_AUDIO0_SHIFT,
-	.reg_divider	= S3C_CLK_DIV2,
-};
-
 static struct clk *clkset_audio1_list[] = {
 	[0] = &clk_mout_epll.clk,
 	[1] = &clk_dout_mpll,
@@ -513,34 +400,6 @@ static struct clk_sources clkset_audio1 = {
 	.nr_sources	= ARRAY_SIZE(clkset_audio1_list),
 };
 
-static struct clksrc_clk clk_audio1 = {
-	.clk	= {
-		.name		= "audio-bus",
-		.id		= 1,
-		.ctrlbit        = S3C_CLKCON_SCLK_AUDIO1,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_AUDIO1_SHIFT,
-	.mask		= S3C6400_CLKSRC_AUDIO1_MASK,
-	.sources	= &clkset_audio1,
-	.divider_shift	= S3C6400_CLKDIV2_AUDIO1_SHIFT,
-	.reg_divider	= S3C_CLK_DIV2,
-};
-
-static struct clksrc_clk clk_irda = {
-	.clk	= {
-		.name		= "irda-bus",
-		.id		= 0,
-		.ctrlbit        = S3C_CLKCON_SCLK_IRDA,
-		.enable		= s3c64xx_sclk_ctrl,
-	},
-	.shift		= S3C6400_CLKSRC_IRDA_SHIFT,
-	.mask		= S3C6400_CLKSRC_IRDA_MASK,
-	.sources	= &clkset_irda,
-	.divider_shift	= S3C6400_CLKDIV2_IRDA_SHIFT,
-	.reg_divider	= S3C_CLK_DIV2,
-};
-
 static struct clk *clkset_camif_list[] = {
 	&clk_h2,
 };
@@ -550,18 +409,141 @@ static struct clk_sources clkset_camif = {
 	.nr_sources	= ARRAY_SIZE(clkset_camif_list),
 };
 
-static struct clksrc_clk clk_camif = {
-	.clk	= {
-		.name		= "camera",
-		.id		= -1,
-		.ctrlbit        = S3C_CLKCON_SCLK_CAM,
-		.enable		= s3c64xx_sclk_ctrl,
+static struct clksrc_clk clksrcs[] = {
+	{
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 0,
+			.ctrlbit        = S3C_CLKCON_SCLK_MMC0,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_MMC0_SHIFT,
+		.mask		= S3C6400_CLKSRC_MMC0_MASK,
+		.sources	= &clkset_spi_mmc,
+		.divider_shift	= S3C6400_CLKDIV1_MMC0_SHIFT,
+		.reg_divider	= S3C_CLK_DIV1,
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 1,
+			.ctrlbit        = S3C_CLKCON_SCLK_MMC1,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_MMC1_SHIFT,
+		.mask		= S3C6400_CLKSRC_MMC1_MASK,
+		.sources	= &clkset_spi_mmc,
+		.divider_shift	= S3C6400_CLKDIV1_MMC1_SHIFT,
+		.reg_divider	= S3C_CLK_DIV1,
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 2,
+			.ctrlbit        = S3C_CLKCON_SCLK_MMC2,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_MMC2_SHIFT,
+		.mask		= S3C6400_CLKSRC_MMC2_MASK,
+		.sources	= &clkset_spi_mmc,
+		.divider_shift	= S3C6400_CLKDIV1_MMC2_SHIFT,
+		.reg_divider	= S3C_CLK_DIV1,
+	}, {
+		.clk	= {
+			.name		= "usb-bus-host",
+			.id		= -1,
+			.ctrlbit        = S3C_CLKCON_SCLK_UHOST,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_UHOST_SHIFT,
+		.mask		= S3C6400_CLKSRC_UHOST_MASK,
+		.sources	= &clkset_uhost,
+		.divider_shift	= S3C6400_CLKDIV1_UHOST_SHIFT,
+		.reg_divider	= S3C_CLK_DIV1,
+	}, {
+		.clk	= {
+			.name		= "uclk1",
+			.id		= -1,
+			.ctrlbit        = S3C_CLKCON_SCLK_UART,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_UART_SHIFT,
+		.mask		= S3C6400_CLKSRC_UART_MASK,
+		.sources	= &clkset_uart,
+		.divider_shift	= S3C6400_CLKDIV2_UART_SHIFT,
+		.reg_divider	= S3C_CLK_DIV2,
+	}, {
+/* Where does UCLK0 come from? */
+		.clk	= {
+			.name		= "spi-bus",
+			.id		= 0,
+			.ctrlbit        = S3C_CLKCON_SCLK_SPI0,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_SPI0_SHIFT,
+		.mask		= S3C6400_CLKSRC_SPI0_MASK,
+		.sources	= &clkset_spi_mmc,
+		.divider_shift	= S3C6400_CLKDIV2_SPI0_SHIFT,
+		.reg_divider	= S3C_CLK_DIV2,
+	}, {
+		.clk	= {
+			.name		= "spi-bus",
+			.id		= 1,
+			.ctrlbit        = S3C_CLKCON_SCLK_SPI1,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_SPI1_SHIFT,
+		.mask		= S3C6400_CLKSRC_SPI1_MASK,
+		.sources	= &clkset_spi_mmc,
+		.divider_shift	= S3C6400_CLKDIV2_SPI1_SHIFT,
+		.reg_divider	= S3C_CLK_DIV2,
+	}, {
+		.clk	= {
+			.name		= "audio-bus",
+			.id		= 0,
+			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO0,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_AUDIO0_SHIFT,
+		.mask		= S3C6400_CLKSRC_AUDIO0_MASK,
+		.sources	= &clkset_audio0,
+		.divider_shift	= S3C6400_CLKDIV2_AUDIO0_SHIFT,
+		.reg_divider	= S3C_CLK_DIV2,
+	}, {
+		.clk	= {
+			.name		= "audio-bus",
+			.id		= 1,
+			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO1,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_AUDIO1_SHIFT,
+		.mask		= S3C6400_CLKSRC_AUDIO1_MASK,
+		.sources	= &clkset_audio1,
+		.divider_shift	= S3C6400_CLKDIV2_AUDIO1_SHIFT,
+		.reg_divider	= S3C_CLK_DIV2,
+	}, {
+		.clk	= {
+			.name		= "irda-bus",
+			.id		= 0,
+			.ctrlbit        = S3C_CLKCON_SCLK_IRDA,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= S3C6400_CLKSRC_IRDA_SHIFT,
+		.mask		= S3C6400_CLKSRC_IRDA_MASK,
+		.sources	= &clkset_irda,
+		.divider_shift	= S3C6400_CLKDIV2_IRDA_SHIFT,
+		.reg_divider	= S3C_CLK_DIV2,
+	}, {
+		.clk	= {
+			.name		= "camera",
+			.id		= -1,
+			.ctrlbit        = S3C_CLKCON_SCLK_CAM,
+			.enable		= s3c64xx_sclk_ctrl,
+		},
+		.shift		= 0,
+		.mask		= 0,
+		.sources	= &clkset_camif,
+		.divider_shift	= S3C6400_CLKDIV0_CAM_SHIFT,
+		.reg_divider	= S3C_CLK_DIV0,
 	},
-	.shift		= 0,
-	.mask		= 0,
-	.sources	= &clkset_camif,
-	.divider_shift	= S3C6400_CLKDIV0_CAM_SHIFT,
-	.reg_divider	= S3C_CLK_DIV0,
 };
 
 /* Clock initialisation code */
@@ -570,17 +552,6 @@ static struct clksrc_clk *init_parents[] = {
 	&clk_mout_apll,
 	&clk_mout_epll,
 	&clk_mout_mpll,
-	&clk_mmc0,
-	&clk_mmc1,
-	&clk_mmc2,
-	&clk_usbhost,
-	&clk_uart_uclk1,
-	&clk_spi0,
-	&clk_spi1,
-	&clk_audio0,
-	&clk_audio1,
-	&clk_irda,
-	&clk_camif,
 };
 
 static void __init_or_cpufreq s3c6400_set_clksrc(struct clksrc_clk *clk)
@@ -597,11 +568,6 @@ static void __init_or_cpufreq s3c6400_set_clksrc(struct clksrc_clk *clk)
 		return;
 	}
 
-	clk->clk.get_rate = s3c64xx_getrate_clksrc;
-	clk->clk.set_rate = s3c64xx_setrate_clksrc;
-	clk->clk.set_parent = s3c64xx_setparent_clksrc;
-	clk->clk.round_rate = s3c64xx_roundrate_clksrc;
-
 	clk->clk.parent = srcs->sources[clksrc];
 
 	printk(KERN_INFO "%s: source is %s (%d), rate is %ld\n",
@@ -668,6 +634,9 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 
 	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
 		s3c6400_set_clksrc(init_parents[ptr]);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c6400_set_clksrc(&clksrcs[ptr]);
 }
 
 static struct clk *clks[] __initdata = {
@@ -679,17 +648,6 @@ static struct clk *clks[] __initdata = {
 	&clk_fout_epll,
 	&clk_mout_mpll.clk,
 	&clk_dout_mpll,
-	&clk_mmc0.clk,
-	&clk_mmc1.clk,
-	&clk_mmc2.clk,
-	&clk_usbhost.clk,
-	&clk_uart_uclk1.clk,
-	&clk_spi0.clk,
-	&clk_spi1.clk,
-	&clk_audio0.clk,
-	&clk_audio1.clk,
-	&clk_irda.clk,
-	&clk_camif.clk,
 	&clk_arm,
 };
 
@@ -722,6 +680,22 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
 		}
 	}
 
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++) {
+		clkp = &clksrcs[ptr].clk;
+
+		/* all clksrc clocks have these */
+		clkp->get_rate = s3c64xx_getrate_clksrc;
+		clkp->set_rate = s3c64xx_setrate_clksrc;
+		clkp->set_parent = s3c64xx_setparent_clksrc;
+		clkp->round_rate = s3c64xx_roundrate_clksrc;
+
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+	}
+
 	clk_mpll.parent = &clk_mout_mpll.clk;
 	clk_epll.parent = &clk_mout_epll.clk;
 }
-- 
1.5.6.5
