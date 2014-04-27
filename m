From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 27 Apr 2014 14:28:55 +0100
Subject: [PATCH 2/5] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
In-Reply-To: <20140427132312.GC26756@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeP8Z-0000Uk-Uu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pm_genpd_remove_device() should only be called with valid and present
pm domain.  There are circumstances where we may end up with something
that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
stuff.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ea91ea0e137b..9d8faecc060c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1531,7 +1531,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
+	if (!pm_genpd_present(genpd) || IS_ERR_OR_NULL(dev)
 	    ||  IS_ERR_OR_NULL(dev->pm_domain)
 	    ||  pd_to_genpd(dev->pm_domain) != genpd)
 		return -EINVAL;
-- 
1.8.3.1
