From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:29 -0700
Subject: [PATCH 12/21] usb: chipidea: msm: Keep device runtime enabled
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-13-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes the usb wrapper device is part of a power domain that
needs to stay on as long as the device is active. Let's get and
put the device in driver probe/remove so that we keep the power
domain powered as long as the device is attached. We can fine
tune this later to handle wakeup interrupts, etc. for finer grain
power management later, but this is necessary to make sure we can
keep accessing the device right now.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 520c85e701ef..430856ef1be3 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -80,6 +80,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get(&pdev->dev);
 
 	return 0;
 }
@@ -88,6 +89,7 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
 {
 	struct platform_device *plat_ci = platform_get_drvdata(pdev);
 
+	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	ci_hdrc_remove_device(plat_ci);
 
-- 
2.9.0.rc2.8.ga28705d
