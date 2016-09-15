From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 15 Sep 2016 12:43:41 +0200
Subject: [PATCH] soc: rockchip: power-domain: Handle errors from
 of_genpd_add_provider_onecell
Message-ID: <1473936221-9248-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was a bit surprising that the device was reported to have probed just
fine, but the provider hadn't been registered.

So handle any errors when registering the provider and fail the probe
accordingly.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Caesar Wang <wxt@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 7acd1517dd37..57e920128cb2 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -627,7 +627,11 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	of_genpd_add_provider_onecell(np, &pmu->genpd_data);
+	error = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
+	if (error) {
+		dev_err(dev, "failed to add provider: %d\n", error);
+		goto err_out;
+	}
 
 	return 0;
 
-- 
2.7.4
