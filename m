From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 15:34:40 +0800
Subject: [PATCH 1/1] ARM: mxc: change timer clock to perclk
Message-ID: <1337067280-11697-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix system time goes too fast.
perclk rate not changed or gated in low power mode, so we
choose perclk for gpt.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/plat-mxc/time.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

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
1.7.5.4
