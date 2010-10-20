From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 20 Oct 2010 16:38:44 -0700
Subject: [RFC/PATCH 0/2] OMAP: PM: add "early" idle notifier chain
Message-ID: <1287617926-24308-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on previous idle notification series, starting at:

      [PATCH 1/3] OMAP: PM: formalize idle notifications

This series adds an additional "early" idle notifier chain triggered
early in the CPUidle path with interrupts enabled.

This allows users of "early" notifiers to use blocking calls.  While
in general, use of blocking calls in idle notifiers should be avoided,
the current runtime PM API can sleep/schedule so cannot be done from
atomic context.  Use of "early" notifiers allows driver/device code to
use the runtime PM API in their idle notifier callbacks.

RFC: note that patch 2 enables interrupts in the CPUidle path, causing
interrupts to be enabled during the governor state selection and
device idle detection.  What could go wrong here?

Kevin Hilman (2):
  OMAP: PM: add "early" idle notifications
  OMAP3: CPUidle: trigger early idle notification call chain

 arch/arm/mach-omap2/cpuidle34xx.c        |   27 ++++++++++++++++++++++++---
 arch/arm/mach-omap2/pm.c                 |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h |    6 ++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

-- 
1.7.2.1
