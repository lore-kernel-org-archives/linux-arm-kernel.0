From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:33:57 +0900
Subject: [PATCH 03/16] ARM: shmobile: r8a73a4: wait for completion when
 kicking the clock
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
Message-ID: <8d27657286a1e9e6ee7adaf4d0638cefd708a6fa.1374624383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

To reconfigure clocks, controlled by FRQCRA and FRQCRB, a kick bit has to
be set and to make sure the setting has taken effect, it has to be read
back repeatedly until it is cleared by the hardware. This patch adds the
waiting part, that was missing until now.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 5f7fe62..d5176d0 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -184,6 +184,21 @@ PLL_CLOCK(pll2h_clk, &main_div2_clk, pll_parent_main_extal, 3, 5, PLL2HCR, 5);
 
 SH_FIXED_RATIO_CLK(pll1_div2_clk,	pll1_clk,	div2);
 
+static int frqcr_kick_do(struct clk *clk)
+{
+	int i;
+
+	/* set KICK bit in FRQCRB to update hardware setting, check success */
+	iowrite32(ioread32(CPG_MAP(FRQCRB)) | BIT(31), CPG_MAP(FRQCRB));
+	for (i = 1000; i; i--)
+		if (ioread32(CPG_MAP(FRQCRB)) & BIT(31))
+			cpu_relax();
+		else
+			return 0;
+
+	return -ETIMEDOUT;
+}
+
 static struct clk *main_clks[] = {
 	&extalr_clk,
 	&extal1_clk,
@@ -205,12 +220,7 @@ static struct clk *main_clks[] = {
 /* DIV4 */
 static void div4_kick(struct clk *clk)
 {
-	unsigned long value;
-
-	/* set KICK bit in FRQCRB to update hardware setting */
-	value = ioread32(CPG_MAP(FRQCRB));
-	value |= (1 << 31);
-	iowrite32(value, CPG_MAP(FRQCRB));
+	frqcr_kick_do(clk);
 }
 
 static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 18, 24, 0, 36, 48, 10};
-- 
1.8.2.1
