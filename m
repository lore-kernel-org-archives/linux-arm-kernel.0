From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Aug 2011 15:40:14 +0800
Subject: [PATCH 0/3] make reinitialization of ARM core components possible
Message-ID: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When ARM core resumes from low-power mode where losing power, for my
example: CA-9 MP resumes from Dormant/Shutdown, we have to reinitialize
components like L2 Cache, GIC and SCU to bring system back to work.

The patch set basically removes __init annotation from a butch of
initialization functions, so that platform resume procedure can call
into them again to set those components up.

It's based on rmk's for-next branch, and tested on i.MX6Q.

Shawn Guo (3):
      ARM: cache-l2x0: make the reinitialization possible
      ARM: GIC: add gic_reinit() function to help ARM resume
      ARM: smp_scu: remove __init annotation from scu_enable()

 arch/arm/common/gic.c                      |   15 +++++++++++++--
 arch/arm/include/asm/hardware/cache-l2x0.h |   10 +++++++++-
 arch/arm/include/asm/hardware/gic.h        |    1 +
 arch/arm/kernel/smp_scu.c                  |    2 +-
 arch/arm/mm/cache-l2x0.c                   |   23 +++++++++++++----------
 5 files changed, 37 insertions(+), 14 deletions(-)
