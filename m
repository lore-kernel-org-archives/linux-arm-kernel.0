From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 8 Jun 2012 21:33:12 +0800
Subject: [PATCH 1/1] pinctrl: pinctrl-imx: fix incorrect debug message of maps
Message-ID: <1339162392-24628-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

After create config map, the new_map pointer becomes point to
PIN_MAP_TYPE_CONFIGS_PIN map rather than PIN_MAP_TYPE_MUX_GROUP map any more.
Thus using new_map pointer to display the MUX_GROUP info is not correct.
Using map pointer instead to show the correct MUX_GROUP map info.
Original the debug message is:
imx6q-pinctrl 20e0000.iomuxc: maps: function Yp group MX6Q_PAD_SD3_CMD num 12
After fix it is:
imx6q-pinctrl 20e0000.iomuxc: maps: function usdhc3 group usdhc3grp-1 num 11

Reported-by: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinctrl-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index f6e7c67..d8fe1d8 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -193,7 +193,7 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	dev_dbg(pctldev->dev, "maps: function %s group %s num %d\n",
-		new_map->data.mux.function, new_map->data.mux.group, map_num);
+		(*map)->data.mux.function, (*map)->data.mux.group, map_num);
 
 	return 0;
 }
-- 
1.7.0.4
