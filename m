From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  5 Aug 2017 05:35:55 +0800
Subject: [PATCH 2/2] mmc: sunxi: fix new timings mode on A64 EMMC (MMC2)
 controller
In-Reply-To: <20170804213555.6024-1-icenowy@aosc.io>
References: <20170804213555.6024-1-icenowy@aosc.io>
Message-ID: <20170804213555.6024-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The configuration struct of A64 EMMC(MMC2) compatible used to
have the needs_new_timings variable missing, which lead to NULL
pointer dereference now when trying to set up the old timings mode, as
the old timings mode doesn't exist at all on A64.

Fix this issue by adding this variable and setting it to true in
the configuration struct.

Fixes: 4fb3ce07eafa ("mmc: sunxi: Add EMMC (MMC2) controller compatible")

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mmc/host/sunxi-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 59aba93beffb..4ad643e37014 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1142,6 +1142,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.idma_des_size_bits = 13,
 	.clk_delays = NULL,
 	.can_calibrate = true,
+	.needs_new_timings = true,
 };
 
 static const struct of_device_id sunxi_mmc_of_match[] = {
-- 
2.13.0
