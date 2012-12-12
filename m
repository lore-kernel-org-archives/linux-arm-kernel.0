From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Dec 2012 21:45:41 +0800
Subject: [PATCH 0/4] Support uncompress debug message for multiplatform build
Message-ID: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving i.MX to multiplatform build, I hear people complaining
that it's bad to lose the uncompress debug message, because not only
does it mean that we will never see message "Uncompressing Linux...
done, booting the kernel.", but also that the debug facility in
arch/arm/boot/compressed/head.S outputs nothing even DEBUG is turned on.

The series follows the approach handling DEBUG_LL to create a Kconfig
symbol CONFIG_UNCOMPRESS_INCLUDE for choosing the correct uncompress
header.  For traditional build, mach/uncompress.h will be included in
arch/arm/boot/compressed/misc.c, and nothing changes than before. For
multiplatform build with none DEBUG_LL port enabled, a set of empty
functions defined in debug/uncompress/dummy.h will be used.  And for
multiplatform build with a DEBUG_LL port, platform specific
uncompress header like debug/uncompress/imx.h will come to play.

Different from traditional build that uncompress output and DEBUG_LL
are two separate pieces, for multiplatform build uncompress output
becomes a subset of DEBUG_LL and relies on DEBUG_LL to select the uart
port, so it only works when DEBUG_LL is enabled.  I think it's an
acceptable compromise to have the uncompress debug facility back.

Shawn Guo (4):
  ARM: imx: use separated debug uart symbol for imx31 and imx35
  ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs
  ARM: imx: restore uncompress.h to a common place
  ARM: uncompress: support uncompress debug for multiplatform build

 arch/arm/Kconfig.debug                    |   44 ++++++++++++---
 arch/arm/boot/compressed/misc.c           |    8 +--
 arch/arm/include/debug/imx-uart.h         |   88 +++++++++++++++++++++++++++++
 arch/arm/include/debug/imx.S              |   29 +---------
 arch/arm/include/debug/uncompress/dummy.h |    3 +
 arch/arm/include/debug/uncompress/imx.h   |   63 +++++++++++++++++++++
 6 files changed, 191 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/include/debug/imx-uart.h
 create mode 100644 arch/arm/include/debug/uncompress/dummy.h
 create mode 100644 arch/arm/include/debug/uncompress/imx.h

-- 
1.7.9.5
