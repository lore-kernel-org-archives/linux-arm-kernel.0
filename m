From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 20 Aug 2011 23:42:27 -0600
Subject: [PATCHv3 0/5] OMAP DSS HWMOD fixes
Message-ID: <20110821053355.20198.23847.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just ensuring that this series is copied to lakml.  The fifth patch has
been revised slightly from Tomi's original posting.  This series is targeted
for 3.1-rc.


- Paul

Date: Mon, 8 Aug 2011 12:15:09 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: paul at pwsan.com, linux-omap at vger.kernel.org, b-cousson at ti.com
Cc: archit at ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 0/5] OMAP DSS HWMOD fixes

Second try with the DSS HWMODs

This set fixes the DSS clocks in HWMOD data, and implements a new reset
mechanism for dss_core.

The new dss_reset function doesn't actually do a reset, it just enables all DSS
clocks and waits for the reset to complete. This should be better approach than
actually doing a reset, because:

OMAP4 - dss_core HW doesn't contain a SW reset bit so doing a reset is
impossible. But after power-on we need to enable all DSS clocks and wait for
the power-on reset to complete.

OMAP2/3 - dss_core does have a SW reset bit, but resetting dss_core also resets
all the other DSS modules. This means that the other modules could be left
uninitialized, as the hwmod code handles all modules independently, and in this
case initializes only dss_core's registers. Thus dss_core's reset shouldn't be
used, and we should only verify that the power-on reset has completed.

Tested on OMAP4 and OMAP3.

The first two HWMOD patches (for OMAP2/3) are not changed since v1.

 Tomi

---

Tomi Valkeinen (5):
      OMAP2xxx: HWMOD: fix DSS opt clocks
      OMAP3: HWMOD: fix DSS opt clocks
      OMAP4: HWMOD: fix DSS opt clocks
      OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
      OMAP: HWMOD: Unify DSS resets for all OMAPs


 arch/arm/mach-omap2/Makefile                       |    5 +--
 arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   15 +++++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 +++++++--
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   35 ++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   18 +++-------
 arch/arm/plat-omap/include/plat/common.h           |    3 ++
 include/video/omapdss.h                            |    7 ----
 9 files changed, 106 insertions(+), 32 deletions(-)
