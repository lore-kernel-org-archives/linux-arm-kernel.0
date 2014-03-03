From: rogerq@ti.com (Roger Quadros)
Date: Mon, 3 Mar 2014 17:07:32 +0200
Subject: [PATCH 10/12] phy: ti-pipe3: Fix suspend/resume and module reload
In-Reply-To: <1393859254-10937-1-git-send-email-rogerq@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Message-ID: <1393859254-10937-11-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to Errata i783, SATA breaks if its DPLL is idled. The recommeded
workaround to issue a softreset to the SATA controller doesn't seem to
work. Here we just prevent SATA DPLL from Idling and hence avoid
the issue altogether.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-ti-pipe3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index d3c085a..611f7c3 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -238,6 +238,10 @@ static int ti_pipe3_exit(struct phy *x)
 	u32 val;
 	unsigned long timeout;
 
+	/* SATA DPLL can't be powered down due to Errata i783 */
+	if (of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-sata"))
+		return 0;
+
 	/* Put DPLL in IDLE mode */
 	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
 	val |= PLL_IDLE;
-- 
1.8.3.2
