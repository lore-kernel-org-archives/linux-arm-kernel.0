From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 Jul 2012 14:06:04 +0100
Subject: [PATCH 1/9] pinctrl: pinctrl-nomadik: Fix possible memory leak
In-Reply-To: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1341493572-29735-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the Nomadik Pin Control driver is continuously bound and unbound
from the same device a number of times the kzalloc() will leak
memory. Replacing it with devm_kzalloc() will ensure memory is
freed automatically in the event of failure and unbinding.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 3e7e47d..af0389f 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1194,7 +1194,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	}
 
 	if (np) {
-		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+		pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
-- 
1.7.9.5
