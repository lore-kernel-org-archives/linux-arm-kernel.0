From: david@lechnology.com (David Lechner)
Date: Sun, 31 Dec 2017 17:39:44 -0600
Subject: [PATCH v4 3/7] ARM: davinci: fix duplicate clocks
In-Reply-To: <1514763588-31560-1-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
Message-ID: <1514763588-31560-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of clocks that were duplicated because they are used by
more than one device. It is no longer necessary to do this since we are
explicitly calling clk_register_clkdev() for each clock. In da830.c, some
clocks were using the same LPSC, which would cause problems with reference
counting, so these are combinded into one clock each. In da850.c the
duplicate clocks had already been fixed by creating dummy child clocks, so
these clocks are removed.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da830.c  | 65 ++++++--------------------------------
 arch/arm/mach-davinci/da850.c  | 72 ------------------------------------------
 arch/arm/mach-davinci/dm365.c  |  1 -
 arch/arm/mach-davinci/dm644x.c |  3 --
 arch/arm/mach-davinci/dm646x.c |  1 -
 5 files changed, 9 insertions(+), 133 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 73c48f5..b0e54a1 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -213,57 +213,22 @@ static struct clk spi1_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk ecap0_clk = {
-	.name		= "ecap0",
+static struct clk ecap_clk = {
+	.name		= "ecap",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_ECAP,
 	.gpsc		= 1,
 };
 
-static struct clk ecap1_clk = {
-	.name		= "ecap1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_ECAP,
-	.gpsc		= 1,
-};
-
-static struct clk ecap2_clk = {
-	.name		= "ecap2",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_ECAP,
-	.gpsc		= 1,
-};
-
-static struct clk pwm0_clk = {
-	.name		= "pwm0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_PWM,
-	.gpsc		= 1,
-};
-
-static struct clk pwm1_clk = {
-	.name		= "pwm1",
+static struct clk pwm_clk = {
+	.name		= "pwm",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_PWM,
 	.gpsc		= 1,
 };
 
-static struct clk pwm2_clk = {
-	.name		= "pwm2",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_PWM,
-	.gpsc		= 1,
-};
-
-static struct clk eqep0_clk = {
-	.name		= "eqep0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA830_LPSC1_EQEP,
-	.gpsc		= 1,
-};
-
-static struct clk eqep1_clk = {
-	.name		= "eqep1",
+static struct clk eqep_clk = {
+	.name		= "eqep",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_EQEP,
 	.gpsc		= 1,
@@ -304,11 +269,6 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk cppi41_clk = {
-	.name		= "cppi41",
-	.parent		= &usb20_clk,
-};
-
 static struct clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll0_sysclk3,
@@ -434,21 +394,16 @@ static __init void da830_clk_init(void)
 	clk_register_clkdev(clk, NULL, "spi_davinci.0");
 	clk = davinci_clk_init(&spi1_clk);
 	clk_register_clkdev(clk, NULL, "spi_davinci.1");
-	clk = davinci_clk_init(&ecap0_clk);
+	clk = davinci_clk_init(&ecap_clk);
 	clk_register_clkdev(clk, "ecap0", NULL);
-	clk = davinci_clk_init(&ecap1_clk);
 	clk_register_clkdev(clk, "ecap1", NULL);
-	clk = davinci_clk_init(&ecap2_clk);
 	clk_register_clkdev(clk, "ecap2", NULL);
-	clk = davinci_clk_init(&pwm0_clk);
+	clk = davinci_clk_init(&pwm_clk);
 	clk_register_clkdev(clk, "pwm0", NULL);
-	clk = davinci_clk_init(&pwm1_clk);
 	clk_register_clkdev(clk, "pwm1", NULL);
-	clk = davinci_clk_init(&pwm2_clk);
 	clk_register_clkdev(clk, "pwm2", NULL);
-	clk = davinci_clk_init(&eqep0_clk);
+	clk = davinci_clk_init(&eqep_clk);
 	clk_register_clkdev(clk, NULL, "eqep.0");
-	clk = davinci_clk_init(&eqep1_clk);
 	clk_register_clkdev(clk, NULL, "eqep.1");
 	clk = davinci_clk_init(&lcdc_clk);
 	clk_register_clkdev(clk, "fck", "da8xx_lcdc.0");
@@ -460,7 +415,6 @@ static __init void da830_clk_init(void)
 	clk_register_clkdev(clk, NULL, "davinci-mcasp.2");
 	clk = davinci_clk_init(&usb20_clk);
 	clk_register_clkdev(clk, "usb20", "musb-da8xx");
-	clk = davinci_clk_init(&cppi41_clk);
 	clk_register_clkdev(clk, NULL, "cppi41-dmaengine");
 	clk = davinci_clk_init(&aemif_clk);
 	clk_register_clkdev(clk, "aemif", NULL);
@@ -470,7 +424,6 @@ static __init void da830_clk_init(void)
 	clk_register_clkdev(clk, "secu_mgr", NULL);
 	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, NULL, "davinci_emac.1");
-	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, "fck", "davinci_mdio.0");
 	clk = davinci_clk_init(&gpio_clk);
 	clk_register_clkdev(clk, "gpio", NULL);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index eaa05ac..0975edb 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -319,16 +319,6 @@ static struct clk emac_clk = {
 	.gpsc		= 1,
 };
 
-/*
- * In order to avoid adding the emac_clk to the clock lookup table twice (and
- * screwing up the linked list in the process) create a separate clock for
- * mdio inheriting the rate from emac_clk.
- */
-static struct clk mdio_clk = {
-	.name		= "mdio",
-	.parent		= &emac_clk,
-};
-
 static struct clk mcasp_clk = {
 	.name		= "mcasp",
 	.parent		= &async3_clk,
@@ -377,16 +367,6 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
-/*
- * In order to avoid adding the aemif_clk to the clock lookup table twice (and
- * screwing up the linked list in the process) create a separate clock for
- * nand inheriting the rate from aemif_clk.
- */
-static struct clk aemif_nand_clk = {
-	.name		= "nand",
-	.parent		= &aemif_clk,
-};
-
 static struct clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
@@ -401,11 +381,6 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk cppi41_clk = {
-	.name		= "cppi41",
-	.parent		= &usb20_clk,
-};
-
 static struct clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll0_sysclk2,
@@ -449,16 +424,6 @@ static struct clk ehrpwm_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk ehrpwm0_clk = {
-	.name		= "ehrpwm0",
-	.parent		= &ehrpwm_clk,
-};
-
-static struct clk ehrpwm1_clk = {
-	.name		= "ehrpwm1",
-	.parent		= &ehrpwm_clk,
-};
-
 #define DA8XX_EHRPWM_TBCLKSYNC	BIT(12)
 
 static void ehrpwm_tblck_enable(struct clk *clk)
@@ -486,15 +451,6 @@ static struct clk ehrpwm_tbclk = {
 	.clk_disable	= ehrpwm_tblck_disable,
 };
 
-static struct clk ehrpwm0_tbclk = {
-	.name		= "ehrpwm0_tbclk",
-	.parent		= &ehrpwm_tbclk,
-};
-
-static struct clk ehrpwm1_tbclk = {
-	.name		= "ehrpwm1_tbclk",
-	.parent		= &ehrpwm_tbclk,
-};
 
 static struct clk ecap_clk = {
 	.name		= "ecap",
@@ -503,21 +459,6 @@ static struct clk ecap_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk ecap0_clk = {
-	.name		= "ecap0_clk",
-	.parent		= &ecap_clk,
-};
-
-static struct clk ecap1_clk = {
-	.name		= "ecap1_clk",
-	.parent		= &ecap_clk,
-};
-
-static struct clk ecap2_clk = {
-	.name		= "ecap2_clk",
-	.parent		= &ecap_clk,
-};
-
 static __init void da850_clk_init(void)
 {
 	struct clk *clk;
@@ -592,7 +533,6 @@ static __init void da850_clk_init(void)
 	clk_register_clkdev(clk, "rmii", NULL);
 	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, NULL, "davinci_emac.1");
-	clk = davinci_clk_init(&mdio_clk);
 	clk_register_clkdev(clk, "fck", "davinci_mdio.0");
 	clk = davinci_clk_init(&mcasp_clk);
 	clk_register_clkdev(clk, NULL, "davinci-mcasp.0");
@@ -608,13 +548,11 @@ static __init void da850_clk_init(void)
 	clk_register_clkdev(clk, NULL, "da830-mmc.1");
 	clk = davinci_clk_init(&aemif_clk);
 	clk_register_clkdev(clk, NULL, "ti-aemif");
-	clk = davinci_clk_init(&aemif_nand_clk);
 	clk_register_clkdev(clk, "aemif", "davinci-nand.0");
 	clk = davinci_clk_init(&usb11_clk);
 	clk_register_clkdev(clk, "usb11", "ohci-da8xx");
 	clk = davinci_clk_init(&usb20_clk);
 	clk_register_clkdev(clk, "usb20", "musb-da8xx");
-	clk = davinci_clk_init(&cppi41_clk);
 	clk_register_clkdev(clk, NULL, "cppi41-dmaengine");
 	clk = davinci_clk_init(&spi0_clk);
 	clk_register_clkdev(clk, NULL, "spi_davinci.0");
@@ -627,24 +565,14 @@ static __init void da850_clk_init(void)
 	clk = davinci_clk_init(&dsp_clk);
 	clk_register_clkdev(clk, NULL, "davinci-rproc.0");
 	clk = davinci_clk_init(&ehrpwm_clk);
-	clk_register_clkdev(clk, NULL, NULL);
-	clk = davinci_clk_init(&ehrpwm0_clk);
 	clk_register_clkdev(clk, "fck", "ehrpwm.0");
-	clk = davinci_clk_init(&ehrpwm1_clk);
 	clk_register_clkdev(clk, "fck", "ehrpwm.1");
 	clk = davinci_clk_init(&ehrpwm_tbclk);
-	clk_register_clkdev(clk, NULL, NULL);
-	clk = davinci_clk_init(&ehrpwm0_tbclk);
 	clk_register_clkdev(clk, "tbclk", "ehrpwm.0");
-	clk = davinci_clk_init(&ehrpwm1_tbclk);
 	clk_register_clkdev(clk, "tbclk", "ehrpwm.1");
 	clk = davinci_clk_init(&ecap_clk);
-	clk_register_clkdev(clk, NULL, NULL);
-	clk = davinci_clk_init(&ecap0_clk);
 	clk_register_clkdev(clk, "fck", "ecap.0");
-	clk = davinci_clk_init(&ecap1_clk);
 	clk_register_clkdev(clk, "fck", "ecap.1");
-	clk = davinci_clk_init(&ecap2_clk);
 	clk_register_clkdev(clk, "fck", "ecap.2");
 }
 
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 0cf4ab4..430fb1e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -533,7 +533,6 @@ static __init void dm365_clk_init(void)
 	clk_register_clkdev(clk, "usb", NULL);
 	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, NULL, "davinci_emac.1");
-	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, "fck", "davinci_mdio.0");
 	clk = davinci_clk_init(&voicecodec_clk);
 	clk_register_clkdev(clk, NULL, "davinci_voicecodec");
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 769ce29..58120f4 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -323,8 +323,6 @@ static __init void dm644x_clk_init(void)
 	clk_register_clkdev(clk, "master", "vpss");
 	clk = davinci_clk_init(&vpss_slave_clk);
 	clk_register_clkdev(clk, "slave", "vpss");
-	clk = davinci_clk_init(&arm_clk);
-	clk_register_clkdev(clk, "arm", NULL);
 	clk = davinci_clk_init(&uart0_clk);
 	clk_register_clkdev(clk, NULL, "serial8250.0");
 	clk = davinci_clk_init(&uart1_clk);
@@ -333,7 +331,6 @@ static __init void dm644x_clk_init(void)
 	clk_register_clkdev(clk, NULL, "serial8250.2");
 	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, NULL, "davinci_emac.1");
-	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, "fck", "davinci_mdio.0");
 	clk = davinci_clk_init(&i2c_clk);
 	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index d75b4bc09..0cd5d51 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -386,7 +386,6 @@ static __init void dm646x_clk_init(void)
 	clk_register_clkdev(clk, "aemif", NULL);
 	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, NULL, "davinci_emac.1");
-	clk = davinci_clk_init(&emac_clk);
 	clk_register_clkdev(clk, "fck", "davinci_mdio.0");
 	clk = davinci_clk_init(&pwm0_clk);
 	clk_register_clkdev(clk, "pwm0", NULL);
-- 
2.7.4
