From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 10 Dec 2012 12:39:18 +0530
Subject: [PATCH 9/9] memory: emif: use default custom config parameter.
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1355123358-5273-10-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ambresh K <ambresh@ti.com>

In-case of low power mode selected and custom parameters
are not configured, then use default configuration.

Signed-off-by: Ambresh K <ambresh@ti.com>
---
 drivers/memory/emif.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 70f6e0f..e58fde4 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -722,9 +722,13 @@ static u32 get_pwr_mgmt_ctrl(u32 freq, struct emif_data *emif, u32 ip_rev)
 
 	if (cust_cfgs && (cust_cfgs->mask & EMIF_CUSTOM_CONFIG_LPMODE)) {
 		lpmode		= cust_cfgs->lpmode;
-		timeout_perf	= cust_cfgs->lpmode_timeout_performance;
-		timeout_pwr	= cust_cfgs->lpmode_timeout_power;
-		freq_threshold  = cust_cfgs->lpmode_freq_threshold;
+
+		if (cust_cfgs->lpmode_timeout_performance)
+			timeout_perf	= cust_cfgs->lpmode_timeout_performance;
+		if (cust_cfgs->lpmode_timeout_power)
+			timeout_pwr	= cust_cfgs->lpmode_timeout_power;
+		if (cust_cfgs->lpmode_freq_threshold)
+			freq_threshold  = cust_cfgs->lpmode_freq_threshold;
 	}
 
 	/* Timeout based on DDR frequency */
-- 
1.7.9.5
