From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 10 Jan 2018 15:37:59 +0800
Subject: [PATCH v2 2/2] phy: rockchip-emmc: use regmap_read_poll_timeout to
 poll dllrdy
In-Reply-To: <1515569879-31808-1-git-send-email-wxt@rock-chips.com>
References: <1515569879-31808-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1515569879-31808-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Just use the API instead of open-coding it, no functional change
intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- As Brian commented on https://patchwork.kernel.org/patch/10139891/,
  changed the note and added to print error value with
  regmap_read_poll_timeout API.

 drivers/phy/rockchip/phy-rockchip-emmc.c | 33 +++++++++++---------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 574838f..343c623 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -79,6 +79,9 @@
 #define PHYCTRL_IS_CALDONE(x) \
 	((((x) >> PHYCTRL_CALDONE_SHIFT) & \
 	  PHYCTRL_CALDONE_MASK) == PHYCTRL_CALDONE_DONE)
+#define PHYCTRL_IS_DLLRDY(x) \
+	((((x) >> PHYCTRL_DLLRDY_SHIFT) & \
+	  PHYCTRL_DLLRDY_MASK) == PHYCTRL_DLLRDY_DONE)
 
 struct rockchip_emmc_phy {
 	unsigned int	reg_offset;
@@ -93,7 +96,6 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 	unsigned int dllrdy;
 	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
 	unsigned long rate;
-	unsigned long timeout;
 	int ret;
 
 	/*
@@ -217,28 +219,15 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 	 * NOTE: There appear to be corner cases where the DLL seems to take
 	 * extra long to lock for reasons that aren't understood.  In some
 	 * extreme cases we've seen it take up to over 10ms (!).  We'll be
-	 * generous and give it 50ms.  We still busy wait here because:
-	 * - In most cases it should be super fast.
-	 * - This is not called lots during normal operation so it shouldn't
-	 *   be a power or performance problem to busy wait.  We expect it
-	 *   only at boot / resume.  In both cases, eMMC is probably on the
-	 *   critical path so busy waiting a little extra time should be OK.
+	 * generous and give it 50ms.
 	 */
-	timeout = jiffies + msecs_to_jiffies(50);
-	do {
-		udelay(1);
-
-		regmap_read(rk_phy->reg_base,
-			rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
-			&dllrdy);
-		dllrdy = (dllrdy >> PHYCTRL_DLLRDY_SHIFT) & PHYCTRL_DLLRDY_MASK;
-		if (dllrdy == PHYCTRL_DLLRDY_DONE)
-			break;
-	} while (!time_after(jiffies, timeout));
-
-	if (dllrdy != PHYCTRL_DLLRDY_DONE) {
-		pr_err("rockchip_emmc_phy_power: dllrdy timeout.\n");
-		return -ETIMEDOUT;
+	ret = regmap_read_poll_timeout(rk_phy->reg_base,
+				       rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
+				       dllrdy, PHYCTRL_IS_DLLRDY(dllrdy),
+				       1, 50 * USEC_PER_MSEC);
+	if (ret) {
+		pr_err("%s: dllrdy timeout. ret=%d\n", __func__, ret);
+		return ret;
 	}
 
 	return 0;
-- 
2.7.4
