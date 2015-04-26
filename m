From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:03 +0800
Subject: [PATCH 02/11] ARM: imx: use dynamic mapping for CCM
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the static mapping of CCM block in clock drivers with dynamic
mapping.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx1.c  | 3 ++-
 arch/arm/mach-imx/clk-imx31.c | 5 ++++-
 arch/arm/mach-imx/clk-imx35.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index f4a76e841966..5301d2ebb234 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -75,7 +75,8 @@ static void __init _mx1_clocks_init(unsigned long fref)
 
 int __init mx1_clocks_init(unsigned long fref)
 {
-	ccm = MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR);
+	ccm = ioremap(MX1_CCM_BASE_ADDR, SZ_4K);
+	BUG_ON(!ccm);
 
 	_mx1_clocks_init(fref);
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 8a103a2c8b68..2aaccadb9e13 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -50,9 +50,12 @@ static struct clk_onecell_data clk_data;
 
 int __init mx31_clocks_init(unsigned long fref)
 {
-	void __iomem *base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
+	void __iomem *base;
 	struct device_node *np;
 
+	base = ioremap(MX31_CCM_BASE_ADDR, SZ_4K);
+	BUG_ON(!base);
+
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
 	clk[ckil] = imx_clk_fixed("ckil", 32768);
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 4ef1e8bdac5b..14f33ec049bc 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -71,11 +71,14 @@ static struct clk *clk[clk_max];
 
 int __init mx35_clocks_init(void)
 {
-	void __iomem *base = MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR);
+	void __iomem *base;
 	u32 pdr0, consumer_sel, hsp_sel;
 	struct arm_ahb_div *aad;
 	unsigned char *hsp_div;
 
+	base = ioremap(MX35_CCM_BASE_ADDR, SZ_4K);
+	BUG_ON(base);
+
 	pdr0 = __raw_readl(base + MXC_CCM_PDR0);
 	consumer_sel = (pdr0 >> 16) & 0xf;
 	aad = &clk_consumer[consumer_sel];
-- 
1.9.1
