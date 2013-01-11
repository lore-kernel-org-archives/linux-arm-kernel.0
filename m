From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 13:12:55 +0000
Subject: [PATCH 07/18] power: ab8500_fg: balance IRQ enable
In-Reply-To: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357909986-9262-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rickard Andersson <rickard.andersson@stericsson.com>

In case of time out error IRQ needs to be disabled
otherwise we will get unbalanced enable/disable pairs.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
Reviewed-by: Jonas ABERG <jonas.aberg@stericsson.com>
---
 drivers/power/ab8500_fg.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 328717b..7cfc48a 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -745,6 +745,7 @@ int ab8500_fg_inst_curr_blocking(struct ab8500_fg *di)
 	dev_dbg(di->dev, "%s instant current: %d", __func__, res);
 	return res;
 fail:
+	disable_irq(di->irq);
 	mutex_unlock(&di->cc_lock);
 	return ret;
 }
-- 
1.7.9.5
