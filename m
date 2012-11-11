From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 11 Nov 2012 21:46:09 +0800
Subject: [PATCH RFT 2/2] pinctrl: dove: Checking valid config in
 dove_audio1_ctrl_set
In-Reply-To: <1352641495.3113.1.camel@phoenix>
References: <1352641495.3113.1.camel@phoenix>
Message-ID: <1352641569.3113.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the code checking valid config to dove_audio1_ctrl_set(), this ensures we
always set valid config. And then dove_audio1_ctrl_get() always returns correct
config.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/mvebu/pinctrl-dove.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index e5cc694..a393790 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -217,12 +217,6 @@ static int dove_audio1_ctrl_get(struct mvebu_mpp_ctrl *ctrl,
 	if (gcfg2 & DOVE_TWSI_OPTION3_GPIO)
 		*config |= BIT(0);
 
-	/* SSP/TWSI only if I2S1 not set*/
-	if ((*config & BIT(3)) == 0)
-		*config &= ~(BIT(2) | BIT(0));
-	/* TWSI only if SPDIFO not set*/
-	if ((*config & BIT(1)) == 0)
-		*config &= ~BIT(0);
 	return 0;
 }
 
@@ -234,6 +228,13 @@ static int dove_audio1_ctrl_set(struct mvebu_mpp_ctrl *ctrl,
 	unsigned long gmpp = readl(DOVE_MPP_GENERAL_VIRT_BASE);
 	unsigned long gcfg2 = readl(DOVE_GLOBAL_CONFIG_2);
 
+	/* SSP/TWSI only if I2S1 not set*/
+	if ((config & BIT(3)) == 0)
+		config &= ~(BIT(2) | BIT(0));
+	/* TWSI only if SPDIFO not set*/
+	if ((config & BIT(1)) == 0)
+		config &= ~BIT(0);
+
 	if (config & BIT(0))
 		gcfg2 |= DOVE_TWSI_OPTION3_GPIO;
 	else
-- 
1.7.9.5
