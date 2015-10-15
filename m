From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 15 Oct 2015 18:51:07 +0200
Subject: [PATCH v2 0/6] ARM: dts: Use correct CD properties for SDIO and eMMC
 in Snow and Peach
Message-ID: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The Exynos Chromebooks DTS don't use the correct card detection properties
since these were carried from the vendor tree that had a reason to do so.

There are two things that I noticed:

1) The Marvell WiFi SDIO is marked as broken-cd instead of non-removable:

This causes the device to be removed when the system enters into a suspend
state which leads to the following warning when the system is resumed:

[  181.944636] mmc2: error -2 during resume (card was removed?)

The rationale for using broken-cd is explained in downstream commit [0] and
was that using the non-removable property caused issues with the mwifiex
driver since the reset logic called the mmc_{remove,add}_host() functions.

But the reset logic in the mwifiex mainline driver has changed and this is
no longer the case so it's safe to use the non-removable property AFAICT.

2) The eMMC node has both broken-cd and non-removable but the MMC DT binding
doc (Documentation/devicetree/bindings/mmc/mmc.txt) mentions that only one
of these card detection properties should be used.

So this series change both the SDIO WiFi and eMMC device nodes in the Snow,
Peach Pi and Peach Pit boards DTS to use the non-removable property.

To test, I've cherry picked commit [1] from the vendor tree that adds a
debugfs entry to force a card reset and after the reset, the WiFi card still
works correctly:

$ echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset

And also tested that both eMMC and WiFi are working correctly after a S2R.

The test were made on an Exynos5800 Peach Pi but I don't have access to a
Snow anymore so testing patch 3/6 and 6/6 on that board will be appreciated.

v1 of the series was [2] and this version fixes issues pointed out by Tomeu.

Changes since v1:
 - Replace broken-cd for non-removable in the correct mmc node for Snow.
 - Correct the card detetion properties for eMMC in Snow, Pit and Pi.
 - Also remove the card-detect-delay property when using non-removable.

[0]: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ad348e1e2381
[1]: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/5995363523de
[2]: https://lkml.org/lkml/2015/10/15/294

Best regards,
Javier


Javier Martinez Canillas (6):
  ARM: dts: Mark SDIO as non-removable in exynos5800-peach-pi
  ARM: dts: Mark SDIO as non-removable in exynos5420-peach-pit
  ARM: dts: Mark SDIO as non-removable in exynos5250-snow-common
  ARM: dts: Remove broken-cd from eMMC node in exynos5800-peach-pi
  ARM: dts: Remove broken-cd from eMMC node in exynos5420-peach-pi
  ARM: dts: Mark eMMC as non-removable in exynos5250-snow-common

 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 6 ++----
 arch/arm/boot/dts/exynos5420-peach-pit.dts    | 5 +----
 arch/arm/boot/dts/exynos5800-peach-pi.dts     | 5 +----
 3 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.4.3
