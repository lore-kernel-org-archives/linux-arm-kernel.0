From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 14 Nov 2013 11:22:54 +0300
Subject: [patch] pinctrl: rockchip: missing unlock on error in
 rockchip_set_pull()
Message-ID: <20131114082254.GE8150@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to unlock here before returning -EINVAL.

Fixes: 6ca5274d1d12 ('pinctrl: rockchip: add rk3188 specifics')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index e939c28..bfd1824 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -504,6 +504,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 			data |= (3 << bit);
 			break;
 		default:
+			spin_unlock_irqrestore(&bank->slock, flags);
 			dev_err(info->dev, "unsupported pull setting %d\n",
 				pull);
 			return -EINVAL;
