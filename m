From: jean.pihet@newoldbits.com (jean.pihet at newoldbits.com)
Date: Mon, 28 Feb 2011 18:41:21 +0100
Subject: [PATCH 0/3] OMAP PM: implement the wake-up latency constraints using
	PM QOS
Message-ID: <1298914884-16468-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean Pihet <j-pihet@ti.com>

Use the PM QOS framework to set wake-up latency constraints on the MPU and DMA.
Cpuidle for OMAP34xx uses PM QOS to retreive the strongest constraint and to
determine the next state for the MPU and CORE power domains.

As of today only I2C is requesting a constraint, but every omap_device
should be able to do so.

Note: To be replaced by a more generic solution which allows every
 device to put a constraint, and which can control all power
 domains in the system. This solution is currently under
 investigation.

Jean Pihet (3):
  OMAP PM: create a PM layer plugin for the devices wakeup latency
    constraints
  OMAP: implement MPU and DMA wake-up constraints using PM_QOS
  OMAP: use PM QOS for wake-up constraints from I2C

 arch/arm/plat-omap/Kconfig                    |    7 +
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/i2c.c                      |   22 ++-
 arch/arm/plat-omap/include/plat/omap-pm.h     |   96 ++++---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap-pm-constraints.c      |  349 +++++++++++++++++++++++++
 arch/arm/plat-omap/omap-pm-noop.c             |   70 +++---
 7 files changed, 469 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c

-- 
1.7.2.3
