From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 14 Nov 2018 23:57:23 +0100
Subject: [RFC v1 5/7] clk: meson: meson8b: mark the CPU clock as
 CLK_IS_CRITICAL
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181114225725.2821-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want the common clock framework to disable the "cpu_clk" if
it's not used by any device. The cpufreq-dt driver does not enable the
CPU clocks. However, even if it would we would still want the CPU clock
to be enabled at all times because the CPU clock is also required even
if we disable CPU frequency scaling on a specific board.

The reason why we want the CPU clock to be enabled is a clock further up
in the tree:
Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") the
sys_pll can be disabled. However, since the CPU clock is derived from
sys_pll we don't want sys_pll to get disabled. The common clock
framework takes care of that for us by enabling all parent clocks of our
CPU clock when we mark the CPU clock with CLK_IS_CRITICAL.

Until now this is not a problem yet because all clocks in the CPU
clock's tree (including sys_pll) are read-only. However, once we allow
modifications to the clocks in that tree we will need this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 8a3c346e110d..d566dd5bc567 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -646,7 +646,8 @@ static struct clk_regmap meson8b_cpu_clk = {
 						  "cpu_scale_out_sel" },
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
-			  CLK_SET_RATE_NO_REPARENT),
+			  CLK_SET_RATE_NO_REPARENT |
+			  CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.19.1
