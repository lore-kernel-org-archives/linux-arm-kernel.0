From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Tue,  7 Feb 2017 14:54:12 +0200
Subject: [PATCH 0/2] imx: Fix power-up on RTC alarm
Message-ID: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the syscon-poweroff driver cleans the alarm enable bit during power
off. This behaviour makes it impossible to wake up the device using the RTC.

The first patch adds a mask option to the syscon-poweroff driver. It uses the
method suggested by Sebastian Reichel [0] to maintain compatibility with the
old binding.

The second patch update the device trees for the snvs component users.
Although I believe this should work on all the modified devices, I had only
imx6ul to test with.

Making the wake-up alarm work may require applying another patch [1], already
accepted to the rtc-snvs driver. 

Thanks,
Guy.

[0] http://www.spinics.net/lists/devicetree/msg161527.html
[1] https://patchwork.ozlabs.org/patch/721155/

Guy Shapiro (2):
  power: reset: syscon-poweroff: add a mask property
  ARM: dts: imx: update snvs-poweroff mask

 .../bindings/power/reset/syscon-poweroff.txt          | 11 +++++++++--
 arch/arm/boot/dts/imx6qdl.dtsi                        |  1 +
 arch/arm/boot/dts/imx6sl.dtsi                         |  1 +
 arch/arm/boot/dts/imx6sx.dtsi                         |  1 +
 arch/arm/boot/dts/imx6ul.dtsi                         |  1 +
 arch/arm/boot/dts/imx7s.dtsi                          |  1 +
 drivers/power/reset/syscon-poweroff.c                 | 19 ++++++++++++++++---
 7 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.1.4
