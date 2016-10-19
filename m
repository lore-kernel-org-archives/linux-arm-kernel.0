From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 19 Oct 2016 18:06:27 -0300
Subject: [PATCH 4/4] PM / devfreq: exynos-ppmu: Fix module autoload
In-Reply-To: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
References: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1476911187-11040-5-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/devfreq/event/exynos-ppmu.ko | grep alias
$

After this patch:

$ modinfo drivers/devfreq/event/exynos-ppmu.ko | grep alias
alias:          of:N*T*Csamsung,exynos-ppmu-v2C*
alias:          of:N*T*Csamsung,exynos-ppmu-v2
alias:          of:N*T*Csamsung,exynos-ppmuC*
alias:          of:N*T*Csamsung,exynos-ppmu

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/devfreq/event/exynos-ppmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index f55cf0eb2a66..a112034997eb 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -351,6 +351,7 @@ static const struct of_device_id exynos_ppmu_id_match[] = {
 	},
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, exynos_ppmu_id_match);
 
 static struct devfreq_event_ops *exynos_bus_get_ops(struct device_node *np)
 {
-- 
2.7.4
