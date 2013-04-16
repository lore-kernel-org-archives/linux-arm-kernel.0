From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 17 Apr 2013 00:29:05 +0200
Subject: [PATCH RESEND 2/2] pinctrl: samsung: Fix link error with
 CONFIG_PINCTRL_EXYNOS disabled
In-Reply-To: <30362001.FF4K7WsZvh@flatron>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <20130416163331.GP26958@opensource.wolfsonmicro.com>
 <30362001.FF4K7WsZvh@flatron>
Message-ID: <2934745.t3ZR6H9zHp@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f67faf487 added driver data for Exynos5250, which is available
only if CONFIG_PINCTRL_EXYNOS is enabled. However probably due to merge
error, the reference to this driver data structure was located outside
of relevant ifdef and compiled unconditionally, leading to link error
with CONFIG_PINCTRL_EXYNOS.

This patch fixes mentioned link error by moving driver data entry under
ifdef CONFIG_PINCTRL_EXYNOS.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index f95dd69..9763668 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -970,13 +970,13 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = (void *)exynos4210_pin_ctrl },
 	{ .compatible = "samsung,exynos4x12-pinctrl",
 		.data = (void *)exynos4x12_pin_ctrl },
+	{ .compatible = "samsung,exynos5250-pinctrl",
+		.data = (void *)exynos5250_pin_ctrl },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
 		.data = s3c64xx_pin_ctrl },
 #endif
-	{ .compatible = "samsung,exynos5250-pinctrl",
-		.data = (void *)exynos5250_pin_ctrl },
 	{},
 };
 MODULE_DEVICE_TABLE(of, samsung_pinctrl_dt_match);
-- 
1.8.1.5
