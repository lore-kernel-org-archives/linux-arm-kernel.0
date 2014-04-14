From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Apr 2014 15:33:42 -0600
Subject: [PATCH 4/4] pinctrl: tegra: print better error messages
In-Reply-To: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1397511222-28533-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

When an attempt is made to configure an unsupported option on a pin,
print the DT property name of that option, so it's easier to debug
what the problem is.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/pinctrl-tegra.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index 0faa09200781..2d43bff74f59 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -413,10 +413,21 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
 	}
 
 	if (*reg < 0 || *bit > 31) {
-		if (report_err)
+		if (report_err) {
+			const char *prop = "unknown";
+			int i;
+
+			for (i = 0; i < ARRAY_SIZE(cfg_params); i++) {
+				if (cfg_params[i].param == param) {
+					prop = cfg_params[i].property;
+					break;
+				}
+			}
+
 			dev_err(pmx->dev,
-				"Config param %04x not supported on group %s\n",
-				param, g->name);
+				"Config param %04x (%s) not supported on group %s\n",
+				param, prop, g->name);
+		}
 		return -ENOTSUPP;
 	}
 
-- 
1.8.1.5
