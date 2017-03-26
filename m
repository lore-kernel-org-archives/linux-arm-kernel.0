From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 22:41:49 +0800
Subject: [PATCH 0/5] Convert to use devm_*() for amba attached modules
Message-ID: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When review device driver modules which attach to amba bus, found
several modules are not using devm_*() apis to manage resource. As
result, some drivers have memory leakage or missing iomem unmapping
when rmmod module. And the code has many "goto" tags to handle
different failures.

So this patch series is to convert to use devm_*() for moudules which
are attached to amba bus to manage resource and get more robust and
neat code.

Patch 0003 "drivers/rtc/rtc-pl031.c: Convert to use devm_*()" has been
verified on 96boards Hikey. Other patches can pass building but have
not really tested on hardware.


Leo Yan (5):
  Input: ambakmi - Convert to use devm_*()
  drivers/rtc/rtc-pl030.c: Convert to use devm_*()
  drivers/rtc/rtc-pl031.c: Convert to use devm_*()
  vfio: platform: Convert to use devm_*()
  ALSA: AACI: Convert to use devm_ioremap_resource()

 drivers/input/serio/ambakmi.c     | 44 +++++++----------------------
 drivers/rtc/rtc-pl030.c           | 49 ++++++++------------------------
 drivers/rtc/rtc-pl031.c           | 59 ++++++++++-----------------------------
 drivers/vfio/platform/vfio_amba.c | 25 ++++++-----------
 sound/arm/aaci.c                  | 21 ++++----------
 5 files changed, 51 insertions(+), 147 deletions(-)

-- 
2.7.4
