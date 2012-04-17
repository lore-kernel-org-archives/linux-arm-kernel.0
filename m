From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 17 Apr 2012 15:00:45 +0800
Subject: [PATCH v2 1/2] pinctrl: show pin name when request pins
Message-ID: <1334646046-467-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Pin name is more useful to users.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

---
No changes since v1.

After change, when call pinctrl_get_*, the debug information becomes :
pinctrl-imx 20e0000.iomuxc: request pin 305 (MX6Q_PAD_SD4_CMD) for 219c000.usdhc
pinctrl-imx 20e0000.iomuxc: request pin 306 (MX6Q_PAD_SD4_CLK) for 219c000.usdhc
---
 drivers/pinctrl/pinmux.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index c494c37..fa0357b 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -88,8 +88,6 @@ static int pin_request(struct pinctrl_dev *pctldev,
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
 	int status = -EINVAL;
 
-	dev_dbg(pctldev->dev, "request pin %d for %s\n", pin, owner);
-
 	desc = pin_desc_get(pctldev, pin);
 	if (desc == NULL) {
 		dev_err(pctldev->dev,
@@ -97,6 +95,9 @@ static int pin_request(struct pinctrl_dev *pctldev,
 		goto out;
 	}
 
+	dev_dbg(pctldev->dev, "request pin %d (%s) for %s\n",
+		pin, desc->name, owner);
+
 	if (gpio_range) {
 		/* There's no need to support multiple GPIO requests */
 		if (desc->gpio_owner) {
-- 
1.7.0.4
