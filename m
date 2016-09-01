From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 31 Aug 2016 17:40:25 -0700
Subject: [PATCH v3 11/22] usb: chipidea: msm: Mark device as runtime pm active
In-Reply-To: <20160901004036.23936-1-stephen.boyd@linaro.org>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
Message-ID: <20160901004036.23936-12-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're not properly marking the glue layer/wrapper device as
runtime active, so runtime PM believes that the hardware state is
inactive when we call pm_runtime_enable() in this driver. This
causes a problem when the glue layer has a power domain
associated with it, because runtime PM will go and disable the
power domain to match the 'inactive' state of the device. Let's
mark the device as active so that runtime PM doesn't improperly
power down this device when it's actually active.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 3889809fd0c4..89c1a02d69b5 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -80,6 +80,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, plat_ci);
 
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.9.0.rc2.8.ga28705d
