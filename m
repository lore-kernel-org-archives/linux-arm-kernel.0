From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 18:04:56 +0000
Subject: [PATCH 0/4] Restore SA11x0 MCP/UCB drivers to a working state
Message-ID: <20120120180456.GD11845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samuel,

The following patch set restores the SA11x0 MCP and UCB1x00 drivers back
to a working state, as tested on the Assabet.

The first two patches are the revert I requested.  The others fix a
problem with the UCB1x00's use of genirq (it returns from its interrupt
handler with IRQs enabled, which causes genirq to barf), and delete the
SA11x0 specific DMA definitions and SA11x0 specific DMA header file
from the driver.  That is in preparation for me removing the existing
SA11x0 private DMA backend in favour of a DMA engine implementation.

As the DMA changes have dependencies in my tree (on which other changes
then depend on) I can't see this being sanely split from my tree, so
I'll request acks for these changes.

I'll plan to send the first three patches to Linus as part of my next
'fixes' push if you agree.

 arch/arm/mach-sa1100/assabet.c          |   12 ---
 arch/arm/mach-sa1100/cerf.c             |   11 --
 arch/arm/mach-sa1100/collie.c           |   18 +---
 arch/arm/mach-sa1100/generic.c          |    7 +-
 arch/arm/mach-sa1100/include/mach/mcp.h |    2 -
 arch/arm/mach-sa1100/lart.c             |   10 --
 arch/arm/mach-sa1100/shannon.c          |   11 --
 arch/arm/mach-sa1100/simpad.c           |   18 +---
 drivers/mfd/mcp-core.c                  |   62 +++---------
 drivers/mfd/mcp-sa11x0.c                |  166 +++++++++---------------------
 drivers/mfd/ucb1x00-assabet.c           |    3 -
 drivers/mfd/ucb1x00-core.c              |   49 ++-------
 drivers/mfd/ucb1x00-ts.c                |    3 +-
 include/linux/mfd/mcp.h                 |   13 +--
 include/linux/mfd/ucb1x00.h             |    5 +-
 include/linux/mod_devicetable.h         |   11 --
 scripts/mod/file2alias.c                |   10 --
 17 files changed, 81 insertions(+), 330 deletions(-)
