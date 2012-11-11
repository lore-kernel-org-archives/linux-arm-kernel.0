From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 11 Nov 2012 21:44:55 +0800
Subject: [PATCH RFT 1/2] pinctrl: dove: Fix dove_audio1_ctrl_set when
 BIT(0|1|2|3) of config is clear
Message-ID: <1352641495.3113.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation in dove_audio1_ctrl_set() does not clear corresponding
register bit if BIT(0|1|2|3) of config is clear. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I don't have this hardware.
I'd appreciate if someone can review and test this patch.

This resend also CC Sebastian Hesselbarth and linux-arm-kernel.
Thanks,
Axel
 drivers/pinctrl/mvebu/pinctrl-dove.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index ffe74b2..e5cc694 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -236,12 +236,23 @@ static int dove_audio1_ctrl_set(struct mvebu_mpp_ctrl *ctrl,
 
 	if (config & BIT(0))
 		gcfg2 |= DOVE_TWSI_OPTION3_GPIO;
+	else
+		gcfg2 &= ~DOVE_TWSI_OPTION3_GPIO;
+
 	if (config & BIT(1))
 		gmpp |= DOVE_AU1_SPDIFO_GPIO_EN;
+	else
+		gmpp &= ~DOVE_AU1_SPDIFO_GPIO_EN;
+
 	if (config & BIT(2))
 		sspc1 |= DOVE_SSP_ON_AU1;
+	else
+		sspc1 &= ~DOVE_SSP_ON_AU1;
+
 	if (config & BIT(3))
 		mpp4 |= DOVE_AU1_GPIO_SEL;
+	else
+		mpp4 &= ~DOVE_AU1_GPIO_SEL;
 
 	writel(mpp4, DOVE_MPP_CTRL4_VIRT_BASE);
 	writel(sspc1, DOVE_SSP_CTRL_STATUS_1);
-- 
1.7.9.5
