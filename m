From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 May 2012 12:50:19 +0200
Subject: [PATCH 2/4] ARM: i.MX: change timer clock from ipg to perclk
In-Reply-To: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
References: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337165421-17118-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@freescale.com>

Contrary to the ipg clock the perclk rate is not changed or
gated in low power mode, so we choose perclk for gpt.

With the port to the common clock framework as a side effect
the timer used the rate returned from the peripheral clock
but the hardware was still programmed to use the ipg clock,
so this patch only changes the hardware to really use the
clock it already assumed.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/time.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 99f958c..d865f79 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -58,6 +58,7 @@
 /* MX31, MX35, MX25, MX5 */
 #define V2_TCTL_WAITEN		(1 << 3) /* Wait enable mode */
 #define V2_TCTL_CLK_IPG		(1 << 6)
+#define V2_TCTL_CLK_PER		(2 << 6)
 #define V2_TCTL_FRR		(1 << 9)
 #define V2_IR			0x0c
 #define V2_TSTAT		0x08
@@ -309,7 +310,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
 
 	if (timer_is_v2())
-		tctl_val = V2_TCTL_CLK_IPG | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+		tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
 	else
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 
-- 
1.7.10
