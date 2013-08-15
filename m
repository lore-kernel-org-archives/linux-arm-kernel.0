From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Aug 2013 21:31:15 +0200
Subject: [PATCH] pinctrl: nomadik: shut up a warning for flags
Message-ID: <1376595075-791-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq flags variable gets a warning like this after
commit bf4dae5ce1b95a5932e43036edcf3f1b324758c6
"pinctrl: nomadik: delete ancient pin control API":

In file included from include/linux/seqlock.h:29:0,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from
drivers/pinctrl/pinctrl-nomadik.c:14:
drivers/pinctrl/pinctrl-nomadik.c: In function 'nmk_pmx_enable':
include/linux/spinlock.h:348:122: warning:
'flags' may be used uninitialized in this function
[-Wmaybe-uninitialized]
  raw_spin_unlock_irqrestore(&lock->rlock, flags);
                                                   ^
drivers/pinctrl/pinctrl-nomadik.c:1515:16: note:
'flags' was declared here
  unsigned long flags;

The function is question was never changed but it appears
the semantic checker could previously determine that the code
path that would use the flags was going to either use it or
not, but now it can't for some reason. Just fix it up.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 89280bc..a8b8a53 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1512,7 +1512,7 @@ static int nmk_pmx_enable(struct pinctrl_dev *pctldev, unsigned function,
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 	const struct nmk_pingroup *g;
 	static unsigned int slpm[NUM_BANKS];
-	unsigned long flags;
+	unsigned long flags = 0;
 	bool glitch;
 	int ret = -EINVAL;
 	int i;
-- 
1.8.1.4
