From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:50 +0900
Subject: [PATCH 3/6] ARM: shmobile: R-Mobile: Enable module clocks if
 !CONFIG_PM_RUNTIME
In-Reply-To: <cover.1419809198.git.horms+renesas@verge.net.au>
References: <cover.1419809198.git.horms+renesas@verge.net.au>
Message-ID: <64b0089e0c4867365b66973f3d844843e403d2a3.1419809198.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

If CONFIG_PM_RUNTIME is not set, the clocks must be enabled before the
devices can be used.

Currently these clocks are enabled by the !CONFIG_PM_RUNTIME version of
pm_clk_notify, activated by the hack in drivers/sh/pm_runtime.c, but
this will go away soon (at least for DT).

On detach, disabling the clocks is already handled by pm_clk_destroy().
On system suspend/resume, disabling/enabling clocks is already handled
from the genpd->dev_ops.{start,stop}() callbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 4ea458d..9b685a8 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -118,6 +118,14 @@ static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
 		goto fail;
 	}
 
+	if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
+		error = pm_clk_resume(dev);
+		if (error) {
+			dev_err(dev, "pm_clk_resume failed %d\n", error);
+			goto fail;
+		}
+	}
+
 	return 0;
 
 fail:
-- 
2.1.3
