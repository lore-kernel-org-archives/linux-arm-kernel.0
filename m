From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 26 Feb 2016 11:43:42 +0800
Subject: [PATCH v2 0/5] thermal: hisilicon: enable power allocator for Hi6220
Message-ID: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi6220 has octa-core so it has quite high power consumption when run
benchmark and introduces high temperature for SoC. So need enable
thermal governor to control temperature and also cannot hurt much for
performance after impose cooling operations on CPU.

This patch series is to enable power allocator for Hi6220. Patch 1 is to
change "hysteresis" as optional property for trip points, so when enable
power allocator governor we can ignore this property.

During profiling also found two issues for thermal sensor's driver. The
power allocator just uses only one sensor, so patch 2 is to fix sensor
driver to let it can initialize driver successfully with only enabling
one sensor; patch 3 is to dismiss warning of IRQ imbalance enabling.

After profiling on Hikey, the power model has been simplized with only
dynamic coefficient, and now it's convienence to pass it from CPU node.
So patch 4 and 5 bind sensor and pass power model parameters.

This patch series have been tested on 96boards Hikey.

Changes from v1:
* According to Javi's review, removed unecessary properties for DT
* Add patch 1 for change "hysteresis" as optional property
* Add patch 3 to fix IRQ imbalance enabling issue


Leo Yan (5):
  thermal: change "hysteresis" as optional property
  thermal: hisilicon: support to use any sensor
  thermal: hisilicon: fix IRQ imbalance enabling
  arm64: dts: register Hi6220's thermal sensor
  arm64: dts: register Hi6220's thermal zone for power allocator

 .../devicetree/bindings/thermal/thermal.txt        |  9 ++---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 42 ++++++++++++++++++++++
 drivers/thermal/hisi_thermal.c                     | 40 ++++++++++++---------
 drivers/thermal/of-thermal.c                       |  9 +++--
 4 files changed, 75 insertions(+), 25 deletions(-)

-- 
1.9.1
