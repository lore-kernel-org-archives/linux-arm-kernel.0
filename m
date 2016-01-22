From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Fri, 22 Jan 2016 16:40:24 +0800
Subject: [RFC PATCH 0/5] Add support for Mediatek SVS engine
Message-ID: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset tries to add support for Mediatek SVS engine.

The SVS (Smart Voltage Scaling) engine is a piece of hardware which is
used to caculate optimized voltage values of several power domains, e.g.
CPU clusters, according to chip process corner, temperatures, and other
factors. Then DVFS driver could apply those optimized voltage values to
reduce power consumption. This engine takes calibration data stored in
on-chip E-Fuse device as configuration input during initialization. Once
the initialization is done, SVS engine issues interrupts according to
temerature changes of power domains to notify DVFS driver to get
calculated voltage values.

The configuration registers of SVS engine are shared with Mediatek
thermal controller, and those registers are banked for different power
domains. In addition, the SVS engine also needs some information from
Mediatek thermal controller, e.g. the temperature of a specific power
domain, part of the thermal calibration data. Therefore the support for
SVS engine is integrated with Mediatek thermal controller driver.

Also, for platform specific requirement, to make SVS engine work
correctly, the initialization of SVS engine should be later then
Mediatek thermal controller, and prior to mt8173-cpufreq driver. Hence,
the platform device registration code of mt8173-cpufreq is removed here
after SVS initialization is done or skipped to ensure the platform
specific initialization flow.

The functionality of SVS engine is optional for Mediatek thermal
controller. If the required resources of SVS engine is absent or SVS
failed during initialization stage, the SVS control flow will be
skipped and the thermal controller will function normally.

This patchset relies heavily on the runtime voltage adjustment
mechanism of OPP introduced by Stephen Boyd's previous work[1]. And it
also depends on other MT8173 device drivers that are still under
reviewing and not yet merged, e.g. Mediatek thermal controller support
[2], Mediatek EFUSE driver[3].

CC: Stephen Boyd <sboyd@codeaurora.org>

[1] https://lkml.org/lkml/2015/9/18/833
[2] https://lkml.org/lkml/2015/11/30/239
[3] https://lkml.org/lkml/2015/11/19/169

Pi-Cheng Chen (5):
  thermal: MT8173: Replace mutex with spinlock
  cpufreq: mt8173: Remove platform device registration code
  dt-bindings: thermal: Add optional properties of Mediatek thermal
    controller
  PM / AVS: thermal: MT8173: Introduce support for SVS engine
  cpufreq: mt8173: Add notifier to handle OPP voltage adjustment

 .../bindings/thermal/mediatek-thermal.txt          |  23 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |  68 +-
 drivers/thermal/mtk_thermal.c                      | 727 ++++++++++++++++++++-
 3 files changed, 782 insertions(+), 36 deletions(-)

-- 
1.9.1
