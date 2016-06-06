From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 18:08:54 +0100
Subject: [PATCH 10/10] usb: host: ohci-st: Inform the reset framework that our
 reset line may be shared
In-Reply-To: <20160606170854.12407-1-lee.jones@linaro.org>
References: <20160606155655.10860-8-lee.jones@linaro.org>
 <20160606170854.12407-1-lee.jones@linaro.org>
Message-ID: <20160606170854.12407-3-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the STiH410 B2120 development board the ST EHCI IP shares its reset
line with the OHCI IP.  New functionality in the reset subsystems forces
consumers to be explicit when requesting shared/exclusive reset lines.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/ohci-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index acf2eb2..1f1f23c 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -188,13 +188,13 @@ static int st_ohci_platform_probe(struct platform_device *dev)
 		priv->clk48 = NULL;
 	}
 
-	priv->pwr = devm_reset_control_get_optional(&dev->dev, "power");
+	priv->pwr = devm_reset_control_get_optional_shared(&dev->dev, "power");
 	if (IS_ERR(priv->pwr)) {
 		err = PTR_ERR(priv->pwr);
 		goto err_put_clks;
 	}
 
-	priv->rst = devm_reset_control_get_optional(&dev->dev, "softreset");
+	priv->rst = devm_reset_control_get_optional_shared(&dev->dev, "softreset");
 	if (IS_ERR(priv->rst)) {
 		err = PTR_ERR(priv->rst);
 		goto err_put_clks;
-- 
2.8.3
