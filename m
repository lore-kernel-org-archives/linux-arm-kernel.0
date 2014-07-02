From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:39 +0100
Subject: [PATCH 07/12] mfd: 88pm805: msleep(1ms ~ 20ms) may not do what the
 caller intends
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code has been working since 2012, as limiting the time between
1ms and 3ms is unlikely to do any harm.

Soothes checkpatch warning:

  WARNING: msleep < 20ms can sleep for up to 20ms;
      see Documentation/timers/timers-howto.txt
  #161: FILE: drivers/mfd/88pm805.c:161:
  +	msleep(1);

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/88pm805.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index 64751c2..e9d5064 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -158,7 +158,7 @@ static int device_irq_init_805(struct pm80x_chip *chip)
 	 * PM805_INT_STATUS is under 32K clock domain, so need to
 	 * add proper delay before the next I2C register access.
 	 */
-	msleep(1);
+	usleep_range(1000, 3000);
 
 	if (ret < 0)
 		goto out;
-- 
1.8.3.2
