From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Sep 2016 15:13:51 +0100
Subject: [PATCH 0/2] ARM: Do not mess with CCI if booted from HYP
Message-ID: <1474380833-30121-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some systems (such as the VExpress TC2) are built around a CCI-400,
which is only accessible from secure mode. This obviously breaks if
the system is booted in non-secure mode. Detecting non-secure is
pretty hard to do, unless the system is booted from HYP.

This small patch series makes sure that:
- The CCI ports are not accessed when the kernel is booted from HYP
- MCPM (which depends on CCI) is not enabled on VExpress if booted
from HYP.

This allows a multi_v7_defconfig kernel to be booted on a TC2 booting
from HYP, instead of miserably dying very early on.

Marc Zyngier (2):
  ARM: vexpress: Do not enable MCPM if booted from HYP
  arm-cci: Do not probe the CCI ports if booted from HYP

 arch/arm/mach-vexpress/platsmp.c |  8 ++++++--
 drivers/bus/arm-cci.c            | 11 +++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.1.4
