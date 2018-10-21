From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Sun, 21 Oct 2018 22:00:31 +0200
Subject: [PATCH 5/5] pinctrl: pinctrl-at91-pio4: simplify getting .driver_data
In-Reply-To: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
Message-ID: <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/pinctrl/pinctrl-at91-pio4.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 5a850491a5cb..4ee135d7b883 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -868,8 +868,7 @@ static struct pinctrl_desc atmel_pinctrl_desc = {
 
 static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
+	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
 	int i, j;
 
 	/*
@@ -897,8 +896,7 @@ static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
 
 static int __maybe_unused atmel_pctrl_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
+	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
 	int i, j;
 
 	for (i = 0; i < atmel_pioctrl->nbanks; i++) {
-- 
2.19.0
