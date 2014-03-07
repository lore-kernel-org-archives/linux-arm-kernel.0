From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  6 Mar 2014 22:44:41 -0800
Subject: [PATCH 2/7] pinctrl: msm: Check for ngpios > MAX_NR_GPIO
In-Reply-To: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
References: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1394174686-8358-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fail the probe and print a warning if SoC specific drivers have
more GPIOs than there can be accounted for in the static bitmaps.
This should avoid silent corruption/failures in the future.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/pinctrl-msm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-msm.c b/drivers/pinctrl/pinctrl-msm.c
index ac7223dab4a3..19b0de89dc07 100644
--- a/drivers/pinctrl/pinctrl-msm.c
+++ b/drivers/pinctrl/pinctrl-msm.c
@@ -882,10 +882,14 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	int ret;
 	int i;
 	int r;
+	unsigned ngpio = pctrl->soc->ngpios;
+
+	if (WARN_ON(ngpio > MAX_NR_GPIO))
+		return -EINVAL;
 
 	chip = &pctrl->chip;
 	chip->base = 0;
-	chip->ngpio = pctrl->soc->ngpios;
+	chip->ngpio = ngpio;
 	chip->label = dev_name(pctrl->dev);
 	chip->dev = pctrl->dev;
 	chip->owner = THIS_MODULE;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
