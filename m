From: joshc@ni.com (Josh Cartwright)
Date: Tue, 2 Feb 2016 20:30:47 -0600
Subject: [PATCH 0/2] ARM: zynq: address silent L2 cache corruption
Message-ID: <cover.1454465714.git.joshc@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Zynq has a bug where the L2 cache will return invalid data in some
circumstances unless the L2C_RAM register is set to 0x20202 before the first
enabling of the L2 cache.

The Xilinx-recommended solution to this problem is to ensure that early one of
the earlier bootstages correctly initialize L2C_RAM, however, this issue wasn't
discovered and fixed until after their EDK/SDK 14.4 release.  For systems built
prior to that, and which lack field-upgradable bootloaders, this issue still
exists and silent data corruption can be seen in the wild.

Fix these systems by ensuring L2C_RAM is properly initialized at the
earliest convenient moment prior to the L2 being brought up, which is
when the SLCR is first mapped.

Unfortunately, there isn't much public documentation on exactly what the
L2C_RAM register is for, or how it is used, only that software is responsible
for initializing it to the proper value prior to bringing up L2.

You can find more information about this bug in AR#54190[1].

1: http://www.xilinx.com/support/answers/54190.html

Josh Cartwright (2):
  ARM: zynq: initialize slcr mapping earlier
  ARM: zynq: address L2 cache data corruption

 arch/arm/mach-zynq/common.c | 3 +--
 arch/arm/mach-zynq/slcr.c   | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.7.0
