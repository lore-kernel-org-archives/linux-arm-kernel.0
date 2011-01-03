From: iban@fqingenieria.es (FQ | Iban Cerro)
Date: Mon, 3 Jan 2011 09:59:21 +0100 (CET)
Subject: [PATCH 01/04] ARM i.MX25 Add SIM clock support
Message-ID: <13001.212.121.242.58.1294045161.squirrel@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Adds SIM clock support

Signed-off-by: Iban Cerro Galvez <iban@fqingenieria.es>
---
 arch/arm/mach-imx/clock-imx25.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c
b/arch/arm/mach-imx/clock-imx25.c
index 21ef34c..f302fab 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -154,6 +154,16 @@ static unsigned long get_rate_csi(struct clk *clk)
 	return get_rate_per(0);
 }

+static unsigned long get_rate_sim1(struct clk *clk)
+{
+	return get_rate_per(11);
+}
+
+static unsigned long get_rate_sim2(struct clk *clk)
+{
+	return get_rate_per(12);
+}
+
 static unsigned long get_rate_otg(struct clk *clk)
 {
 	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
@@ -226,6 +236,8 @@ DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7,
get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(esdhc1_ahb_clk, 0, CCM_CGCR0, 21, get_rate_esdhc1,	 NULL,
NULL);
 DEFINE_CLOCK(esdhc1_per_clk, 0, CCM_CGCR0,  3, get_rate_esdhc1,	 NULL,
 		&esdhc1_ahb_clk);
+DEFINE_CLOCK(sim1_per_clk, 0, CCM_CGCR0, 11, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(sim2_per_clk, 0, CCM_CGCR0, 12, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(esdhc2_ahb_clk, 0, CCM_CGCR0, 22, get_rate_esdhc2,	 NULL,
NULL);
 DEFINE_CLOCK(esdhc2_per_clk, 0, CCM_CGCR0,  4, get_rate_esdhc2,	 NULL,
 		&esdhc2_ahb_clk);
@@ -262,6 +274,8 @@ DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL,
NULL);
 DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL, 
&csi_per_clk);
 DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(sim1_clk,  0, CCM_CGCR2, 7, get_rate_sim1, NULL,
&sim1_per_clk);
+DEFINE_CLOCK(sim2_clk,  0, CCM_CGCR2, 8, get_rate_sim2, NULL,
&sim2_per_clk);

 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -305,6 +319,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
+	_REGISTER_CLOCK("mxc-sim.0", NULL, sim1_clk)
+	_REGISTER_CLOCK("mxc-sim.1", NULL, sim2_clk)
 };

 int __init mx25_clocks_init(void)
-- 
1.5.4.3
