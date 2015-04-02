From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Apr 2015 17:34:13 +0200
Subject: [PATCH 4/4] clk: rockchip: enable CLK_DEFER_ORPHAN for all branches
In-Reply-To: <1427988853-9549-1-git-send-email-heiko@sntech.de>
References: <1427988853-9549-1-git-send-email-heiko@sntech.de>
Message-ID: <1427988853-9549-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Rockchip drivers should handle deferentials correctly and on all boards
we have the situation that some clock sources are generated off-soc by an
external i2c component (like the xin32k feeding for example the sclk_tsadc
on rk3288). So some clocks are always orphans until the i2c drivers are
probed.
So add the new CLK_DEFER_ORPHAN flag for all our clock branches to generate
correct deferals for this timespan.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 20e05bb..5bb5fa6 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -220,6 +220,9 @@ void __init rockchip_clk_register_branches(
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		flags = list->flags;
 
+		/* defer clk_get on orphan clocks */
+		flags |= CLK_DEFER_ORPHAN;
+
 		/* catch simple muxes */
 		switch (list->branch_type) {
 		case branch_mux:
-- 
2.1.4
