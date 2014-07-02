From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:34 +0100
Subject: [PATCH 02/12] mfd: ab8500-debugfs: Simplify invalid debugfs data
 checking
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noticed during a coding review, if we reorganised the checking a
little, we can rid the code of a pointless 'else'.  Whilst looking
for this particular code hunk I noticed another pointless 'else',
which I've subsequently fixed in this patch.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index e23fcba..f7f271c 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2503,14 +2503,14 @@ static ssize_t ab8500_gpadc_trig_timer_write(struct file *file,
 	if (err)
 		return err;
 
-	if (user_trig_timer <= 255) {
-		trig_timer = (u8) user_trig_timer;
-	} else {
-		dev_err(dev, "debugfs error input: "
-			"should be beetween 0 to 255\n");
+	if (user_trig_timer & ~0xFF) {
+		dev_err(dev,
+			"debugfs error input: should be beetween 0 to 255\n");
 		return -EINVAL;
 	}
 
+	trig_timer = (u8) user_trig_timer;
+
 	return count;
 }
 
@@ -2764,8 +2764,8 @@ static ssize_t show_irq(struct device *dev,
 	irq_index = name - irq_first;
 	if (irq_index >= num_irqs)
 		return -EINVAL;
-	else
-		return sprintf(buf, "%u\n", irq_count[irq_index]);
+
+	return sprintf(buf, "%u\n", irq_count[irq_index]);
 }
 
 static ssize_t ab8500_subscribe_write(struct file *file,
-- 
1.8.3.2
