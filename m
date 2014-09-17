From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 17 Sep 2014 13:50:31 +0200
Subject: [PATCH 0/2] s3c RTC fix for Exynos Chromebooks
Message-ID: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

commit 546b117fdf17 ("rtc: s3c: add support for RTC of Exynos3250 SoC")
added an "rtc_src" DT property for the Samsung's S3C Real Time Clock
controller that specifies the 32.768 kHz clock that uses the RTC as
its source clock but this breaks the s3c RTC on Exynos Chromebooks
because the rtc device node does not define the "rtc_src" clock.

It was working before only because the source clock was not disabled
by the kernel since the CCF didn't know about it. But once the clock
is known, the CCF disables the clock and does not work so define the
"rtc_src" clock to make the s3c-rtc driver obtain it and kept enabled.

This series makes the s3c RTC to claim its source clock on the Snow
and Peach boards but other Samsung boards will have the same issue.

The following patches are meant to be for the 3.18 rc cycle once
3.18-rc1 is released.

Javier Martinez Canillas (2):
  ARM: dts: Add rtc_src clk for s3c-rtc on exynos Peach boards
  ARM: dts: Add rtc_src clk for s3c-rtc on exynos5250-snow

 arch/arm/boot/dts/exynos5250-snow.dts      | 5 ++++-
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 5 ++++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

Best regards,
Javier
