From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 5 Nov 2015 17:17:15 +0100
Subject: [PATCH] pinctrl: Delete unnecessary checks before the function call
 "pinctrl_unregister"
In-Reply-To: <5317A59D.4@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Message-ID: <563B810B.6050401@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Nov 2015 17:10:22 +0100

The pinctrl_unregister() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c | 3 +--
 drivers/pinctrl/pinctrl-single.c          | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
index 12a48f4..663ad0a 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
@@ -638,8 +638,7 @@ static int cygnus_gpio_register_pinconf(struct cygnus_gpio *chip)
 
 static void cygnus_gpio_unregister_pinconf(struct cygnus_gpio *chip)
 {
-	if (chip->pctl)
-		pinctrl_unregister(chip->pctl);
+	pinctrl_unregister(chip->pctl);
 }
 
 struct cygnus_gpio_data {
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index ef04b96..d24e5f1 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1484,10 +1484,7 @@ static void pcs_irq_free(struct pcs_device *pcs)
 static void pcs_free_resources(struct pcs_device *pcs)
 {
 	pcs_irq_free(pcs);
-
-	if (pcs->pctl)
-		pinctrl_unregister(pcs->pctl);
-
+	pinctrl_unregister(pcs->pctl);
 	pcs_free_funcs(pcs);
 	pcs_free_pingroups(pcs);
 }
-- 
2.6.2
