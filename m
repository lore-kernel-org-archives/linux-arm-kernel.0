From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 22 Nov 2011 09:24:53 +0100
Subject: [PATCH 3/7] spi/pl022: skip default configuration before suspending
Message-ID: <1321950293-4749-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>

The loading of the default configuration before suspending has
been in the driver since its inception, but it is not really
needed. Especially so since we take to all the trouble of
enabling and disabling power and clock just to do this. Let's
scrap this now.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use local dev pointer instead of copy/paste bug &adev->dev
---
 drivers/spi/spi-pl022.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0d0b165..b4038f9 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2310,11 +2310,6 @@ static int pl022_suspend(struct device *dev)
 		return status;
 	}
 
-	amba_vcore_enable(pl022->adev);
-	amba_pclk_enable(pl022->adev);
-	load_ssp_default_config(pl022);
-	amba_pclk_disable(pl022->adev);
-	amba_vcore_disable(pl022->adev);
 	dev_dbg(dev, "suspended\n");
 	return 0;
 }
-- 
1.7.3.2
