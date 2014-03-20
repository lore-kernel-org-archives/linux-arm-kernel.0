From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 20 Mar 2014 21:39:44 +0100
Subject: [PATCH 0/2] ARM: berlin: SMP support
Message-ID: <1395347986-30203-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small patch set for SMP support on Marvell Berlin BG2
and recently provided BG2Q. Nothing spectacular, as it basically
copies SMP holding pen mechanism from mach-prima2 and plat-versatile
with minor Berlin specific code for SCU and general purpose registers
used by secondary CPUs to get their boot address.

There was some IRC discussion with Alexandre about using
scu_get_base() instead of a DT node. Although BG2Q is true A9
and provides SCU base; BG2 with PJ4b does not and I decided to
depend on a DT node for SCU in both cases, which is fine I guess.

I tested this on BG2, and BG2CD (which is UP). I expect the
Free-Electrons guys to test on BG2Q.

There is a branch based on v3.14-rc1 and latest BG2Q DTs for the
lucky ones who are able to boot unsigned images at

https://github.com/shesselba/linux-berlin.git topic/smp-bg2-bg2q

Sebastian

Sebastian Hesselbarth (2):
  ARM: berlin: add scu and chipctrl device nodes for BG2/BG2Q
  ARM: berlin: add SMP support

 arch/arm/boot/dts/berlin2.dtsi  |  10 +++
 arch/arm/boot/dts/berlin2q.dtsi |  10 +++
 arch/arm/mach-berlin/Kconfig    |   1 +
 arch/arm/mach-berlin/Makefile   |   1 +
 arch/arm/mach-berlin/berlin.c   |   3 +
 arch/arm/mach-berlin/common.h   |  18 ++++++
 arch/arm/mach-berlin/headsmp.S  |  43 +++++++++++++
 arch/arm/mach-berlin/platsmp.c  | 139 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 225 insertions(+)
 create mode 100644 arch/arm/mach-berlin/common.h
 create mode 100644 arch/arm/mach-berlin/headsmp.S
 create mode 100644 arch/arm/mach-berlin/platsmp.c

---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.9.0
