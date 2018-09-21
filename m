From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 21 Sep 2018 16:02:47 +0200
Subject: [RESEND PATCH] Revert "pwm: Set class for exported channels in sysfs"
Message-ID: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
regression with multiple pwm chip. It creates a new entry in
'/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
- 1st time export will create an entry in /sys/class/pwm/pwmX
- when another export happens on another pwmchip, it can't be created
(e.g. -EEXIST)

This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm):
- pmwX should be there: /sys/class/pwm/pwmchipN/pwmX

Example on stm32 (stm32429i-eval) platform:
$ ls /sys/class/pwm
pwmchip0 pwmchip4

$ cd /sys/class/pwm/pwmchip0/
$ echo 0 > export
$ ls /sys/class/pwm
pwm0 pwmchip0 pwmchip4

$ cd /sys/class/pwm/pwmchip4/
$ echo 0 > export
sysfs: cannot create duplicate filename '/class/pwm/pwm0'
...Exception stack follows...

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 7c71cdb..4726d43 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -263,7 +263,6 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->pwm = pwm;
 	mutex_init(&export->lock);
 
-	export->child.class = parent->class;
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
 	export->child.devt = MKDEV(0, 0);
-- 
1.9.1
