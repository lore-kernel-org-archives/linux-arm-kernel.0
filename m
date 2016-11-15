From: wulf@rock-chips.com (William Wu)
Date: Tue, 15 Nov 2016 11:54:07 +0800
Subject: [PATCH v4 2/2] phy: rockchip-inno-usb2: correct 480MHz output clock
 stable time
In-Reply-To: <1479182047-3399-1-git-send-email-wulf@rock-chips.com>
References: <1479182047-3399-1-git-send-email-wulf@rock-chips.com>
Message-ID: <1479182047-3399-3-git-send-email-wulf@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We found that the system crashed due to 480MHz output clock of
USB2 PHY was unstable after clock had been enabled by gpu module.

Theoretically, 1 millisecond is a critical value for 480MHz
output clock stable time, so we try to change the delay time
to 1.2 millisecond to avoid this issue.

And the commit ed907fb1d7c3 ("phy: rockchip-inno-usb2: correct
clk_ops callback") used prepare callbacks instead of enable
callbacks to support gate a clk if the operation may sleep. So
we can switch from delay to sleep functions.

Also fix a spelling error from "waitting" to "waiting".

Signed-off-by: William Wu <wulf@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v4:
- add Reviewed-by and fix a spelling error

Changes in v3:
- None

Changes in v2:
- None

 drivers/phy/phy-rockchip-inno-usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index 365e077..5d922fc 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -165,8 +165,8 @@ static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
 		if (ret)
 			return ret;
 
-		/* waitting for the clk become stable */
-		mdelay(1);
+		/* waiting for the clk become stable */
+		usleep_range(1200, 1300);
 	}
 
 	return 0;
-- 
2.0.0
