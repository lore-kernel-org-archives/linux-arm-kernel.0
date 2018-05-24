From: robh@kernel.org (Rob Herring)
Date: Thu, 24 May 2018 12:50:24 -0500
Subject: [PATCH v2 8/8] PM / Domains: Stop deferring probe at the end of
 initcall
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Message-ID: <20180524175024.19874-9-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All PM domain drivers must be built-in (at least those using DT), so
there is no point deferring probe after initcalls are done. Continuing
to defer probe may prevent booting successfully even if managing PM
domains is not required. This can happen if the user failed to enable
the driver or if power-domains are added to a platform's DT, but there
is not yet a driver (e.g. a new DTB with an old kernel).

Call the driver core function driver_deferred_probe_check_init_done()
instead of just returning -EPROBE_DEFER to stop deferring probe when
initcalls are done.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1ea0e2502e8e..6398cf786e6a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2218,7 +2218,7 @@ int genpd_dev_pm_attach(struct device *dev)
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_init_done(dev, true);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-- 
2.17.0
