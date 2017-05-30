From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 30 May 2017 14:28:47 +0200
Subject: [PATCH 1/2] gpio: mvebu: fix blink counter register selection
Message-ID: <20170530122848.2803-1-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The blink counter A was always selected because 0 was forced in the
blink select counter register.
The variable 'set' was obviously there to be used as the register value,
selecting the B counter when id==1 and A counter when id==0.

Tested on clearfog-pro (Marvell 88F6828)

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/gpio/gpio-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 19a92efabbef..cdef2c78cb3b 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -747,7 +747,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		set = U32_MAX;
 	else
 		return -EINVAL;
-	writel_relaxed(0, mvebu_gpioreg_blink_counter_select(mvchip));
+	writel_relaxed(set, mvebu_gpioreg_blink_counter_select(mvchip));
 
 	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
 	if (!mvpwm)
