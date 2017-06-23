From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 22 Jun 2017 18:08:37 -0700
Subject: [RFC 2/2] soc: bcm: brcmstb: PM: Implement target_state callback
In-Reply-To: <20170623010837.11199-1-f.fainelli@gmail.com>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <20170623010837.11199-1-f.fainelli@gmail.com>
Message-ID: <20170623010837.11199-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a target_state callback implementation which just returns the
suspend_state_t the system is about to enter. Broadcom STB drivers can
utilize platform_suspend_target_state() to retrieve that and take
appropriate actions (e.g: full vs. partial re-initialization).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 4b7e6c297b23..7d4695734093 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -104,6 +104,7 @@ struct brcmstb_pm_control {
 	u32 phy_b_standby_ctrl_offs;
 	bool needs_ddr_pad;
 	struct platform_device *pdev;
+	suspend_state_t pm_state;
 };
 
 enum bsp_initiate_command {
@@ -547,9 +548,23 @@ static int brcmstb_pm_valid(suspend_state_t state)
 	}
 }
 
+static int brcmstb_pm_begin(suspend_state_t state)
+{
+	ctrl.pm_state = state;
+
+	return 0;
+}
+
+static int brcmstb_target_state(void)
+{
+	return ctrl.pm_state;
+}
+
 static const struct platform_suspend_ops brcmstb_pm_ops = {
+	.begin		= brcmstb_pm_begin,
 	.enter		= brcmstb_pm_enter,
 	.valid		= brcmstb_pm_valid,
+	.target_state	= brcmstb_target_state,
 };
 
 static const struct of_device_id aon_ctrl_dt_ids[] = {
-- 
2.9.3
