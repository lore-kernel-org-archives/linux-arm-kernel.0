From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 23 Dec 2015 11:37:19 +0100
Subject: [PATCH] pinctrl: nsp-gpio: fix type of iterator
In-Reply-To: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1450867041-729-2-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Iterator i declared as unsigned is always non-negative so the
loop will never end.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index 34648f6..ad5b04c 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -439,7 +439,8 @@ static int nsp_gpio_set_strength(struct nsp_gpio *chip, unsigned gpio,
 static int nsp_gpio_get_strength(struct nsp_gpio *chip, unsigned gpio,
 				 u16 *strength)
 {
-	unsigned int i, offset, shift;
+	unsigned int offset, shift;
+	int i;
 	u32 val;
 	unsigned long flags;
 
-- 
1.9.1
