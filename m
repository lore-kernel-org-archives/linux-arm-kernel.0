From: avinashphilip@ti.com (Philip Avinash)
Date: Thu, 14 Mar 2013 16:07:31 +0530
Subject: [PATCH 1/3] arm: davinci: clock node support for ECAP & EHRPWM
In-Reply-To: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
References: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1363257453-24747-2-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock node support for ECAP and EHRPWM modules.
Also adds dummy clock for EHRWPM TBCLK to comply with pwm-tiehrpwm
driver.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
:100644 100644 0c4a26d... 891d075... M	arch/arm/mach-davinci/da850.c
 arch/arm/mach-davinci/da850.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 0c4a26d..891d075 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -383,6 +383,27 @@ static struct clk dsp_clk = {
 	.flags		= PSC_LRST | PSC_FORCE,
 };
 
+static struct clk ehrpwm_clk = {
+	.name		= "ehrpwm",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_PWM,
+	.gpsc		= 1,
+	.flags		= DA850_CLK_ASYNC3,
+};
+
+static struct clk ehrpwm_tbclk = {
+	.name		= "ehrpwm_tbclk",
+	.parent		= NULL,
+};
+
+static struct clk ecap_clk = {
+	.name		= "ecap",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_ECAP,
+	.gpsc		= 1,
+	.flags		= DA850_CLK_ASYNC3,
+};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -430,6 +451,9 @@ static struct clk_lookup da850_clks[] = {
 	CLK("vpif",		NULL,		&vpif_clk),
 	CLK("ahci",		NULL,		&sata_clk),
 	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
+	CLK("ehrpwm",		"fck",		&ehrpwm_clk),
+	CLK("ehrpwm",		"tbclk",	&ehrpwm_tbclk),
+	CLK("ecap",		"fck",		&ecap_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
-- 
1.7.9.5
