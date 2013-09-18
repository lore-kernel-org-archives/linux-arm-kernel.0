From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:27 +0100
Subject: [PATCH 30/41] usb: musb: ux500: Don't supply a con_id when requesting
 the clock
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-31-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we supply a con_id then the clock framework will search for that name
in MUSB's Device Tree node for the 'clock-names' property. If it's absent
the clock request will fail. However, if we don't supply the con_id then
clk_get() will call into clk_sys() which will use the device name to
search for the appropriate clock, which is much more natural than forcing
'usb'.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/musb/ux500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index fce71b6..5543b89 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -259,7 +259,7 @@ static int ux500_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	clk = clk_get(&pdev->dev, "usb");
+	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-- 
1.8.1.2
