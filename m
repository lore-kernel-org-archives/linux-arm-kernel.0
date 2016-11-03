From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Nov 2016 15:29:22 +0100
Subject: [RFC PATCH 0/3] ARM64: meson-gxbb: Add support for system suspend
Message-ID: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thie patchset is a very experiment patchset to support the System Suspend
feature of the Amlogic Meson GX SoCs.

These SoCs implements system suspend using a non-standard PSCI CPU_SUSPEND
parameter to enter system suspend.
A small driver is added to properly fill the platform_suspend_ops and make
to correct SMC call.

In order to wake up from an alarm, these SoCs have a special memory mapped
register where an alarm time delay in seconds is stored.
In order to reuse the RTC wakealarm feature, implement a fake RTC device
that uses the system time to calculate a delay to write to the register.

Note that this RFC is here to seek a better way to handle these platform
specific features.

Neil Armstrong (3):
  ARM64: meson: Add Amlogic Meson GX PM Suspend
  rtc: Add Amlogic Virtual Wake RTC
  ARM64: dts: meson-gxbb: Add support for PM and Virtual RTC

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |   9 ++
 drivers/firmware/meson/Kconfig              |   6 +
 drivers/firmware/meson/Makefile             |   1 +
 drivers/firmware/meson/meson_gx_pm.c        |  86 +++++++++++++++
 drivers/rtc/Kconfig                         |  10 ++
 drivers/rtc/Makefile                        |   1 +
 drivers/rtc/rtc-meson-vrtc.c                | 164 ++++++++++++++++++++++++++++
 7 files changed, 277 insertions(+)
 create mode 100644 drivers/firmware/meson/meson_gx_pm.c
 create mode 100644 drivers/rtc/rtc-meson-vrtc.c

-- 
1.9.1
