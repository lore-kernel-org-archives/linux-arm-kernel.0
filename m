From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 19 Oct 2016 18:06:25 -0300
Subject: [PATCH 2/4] PM / devfreq: exynos-nocp: Fix module autoload
In-Reply-To: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
References: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1476911187-11040-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/devfreq/event/exynos-nocp.ko | grep alias
$

After this patch:

$ modinfo drivers/devfreq/event/exynos-nocp.ko | grep alias
alias:          of:N*T*Csamsung,exynos5420-nocpC*
alias:          of:N*T*Csamsung,exynos5420-nocp

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/devfreq/event/exynos-nocp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 49e712aca0c1..5c3e7b11e8a6 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -190,6 +190,7 @@ static const struct of_device_id exynos_nocp_id_match[] = {
 	{ .compatible = "samsung,exynos5420-nocp", },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, exynos_nocp_id_match);
 
 static struct regmap_config exynos_nocp_regmap_config = {
 	.reg_bits = 32,
-- 
2.7.4
