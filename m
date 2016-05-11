From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 14:49:53 +0200
Subject: [PATCH] phy: exynos-mipi-video: avoid uninitialized variable use
Message-ID: <1462971012-562097-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A rework of the exynos-mipi-video driver caused a warning
about the new __set_phy_state function potentially accessing
a variable before its initialization:

drivers/phy/phy-exynos-mipi-video.c: In function '__set_phy_state':
drivers/phy/phy-exynos-mipi-video.c:238:13: error: 'val' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  return val & data->resetn_val;
         ~~~~^~~~~~~~~~~~~~~~~~
drivers/phy/phy-exynos-mipi-video.c:235:6: note: 'val' was declared here
  u32 val;

The failure scenario here is the offset passed into a the
stub regmap_read() function that does not modify its output,
however regmap_read() can also fail for other reasons, so
adding error handling (in this case, returning zero from
is_running) seems the best solution.

Note that this warning showed up with the ARM s5pv210_defconfig,
indicating that we most likely want to either enable CONFIG_REGMAP
in that defconfig as well, or disable the phy-exynos-mipi-video
driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 97a3042f7616 ("phy: exynos-mipi-video: Rewrite handling of phy registers")
---
 drivers/phy/phy-exynos-mipi-video.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
index cc093ebfda94..8b851f718123 100644
--- a/drivers/phy/phy-exynos-mipi-video.c
+++ b/drivers/phy/phy-exynos-mipi-video.c
@@ -233,8 +233,12 @@ static inline int __is_running(const struct exynos_mipi_phy_desc *data,
 			struct exynos_mipi_video_phy *state)
 {
 	u32 val;
+	int ret;
+
+	ret = regmap_read(state->regmaps[data->resetn_map], data->resetn_reg, &val);
+	if (ret)
+		return 0;
 
-	regmap_read(state->regmaps[data->resetn_map], data->resetn_reg, &val);
 	return val & data->resetn_val;
 }
 
-- 
2.7.0
