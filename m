From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 10 May 2012 13:21:01 +0300
Subject: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
Message-ID: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches fix DSS hwmod data related to sysc flags. I haven't seen any
problem produced by these missing bits, but by looking at the TRM it's clear
that they should be defined.

However, applying these will cause additional warnings to show during boot:

omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)

Most likely the softreset fails even now, but as there's no check to verify it,
no warnings are visible.

I think the reason for the failing softreset is the same problem as we have on
OMAP4: dss_core hwmod should be enabled before other dss hwmods can be enabled
(and reset).

 Tomi

Tomi Valkeinen (3):
  ARM: OMAP2/3: HWMOD: Add missing flags for dispc class
  ARM: OMAP2/3: HWMOD: Add missing flag for rfbi class
  ARM: OMAP3: HWMOD: Add omap_hwmod_class_sysconfig for dsi

 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   15 ++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.9.5
