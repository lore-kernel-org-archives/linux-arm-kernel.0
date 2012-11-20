From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 20 Nov 2012 15:04:31 +0100
Subject: [PATCH 3/7] pinctrl: make range registration defer properly
Message-ID: <1353420271-18029-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes the pinctrl_find_and_add_gpio_range() return
-EPROBE_DEFER if the range hosting pin controller cannot be
located. We may assume that the common case for why adding a
range fails is that the targe pin controller device has not
probed yet.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 15f5ac8..33af811 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -350,8 +350,13 @@ struct pinctrl_dev *pinctrl_find_and_add_gpio_range(const char *devname,
 {
 	struct pinctrl_dev *pctldev = get_pinctrl_dev_from_devname(devname);
 
+	/*
+	 * If we can't find this device, let's assume that is because
+	 * it has not probed yet, so the driver trying to register this
+	 * range need to defer probing.
+	 */
 	if (!pctldev)
-		return NULL;
+		return ERR_PTR(-EPROBE_DEFER);
 
 	pinctrl_add_gpio_range(pctldev, range);
 	return pctldev;
-- 
1.7.11.3
