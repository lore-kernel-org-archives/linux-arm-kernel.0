From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 26 Apr 2018 10:53:05 +0200
Subject: [PATCH 06/11] amba: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1524732790-2234-7-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228..79fcbff 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -243,7 +243,7 @@ static int amba_probe(struct device *dev)
 			break;
 
 		ret = dev_pm_domain_attach(dev, true);
-		if (ret == -EPROBE_DEFER)
+		if (ret)
 			break;
 
 		ret = amba_get_enable_pclk(pcdev);
@@ -370,7 +370,7 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	}
 
 	ret = dev_pm_domain_attach(&dev->dev, true);
-	if (ret == -EPROBE_DEFER) {
+	if (ret) {
 		iounmap(tmp);
 		goto err_release;
 	}
-- 
2.7.4
