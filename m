From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:44 +0900
Subject: [PATCH 09/18] ARM: S5PV210: Fix clk_get_rate issue with the clk_h100
	clock
Message-ID: <1274056724-14482-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_h100 clock represents the IMEM clock for the MSYS domain.
This clock rate of this clock is always half of the hclk_msys clock.
There is an issue when getting the clock rate of the clk_h100 clock
(clock get_rate hclk_h100 always returns clock rate that is equal to
the hclk_msys clock rate).

This patch modifies the following.

1. Moves the definition of the clk_h100 clock into the 'init_clocks'
   list with the appropriate parent, ctrlbit, enable and ops fields.

2. The name of the clock is changed from 'clk_h100' to 'hclk_imem'
   to represent more clearly that is represents the IMEM clock in
   the MSYS domain.

3. The function to get the clock rate of the hclk_imem clock is added.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 4791642..527c9c4 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -155,11 +155,6 @@ static int s5pv210_clk_ip3_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
 }
 
-static struct clk clk_h100 = {
-	.name		= "hclk100",
-	.id		= -1,
-};
-
 static struct clk clk_p83 = {
 	.name		= "pclk83",
 	.id		= -1,
@@ -171,11 +166,19 @@ static struct clk clk_p66 = {
 };
 
 static struct clk *sys_clks[] = {
-	&clk_h100,
 	&clk_p83,
 	&clk_p66
 };
 
+static unsigned long s5pv210_clk_imem_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / 2;
+}
+
+static struct clk_ops clk_hclk_imem_ops = {
+	.get_rate	= s5pv210_clk_imem_get_rate,
+};
+
 static struct clk init_clocks_disable[] = {
 	{
 		.name		= "rot",
@@ -326,6 +329,13 @@ static struct clk init_clocks_disable[] = {
 
 static struct clk init_clocks[] = {
 	{
+		.name		= "hclk_imem",
+		.id		= -1,
+		.parent		= &clk_hclk_msys.clk,
+		.ctrlbit	= (1 << 5),
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ops		= &clk_hclk_imem_ops,
+	}, {
 		.name		= "uart",
 		.id		= 0,
 		.parent		= &clk_p66,
-- 
1.6.2.5
