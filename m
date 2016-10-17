From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 17 Oct 2016 21:45:28 +0200
Subject: [PATCH v3 0/4] support smc91x on mainstone and devicetree
Message-ID: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie aims at bringing support to mainstone board on a device-tree based
build, as what is already in place for legacy mainstone.

The bulk of the mainstone "specific" behavior is that a u16 write doesn't work
on a address of the form 4*n + 2, while it works on 4*n.

The legacy workaround was in SMC_outw(), with calls to
machine_is_mainstone(). These calls don't work with a pxa27x-dt machine type,
which is used when a generic device-tree pxa27x machine is used to boot the
mainstone board.

Therefore, this serie enables the smc91c111 adapter of the mainstone board to
work on a device-tree build, exaclty as it's been working for years with the
legacy arch/arm/mach-pxa/mainstone.c definition.

As a sum up, this extends an existing mechanism to device-tree based pxa platforms.

Cheers.

--
Robert

Robert Jarzmik (4):
  ARM: pxa: enhance smc91x platform data
  net: smc91x: isolate u16 writes alignment workaround
  net: smc91x: take into account half-word workaround
  net: smsc91x: add u16 workaround for pxa platforms

 .../devicetree/bindings/net/smsc-lan91c111.txt     |  2 +
 arch/arm/mach-pxa/idp.c                            |  1 +
 arch/arm/mach-pxa/mainstone.c                      |  1 +
 arch/arm/mach-pxa/stargate2.c                      |  1 +
 arch/mn10300/unit-asb2303/include/unit/smc91111.h  |  2 +-
 drivers/net/ethernet/smsc/smc91x.c                 |  5 +-
 drivers/net/ethernet/smsc/smc91x.h                 | 82 ++++++++++++----------
 include/linux/smc91x.h                             |  1 +
 8 files changed, 55 insertions(+), 40 deletions(-)

-- 
2.1.4
