From: hramrach@gmail.com (Michal Suchanek)
Date: 12 Aug 2015 13:29:31 -0000
Subject: [PATCH v3 1/3] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
In-Reply-To: <55CB3CD7.2050200@redhat.com>
References: <cover.1439381423.git.hramrach@gmail.com>
 <7f9c6f99b31702c02436ef3356b3ebffa4754260.1439381423.git.hramrach@gmail.com>
Message-ID: <bdcb7ce26f359b7fedbd8559eb275c324bfb52bb.1439386047.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 250ms timeout is too short.

On my system enabling the oclk takes under 50ms and disabling slightly
over 100ms when idle. Under load disabling the clock can take over
350ms.

This does not make mmc clock gating look like good option to have on
sunxi but the system should not crash with mmc clock gating enabled
nonetheless.

This patch sets the timeout to 750ms.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

---
v3
 - remove debug message
v2
 - fix formatting
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 4d3e1ff..a7b7a67 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
 
 static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 {
-	unsigned long expire = jiffies + msecs_to_jiffies(250);
+	unsigned long expire = jiffies + msecs_to_jiffies(750);
 	u32 rval;
 
 	rval = mmc_readl(host, REG_CLKCR);
-- 
2.1.4
