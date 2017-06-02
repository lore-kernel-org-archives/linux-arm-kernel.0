From: frank.wang@rock-chips.com (Frank Wang)
Date: Fri,  2 Jun 2017 11:20:24 +0800
Subject: [PATCH v2 2/4] phy: rockchip-inno-usb2: increase otg sm work first
 schedule time
In-Reply-To: <1496373626-27856-1-git-send-email-frank.wang@rock-chips.com>
References: <1496373626-27856-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1496373626-27856-3-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: William Wu <william.wu@rock-chips.com>

In rockchip-inno-usb2 phy driver, we use otg_sm_work to
dynamically manage power consumption for phy otg-port.
If the otg-port works as peripheral mode and does not
communicate with usb host, we will suspend phy.

But once suspend phy, the phy no longer has any internal
clock running, include the utmi_clk which supplied for
usb controller. So if we suspend phy before usb controller
init, it will cause usb controller fail to initialize.

Specifically, without this patch, the observed order is:
 1. unplug usb cable
 2. start system, do dwc2 controller probe
 3. dwc2_lowlevel_hw_enable()
    - phy_init()
     - rockchip_usb2phy_init()
      - schedule otg_sm_work after 2s
        put phy in suspend, and close utmi_clk
 4. dwc2_hsotg_udc_start() - fail to initialize the usb core

Generally, dwc2_hsotg_udc_start() can be called within 5s
after start system on Rockchip platform, so we increase the
the first schedule delay time to 6s for otg_sm_work afer usb
controller calls phy_init(), this can make sure that the usb
controller completes initialization before phy enter suspend.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/phy/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index f12dc8d..d6e459d 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -421,7 +421,7 @@ static int rockchip_usb2phy_init(struct phy *phy)
 				goto out;
 
 			schedule_delayed_work(&rport->otg_sm_work,
-					      OTG_SCHEDULE_DELAY);
+					      OTG_SCHEDULE_DELAY * 3);
 		} else {
 			/* If OTG works in host only mode, do nothing. */
 			dev_dbg(&rport->phy->dev, "mode %d\n", rport->mode);
-- 
2.0.0
