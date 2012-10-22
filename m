From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 22 Oct 2012 20:45:30 +0200
Subject: [PATCH v3 0/4] make cadence ethernet drivers build on any architecture
Message-ID: <1350931534-8416-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes the at91_ether and macb driver build-able on any architecture.

Patch 1 fixes a integer truncated warning in macb, which will show up when compiling for 64-bit, before enabling macb driver for other architectures.

Patch 2 removes the HAVE_NET_MACB from the cadence Kconfig and this allow macb to be built on any architecture. The macb driver requires no other modifications.

Patch 4 moves a bootloader quirk for CSB337 from at91_ether into platform data as a flag. This allow us to remove the last mach include and build this driver on any architecture. It also make it easier to share the address setup between at91_ether and macb.


The next series will make the at91_ether driver use address setting and statistics from macb. There is also a clean up of print outs plus some comment/style fixes.

Patch log:
v3 - Include integer truncated warning fix for macb
v2 - Use macb platform data to support reversed ethernet address and squash HAVE_NET_MACB removal patches.

Joachim Eastwood (4):
  net/macb: fix truncate warnings
  net/cadence: get rid of HAVE_NET_MACB
  net/at91_ether: select MACB in Kconfig
  net/at91_ether: add pdata flag for reverse Eth addr

 arch/arm/mach-at91/Kconfig                | 4 ----
 arch/arm/mach-at91/board-csb337.c         | 2 ++
 arch/avr32/Kconfig                        | 1 -
 drivers/net/ethernet/cadence/Kconfig      | 8 +-------
 drivers/net/ethernet/cadence/Makefile     | 2 +-
 drivers/net/ethernet/cadence/at91_ether.c | 5 ++---
 drivers/net/ethernet/cadence/macb.c       | 8 ++++----
 include/linux/platform_data/macb.h        | 1 +
 8 files changed, 11 insertions(+), 20 deletions(-)

-- 
1.7.12.4
