From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:33:59 +0900
Subject: [PATCH 05/16] ARM: shmobile: r8a73a4: safeguard against wrong
 clk_set_rate() uses
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
Message-ID: <d1c3c959f2206dad0582876af2510aded4f9eac5.1374624383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

clk_set_rate() should only be called with exact rates, returned by
clk_round_rate(). However, it is still good to verify, that the value,
passed to clock's .set_rate() method is at least valid. This patch adds
such a check for the Z-clock on r8a73a4.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 824789c..22f10ff 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -225,16 +225,28 @@ static int zclk_set_rate(struct clk *clk, unsigned long rate)
 		goto done;
 	}
 
-	frqcrc = clk->mapped_reg + (FRQCRC - (u32)clk->enable_reg);
+	/*
+	 * Users are supposed to first call clk_set_rate() only with
+	 * clk_round_rate() results. So, we don't fix wrong rates here, but
+	 * guard against them anyway
+	 */
 
 	p_rate = clk_get_rate(clk->parent);
 	if (rate == p_rate) {
 		val = 0;
 	} else {
 		step = DIV_ROUND_CLOSEST(p_rate, 32);
+
+		if (rate > p_rate || rate < step) {
+			ret = -EINVAL;
+			goto done;
+		}
+
 		val = 32 - rate / step;
 	}
 
+	frqcrc = clk->mapped_reg + (FRQCRC - (u32)clk->enable_reg);
+
 	iowrite32((ioread32(frqcrc) & ~(clk->div_mask << clk->enable_bit)) |
 		  (val << clk->enable_bit), frqcrc);
 
-- 
1.8.2.1
