From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sun, 29 Apr 2012 17:28:50 +0200
Subject: [PATCH 3/3] pwm-core: fix registration of several pwm
In-Reply-To: <1335713330-6488-1-git-send-email-eric@eukrea.com>
References: <1335713330-6488-1-git-send-email-eric@eukrea.com>
Message-ID: <1335713330-6488-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* after a pwm is allocated using alloc_pwms, ret contains the number
of the pwm and is returned by pwmchip_add so the calling driver
(pwm-imx in my case) fails with the following log :
mxc_pwm: probe of mxc_pwm.1 failed with error 1
mxc_pwm: probe of mxc_pwm.2 failed with error 2
mxc_pwm: probe of mxc_pwm.3 failed with error 3

* this patch fix error handling in pwmchip_add

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/pwm/core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a7be0bc..d3438e4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -216,8 +216,10 @@ int pwmchip_add(struct pwm_chip *chip)
 		goto out;
 
 	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
+	if (!chip->pwms) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	chip->base = ret;
 
@@ -239,6 +241,7 @@ int pwmchip_add(struct pwm_chip *chip)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
+	ret = 0;
 out:
 	mutex_unlock(&pwm_lock);
 	return ret;
-- 
1.7.7.6
