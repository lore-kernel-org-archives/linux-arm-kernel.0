From: wulf@rock-chips.com (William Wu)
Date: Mon, 14 Nov 2016 15:01:51 +0800
Subject: [PATCH v2 2/2] phy: rockchip-inno-usb2: correct 480MHz output clock
 stable time
In-Reply-To: <1479106911-16049-1-git-send-email-wulf@rock-chips.com>
References: <1479106911-16049-1-git-send-email-wulf@rock-chips.com>
Message-ID: <1479106911-16049-3-git-send-email-wulf@rock-chips.com>
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

Signed-off-by: William Wu <wulf@rock-chips.com>
---
Changes in v2:
- use usleep_range() function instead of mdelay()

 drivers/phy/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index 365e077..578290b 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -166,7 +166,7 @@ static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
 			return ret;
 
 		/* waitting for the clk become stable */
-		mdelay(1);
+		usleep_range(1200);
 	}
 
 	return 0;
-- 
2.0.0
