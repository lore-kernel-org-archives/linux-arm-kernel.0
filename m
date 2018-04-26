From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 26 Apr 2018 10:53:00 +0200
Subject: [PATCH 01/11] PM / Domains: Fix error path during attach in genpd
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1524732790-2234-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the PM domain fails to be powered on in genpd_dev_pm_attach(), it
returns -EPROBE_DEFER, but keeping the device attached to its PM domain.
This leads to problems when the next attempt to attach is re-tried. More
precisely, in that situation an -EEXIST error code is returned, because the
device already has its PM domain pointer assigned, from the first attempt.

Now, because of the sloppy error handling by the existing callers of
dev_pm_domain_attach(), probing is allowed to continue when -EEXIST is
returned. However, in such case there are no guarantees that the PM domain
is powered on by genpd, which may lead to hangs when buses/drivers tried to
access their devices.

Let's fix this behaviour, simply by detaching the device when powering on
fails in genpd_dev_pm_attach().

Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1ea0e25..ef6cf3d5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2246,6 +2246,9 @@ int genpd_dev_pm_attach(struct device *dev)
 	genpd_lock(pd);
 	ret = genpd_power_on(pd, 0);
 	genpd_unlock(pd);
+
+	if (ret)
+		genpd_remove_device(pd, dev);
 out:
 	return ret ? -EPROBE_DEFER : 0;
 }
-- 
2.7.4
