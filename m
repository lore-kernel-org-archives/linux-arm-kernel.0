From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun,  5 Feb 2017 15:58:49 +0000
Subject: [PATCH -next v2] pinctrl: samsung: Fix return value check in
 samsung_pinctrl_get_soc_data()
In-Reply-To: <20170125140321.23911-1-weiyj.lk@gmail.com>
References: <20170125140321.23911-1-weiyj.lk@gmail.com>
Message-ID: <20170205155849.4362-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). Fix by using devm_ioremap_resource instead of devm_ioremap.

Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple
IORESOURCE_MEM for one pin-bank")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: use devm_ioremap_resource instead of devm_ioremap
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index d79eada..6dec061 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -988,10 +988,9 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 
 	for (i = 0; i < ctrl->nr_ext_resources + 1; i++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		virt_base[i] = devm_ioremap(&pdev->dev, res->start,
-						resource_size(res));
+		virt_base[i] = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(virt_base[i]))
-			return ERR_PTR(-EIO);
+			return ERR_CAST(virt_base[i]);
 	}
 
 	bank = d->pin_banks;
