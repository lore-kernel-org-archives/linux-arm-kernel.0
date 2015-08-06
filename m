From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  6 Aug 2015 08:49:07 -0500
Subject: [RFC PATCH 0/8] Add Analogix Core Display Port Driver
Message-ID: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
   Samsung exynos and Rockchip rk3288 almost share same dp controller,
so I split the common code out, then rk3288 and exynos can re-used the
same dp core driver. Cause I can't find the exact IP name of exynos dp
controller, so I decide to name dp core driver with "analogix" which I
find in rk3288 eDP TRM ;)

Beyond that, there are three light registers setting differents bewteen
exynos and rk3288.
1. RK3288 have five special pll resigters which not indicata in exynos
   dp controller.
2. The address of DP_PHY_PD(dp phy power manager register) are different
   between rk3288 and exynos.
3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
   register).

My series patches can be divider into two parts: One for spliting the
analogix_dp code from exynos dp driver. Another are trying to add rk3288
dp driver support.

Best regards,
- Yakir


Yakir Yang (8):
  drm: exynos/dp: fix code style
  drm: exynos/dp: convert to drm bridge mode
  drm: bridge: analogix_dp: split exynos dp driver to bridge dir
  drm: rockchip/dp: add rockchip platform dp driver
  drm: bridge/analogix_dp: add platform device type support
  drm: bridge: analogix_dp: add some rk3288 special registers setting
  drm: bridge: analogix_dp: try force hpd after plug in lookup failed
  drm: bridge/analogix_dp: expand the delay time for hpd detect

 drivers/gpu/drm/bridge/Kconfig                     |    5 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/analogix_dp_core.c          | 1397 +++++++++++++++++++
 drivers/gpu/drm/bridge/analogix_dp_core.h          |  287 ++++
 drivers/gpu/drm/bridge/analogix_dp_reg.c           | 1295 ++++++++++++++++++
 .../exynos_dp_reg.h => bridge/analogix_dp_reg.h}   |  272 ++--
 drivers/gpu/drm/exynos/Kconfig                     |    5 +-
 drivers/gpu/drm/exynos/Makefile                    |    2 +-
 drivers/gpu/drm/exynos/analogix_dp-exynos.c        |  241 ++++
 drivers/gpu/drm/exynos/exynos_dp_core.c            | 1416 --------------------
 drivers/gpu/drm/exynos/exynos_dp_core.h            |  282 ----
 drivers/gpu/drm/exynos/exynos_dp_reg.c             |  100 +-
 drivers/gpu/drm/rockchip/Kconfig                   |   10 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  420 ++++++
 include/drm/bridge/analogix_dp.h                   |   28 +
 16 files changed, 3880 insertions(+), 1882 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/analogix_dp_core.c
 create mode 100644 drivers/gpu/drm/bridge/analogix_dp_core.h
 create mode 100644 drivers/gpu/drm/bridge/analogix_dp_reg.c
 rename drivers/gpu/drm/{exynos/exynos_dp_reg.h => bridge/analogix_dp_reg.h} (62%)
 create mode 100644 drivers/gpu/drm/exynos/analogix_dp-exynos.c
 delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.c
 delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.h
 create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
 create mode 100644 include/drm/bridge/analogix_dp.h

-- 
2.1.2
