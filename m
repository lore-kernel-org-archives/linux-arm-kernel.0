From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Mon,  7 Mar 2011 01:53:04 -0600
Subject: [PATCH v2 0/4] OMAP: iommu: hwmod support and runtime PM
Message-ID: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduced hwmod support for OMAP3 (iva, isp) and OMAP4 (ipu, dsp),
along with the corresponding runtime PM routines to deassert reset
lines, enable/disable clocks and configure sysc registers.

v2:
- Added oh reset info to assert/deassert mmu reset lines.
- Addressed previous comments on v1
http://www.spinics.net/lists/arm-kernel/msg103271.html

Due to compatibility an ifdef needs to be propagated (previously on
iommu resource info) to hwmod data in OMAP3, so users of iommu and
tidspbridge can avoid issues of two modules managing mmu data/irqs/resets;
this until tidspbridge can be safely migrated to iommu framework.

Omar Ramirez Luna (4):
  OMAP3/4: iommu: migrate to hwmod framework
  OMAP3/4: iommu: adapt to runtime pm
  OMAP3: hwmod data: Add mmu data for iva and isp
  OMAP4: hwmod data: add mmu hwmod for ipu and dsp

 arch/arm/mach-omap2/iommu2.c               |   36 ------
 arch/arm/mach-omap2/omap-iommu.c           |  161 ++++++----------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  135 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  156 +++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/iommu.h    |   14 ++-
 arch/arm/plat-omap/include/plat/iommu2.h   |    2 -
 arch/arm/plat-omap/iommu.c                 |   50 ++++-----
 7 files changed, 344 insertions(+), 210 deletions(-)
