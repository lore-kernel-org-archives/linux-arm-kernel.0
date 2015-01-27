From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Jan 2015 21:13:45 +0100
Subject: [PATCH 8/8] PM / Domains: Handle errors from genpd's ->attach_dev()
 callback
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1422389625-11730-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The optional genpd's ->attach_dev() callback is invoked from
__pm_genpd_add_device(). Let's add error handling from the response
from this callback and propagate the error code.

When __pm_genpd_add_device() is invoked through the generic OF-based PM
domain look-up path, the device is being probed. Returning an error
will mean the device won't be attached to its PM domain. Errors of
-EPROBE_DEFER get special treatment and is propagated to the driver
core.

Therefore this change also enables the ->attach_dev() callback to
be able to request for a deferred probe sequence.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0fd5ee1..ba4abbe 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1467,8 +1467,9 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		goto out;
 	}
 
-	if (genpd->attach_dev)
-		genpd->attach_dev(genpd, dev);
+	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
+	if (ret)
+		goto out;
 
 	genpd->device_count++;
 	genpd->max_off_time_changed = true;
-- 
1.9.1
