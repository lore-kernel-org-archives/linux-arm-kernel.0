From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Nov 2015 13:49:46 +0100
Subject: [PATCH v2 0/4] Exynos4210: fix power domain for MDMA1 device
Message-ID: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes mysterious boot hang on Exynos 4210 SoCs, when IOMMU
is enabled. There is no direct dependency between IOMMU devices and
MDMA1. However enabling IOMMU changes the device probe order, what
results in LCD0 power domain being turned off for some time. During that
time the registration of MDMA1 device happens, what results in system
hangs, because the common bus code tries to read PID/CID registers from
turned-off device.

The main change from v1 is reusing patches, which move PID/CIR reading
from amba_device_add() to amba_match() and adding power domain support
there. This way -EPROBE_DEFER error code can be handled properly.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:
v2:
- added 2 patches from 'On-demand device probing' thread
  (https://lkml.org/lkml/2015/9/29/189), which move PID/CIR reading
  from amba_device_add() to amba_match()
- moved dev_pm_domain_attach() to amba_match(), which is allowed to
  return -EPROBE_DEFER

v1: http://www.spinics.net/lists/arm-kernel/msg463185.html
- initial version


Patch summary:

Marek Szyprowski (2):
  ARM: dts: exynos4210: MDMA1 device belongs to LCD0 power domain
  ARM: amba: Properly handle devices with power domains

Tomeu Vizoso (2):
  driver core: handle -EPROBE_DEFER from bus_type.match()
  ARM: amba: Move reading of periphid to amba_match()

 arch/arm/boot/dts/exynos4210.dtsi |  4 ++
 drivers/amba/bus.c                | 94 ++++++++++++++++++++++-----------------
 drivers/base/dd.c                 | 24 +++++++++-
 include/linux/device.h            |  2 +-
 4 files changed, 79 insertions(+), 45 deletions(-)

-- 
1.9.2
