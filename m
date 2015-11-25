From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 Nov 2015 15:59:34 +0800
Subject: [PATCH 2/5] thermal: rockchip: fix a impossible condition caused by
 the warning
In-Reply-To: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
References: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1448438377-29203-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the Dan report the smatch check the thermal driver warning:
drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =>
(s32min-s32max > s32max)'

Since the Temperature is currently represented as int not long in
the thermal driver.

Fixes: commit 437df2172e8d
("thermal: rockchip: consistently use int for temperatures")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 85a7930..ab236a1 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -548,7 +548,7 @@ static int rockchip_configure_from_dt(struct device *dev,
 		thermal->tshut_temp = shut_temp;
 	}
 
-	if (thermal->tshut_temp > INT_MAX) {
+	if (!(thermal->tshut_temp < INT_MAX)) {
 		dev_err(dev, "Invalid tshut temperature specified: %d\n",
 			thermal->tshut_temp);
 		return -ERANGE;
-- 
1.9.1
