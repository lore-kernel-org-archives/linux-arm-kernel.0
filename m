From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 25 Jan 2018 15:20:09 -0600
Subject: [PATCH] pinctrl: msm: allow the gpio base to be configurable
Message-ID: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an integer to the msm_pinctrl_soc_data struct that pinctrl-msm
client drivers can use to specify the gpio base.  This is useful
if the client driver wants to register multiple TLMM devices, because
each one needs a distinct base.

pinctrl-msm currently sets the base to 0, which ensures that GPIOs
of the first TLMM are numbered 0..n-1.  It could specify -1 as the
base, which would tell gpiolib to choose a unique base, but this
has the side-effect of choosing a non-zero base for all TLMMs:

gpiochip_find_base: found new base at 437
gpio gpiochip0: (QCOM8002:00): added GPIO chardev (254:0)
gpiochip_setup_dev: registered GPIOs 437 to 511 on device: gpiochip0 (QCOM8002:00)
gpio gpiochip0: (QCOM8002:00): created GPIO range 0->74 ==> QCOM8002:00 PIN 0->74
gpiochip_find_base: found new base at 362
gpio gpiochip1: (QCOM8002:01): added GPIO chardev (254:1)
gpiochip_setup_dev: registered GPIOs 362 to 436 on device: gpiochip1 (QCOM8002:01)
gpio gpiochip1: (QCOM8002:01): created GPIO range 0->74 ==> QCOM8002:01 PIN 0->74

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index b7b6849625ec..4dc76e15bd14 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -901,7 +901,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 		return -EINVAL;
 
 	chip = &pctrl->chip;
-	chip->base = 0;
+	chip->base = pctrl->soc->base;
 	chip->ngpio = ngpio;
 	chip->label = dev_name(pctrl->dev);
 	chip->parent = pctrl->dev;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 9b9feea540ff..cab26f99011d 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -107,6 +107,7 @@ struct msm_pingroup {
  * @ngroups:	    The numbmer of entries in @groups.
  * @ngpio:	    The number of pingroups the driver should expose as GPIOs.
  * @pull_no_keeper: The SoC does not support keeper bias.
+ * @base:	    The base GPIO (normally 0 if only one TLMM block)
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -117,6 +118,7 @@ struct msm_pinctrl_soc_data {
 	unsigned ngroups;
 	unsigned ngpios;
 	bool pull_no_keeper;
+	int base;
 };
 
 int msm_pinctrl_probe(struct platform_device *pdev,
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
