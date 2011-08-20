From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 20 Aug 2011 18:03:08 +0200
Subject: [PATCH 3/4] S3C2416: Add HSSPI clock sourced from EPLL
In-Reply-To: <201108201757.56483.heiko@sntech.de>
References: <201108201757.56483.heiko@sntech.de>
Message-ID: <201108201803.08715.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is special to the S3C2416/2450 SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/clock.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 21a5e81..5177d79 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -38,6 +38,30 @@ static unsigned int armdiv[8] = {
 	[7] = 8,
 };
 
+static struct clksrc_clk hsspi_eplldiv = {
+	.clk = {
+		.name	= "hsspi-eplldiv",
+		.parent	= &clk_esysclk.clk,
+		.ctrlbit = (1 << 14),
+		.enable = s3c2443_clkcon_enable_s,
+	},
+	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 24 },
+};
+
+static struct clksrc_clk hsspi_mux = {
+	.clk	= {
+		.name	= "hsspi-if",
+	},
+	.sources = &(struct clksrc_sources) {
+		.nr_sources = 2,
+		.sources = (struct clk *[]) {
+			[0] = &hsspi_eplldiv.clk,
+			[1] = NULL, /* to fix */
+		},
+	},
+	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 18 },
+};
+
 static struct clksrc_clk hsmmc_div[] = {
 	[0] = {
 		.clk = {
@@ -114,6 +138,8 @@ void __init_or_cpufreq s3c2416_setup_clocks(void)
 
 
 static struct clksrc_clk *clksrcs[] __initdata = {
+	&hsspi_eplldiv,
+	&hsspi_mux,
 	&hsmmc_div[0],
 	&hsmmc_div[1],
 	&hsmmc_mux[0],
-- 
1.7.2.3
