From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 15:31:24 +0900
Subject: [GIT PULL] ARM: EXYNOS: Fixes and improvements for v4.2
Message-ID: <1430548284-23827-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,


This groups important fixes and typical improvements for Exynos
SoC for next v4.2 merge window.

I hope you will find useful grouping these commits together.

Everything can be also found on github:
https://github.com/krzk/linux
Branches:
1. fixes-samsung
2. for-next-samsung


If you have any comments, do not hesitate as I would welcome any feedback.
I can also split it into separate fixes and normal updates if you want.


Description:
1. Fix second suspend to RAM on Trats2 board. This has shown up
   after enabling L2 cache but actually the "use delayed reset
   assertion" is to be blamed.
2. Fix imprecise external abort on Exynos5420 boards when exynos-dp
   driver tries to access the DP controller registers and the PD
   was turned off.
3. Various fixes for missing return checks in power domain code.
4. Fix RTC alarm on Arndale Octa board.
5. Improvements of reparenting clocks on power domain on/off.
6. Enabling S3C RTC on various boards.


Best regards,
Krzysztof


----------------------------------------------------------------
The following changes since commit 5d5443b9c3bac7231ae473c01bcfe4c7650b13c5:

  Merge branch 'v4.1-next/mach-samsung' into for-next (2015-03-27 02:36:43 +0900)

are available in the git repository at:

  https://github.com/krzk/linux.git for-next-samsung

for you to fetch changes up to c06f3b9943fbea71ad921ea614e331f571d59c02:

  ARM: dts: Enable S3C RTC on Trats2 and Arndale Octa (2015-05-02 15:02:50 +0900)

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420

Krzysztof Kozlowski (11):
      ARM: EXYNOS: Handle of of_iomap() failure
      ARM: EXYNOS: Handle of_find_device_by_node and kstrdup failures
      ARM: EXYNOS: Add missing of_node_put() when parsing power domains
      ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm IRQ on Arndale Octa
      ARM: EXYNOS: Fix failed second suspend on Exynos4
      ARM: EXYNOS: Get current parent clock for power domain on/off
      ARM: dts: Use last parent for clocks during power domain on/off
      ARM: dts: s3c-rtc: Use s3c6410-rtc instead of exynos3250-rtc
      ARM: dts: Use define for s3c-rtc clock id
      ARM: dts: Use define for s3c-rtc clock id
      ARM: dts: Enable S3C RTC on Trats2 and Arndale Octa

Markus Reichl (1):
      ARM: dts: Add bindings for 32kHz clocks from s2mps11

 .../bindings/arm/exynos/power_domain.txt           |  7 ++--
 Documentation/devicetree/bindings/rtc/s3c-rtc.txt  |  3 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |  3 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  3 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |  2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |  9 ++++-
 arch/arm/boot/dts/exynos4415.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 24 ++++++++++---
 arch/arm/boot/dts/exynos5420.dtsi                  | 14 +++-----
 arch/arm/mach-exynos/common.h                      |  2 ++
 arch/arm/mach-exynos/exynos.c                      | 27 +++++++++++++++
 arch/arm/mach-exynos/platsmp.c                     | 39 ++--------------------
 arch/arm/mach-exynos/pm_domains.c                  | 37 ++++++++++++++------
 arch/arm/mach-exynos/suspend.c                     |  3 ++
 include/dt-bindings/clock/samsung,s2mps11.h        | 23 +++++++++++++
 16 files changed, 129 insertions(+), 71 deletions(-)
 create mode 100644 include/dt-bindings/clock/samsung,s2mps11.h
