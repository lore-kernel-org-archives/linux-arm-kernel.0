From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 12 Jul 2017 14:29:26 +0800
Subject: [PATCH 0/4] arm64: dts: rockchip: support mail and IPA thermal for
 rk3399
Message-ID: <1499840971-20392-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches supported the mail in devicetree and used the
thermal IPA by default.

Verified with rk3399 kevin board on my github
https://github.com/Caesar-github/rockchip/commits/gru/next-stable-chromeos
The kernel is based on Linus's master branch and Heiko's
v4.14-armsoc-tmp/dts64 branch. ( The Linux version 4.12.0 for now).
---

Tested on Kevin board with bringing up ChromeOS.
OS VERSION:
    CHROMEOS_RELEASE_DESCRIPTION=9693.1.0 (Official Build) dev-channel kevin test

BIOS VERSION:
    Google_Kevin.8785.211.2017_06_20_1043

EC VERSION:
    Build info:    kevin_v1.10.217-24514961d 2017-07-03 07:46:36 wxt at nb

With the ARM's lastest mali driver TX011-SW-99002-r18p0-01rel0 on
https://developer.arm.com/products/software/mali-drivers/midgard-kernel

>From the bootup log:
    localhost devfreq0 # dmesg |grep mali
    [    0.933334] mali ff9a0000.gpu: GPU identified as 0x0860 r2p0 status 0
    [    0.940830] mali ff9a0000.gpu: Protected mode not available
    [    0.947334] mali ff9a0000.gpu: Using configured power model mali-simple-power-model, and fallback mali-simple-power-model
    [    0.960083] mali ff9a0000.gpu: Probed as mali0

    localhost devfreq0 # pwd
    /sys/devices/platform/ff9a0000.gpu/devfreq/devfreq0
    localhost devfreq0 # ls
    available_frequencies  device    min_freq          subsystem    uevent
    available_governors    governor  polling_interval  target_freq  userspace
    cur_freq               max_freq  power             trans_stat

    localhost ff9a0000.gpu # ls
    core_availability_policy  gpuinfo               modalias       soft_job_timeout
    core_mask                 js_scheduling_period  of_node        subsystem
    devfreq                   js_timeouts           pm_poweroff    uevent
    driver                    mem_pool_max_size     power
    driver_override           mem_pool_size         power_policy
    dvfs_period               misc                  reset_timeout
---

And for thermal with IPA.
Try to run 'md5sum /dev/zero &' and octane/benchmark scripts to go up the temperature.
>From the scripts to have a look at the actual control.
"
while true; do grep "" /sys/class/thermal/thermal_zone[0-1]/temp /sys/devices/system/cpu/cpu[0-5]/cpufreq/scaling_cur_freq /sys/devices/platform/ff9a0000.gpu/devfreq/ff9a0000.gpu/cur_freq;date;sleep .5; done &
"

-Caesar



Caesar Wang (4):
  dt-bindings: gpu: add the RK3399 mali for rockchip specifics
  arm64: dts: rockchip: add ARM Mali GPU node for RK3399 SoCs
  arm64: dts: rockchip: enable the GPU for RK3399-GRU
  arm64: dts: rockchip: update the thermal zones for RK3399 SoCs

 .../devicetree/bindings/gpu/arm,mali-midgard.txt   |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  5 ++
 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi   | 33 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       | 33 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 78 +++++++++++++---------
 5 files changed, 117 insertions(+), 33 deletions(-)

-- 
2.7.4
