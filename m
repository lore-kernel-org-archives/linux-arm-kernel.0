From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:15 +0100
Subject: [PATCH 13/14] usb: host: ehci-st: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-13-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional_shared
unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ehci-st.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index be4a2788fc582..12e803d2c98df 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -210,18 +210,14 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 		devm_reset_control_get_optional_shared(&dev->dev, "power");
 	if (IS_ERR(priv->pwr)) {
 		err = PTR_ERR(priv->pwr);
-		if (err == -EPROBE_DEFER)
-			goto err_put_clks;
-		priv->pwr = NULL;
+		goto err_put_clks;
 	}
 
 	priv->rst =
 		devm_reset_control_get_optional_shared(&dev->dev, "softreset");
 	if (IS_ERR(priv->rst)) {
 		err = PTR_ERR(priv->rst);
-		if (err == -EPROBE_DEFER)
-			goto err_put_clks;
-		priv->rst = NULL;
+		goto err_put_clks;
 	}
 
 	if (pdata->power_on) {
-- 
2.11.0
