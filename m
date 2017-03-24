From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Fri, 24 Mar 2017 14:31:10 +0300
Subject: [PATCH] clk: rockchip: limit i2s0_pre max rate on rk3188
Message-ID: <1490355070-21818-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change i2s0_pre from 768MHz to 192MHz and limit it's rate to 192MHz in
order to fix issues described below.

If right after the boot change i2s0_clk to 16.384MHz, real rate on
i2s0_clk pin may differ from 16.384MHz. The issue is random. Sometimes
rate on i2s0_clk pin equal to 16.384MHz, sometimes not.

There is another 100% reproducable issue. First we have to boot and see
the correct frequency on i2s0_clk pin (16.384MHz). Then we change its rate
to 8.192MHz (and it changes), then we change its rate again to 16.384MHz.
Rate leaves unchanged and equal to 8.192MHz.

'clk_summary' shows following clock connection in all the cases, where
rate was set to 16.384MHz (even then real rate differs).

    clock                       rate
    -----                       ----
    xin24m                      24000000
      pll_gpll                  768000000
         gpll                   768000000
            i2s_src             768000000
               i2s0_pre         768000000
                  i2s0_frac     16384000
                     sclk_i2s0  16384000

Also I found, that if I change i2s0_pre to 192MHz all the issues described
above gone. I supposed that the issues is due to high i2s0_pre rate.
Probably rk3188 has some sort of frequency restrictions imposed. Haven't
found anything in the RK3188 TRM, so this is my assumption.

Anyway, with the patch, all the issues gone.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index d0e722a..e883f48 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -849,6 +849,15 @@ static void __init rk3188a_clk_init(struct device_node *np)
 			__func__);
 	}
 
+	/* limit i2s0_pre max rate */
+	clk1 = __clk_lookup("aclk_cpu_pre");
+	clk2 = __clk_lookup("i2s0_pre");
+	if (clk1 && clk2) {
+		rate = clk_get_rate(clk1);
+		clk_set_max_rate(clk2, rate);
+		clk_set_rate(clk2, rate);
+	}
+
 	rockchip_clk_protect_critical(rk3188_critical_clocks,
 				      ARRAY_SIZE(rk3188_critical_clocks));
 	rockchip_clk_of_add_provider(np, ctx);
-- 
1.7.9.5
