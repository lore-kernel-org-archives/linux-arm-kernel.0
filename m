From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 24 Nov 2011 22:12:48 -0600
Subject: [PATCH 0/2] ARM: OMAP: dmtimer: scheduling while atomic fixes
Message-ID: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in dmtimer framework have introduced scheduling-while-atomic
and other lock state BUGs, these are related to the usage of clk_get
(internal path holds a mutex_lock) while holding a spin_lock_irqsave.

The other inconsistent lock state BUGs are caused when calling
omap_dm_timer_request* on softirq or hardirq, because code handling source
parent clocks is still using clk_get, since there is only one user of those
APIs that acquires a lock in a softirq context (tidspbridge) for now it
can be changed.

Omar Ramirez Luna (2):
  ARM: OMAP: dmtimer: fix sleeping function called from invalid context
  ARM: OMAP: dmtimer: reorganize omap_dm_timer_request_*

 arch/arm/plat-omap/dmtimer.c              |  104 +++++++++++------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    6 +-
 2 files changed, 44 insertions(+), 66 deletions(-)

-- 
1.7.5.4
