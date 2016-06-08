From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 08 Jun 2016 12:25:53 +0200
Subject: [PATCH 0/3] Exynos IOMMU: proper runtime pm support
Message-ID: <1465381556-2230-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series finally implements proper runtime pm support in Exynos
IOMMU driver. This has been achieved by adding runtime pm notifiers,
which lets SYSMMU controller to follow it's master device (the device
which actually performs DMA transaction) runtime pm. The main idea
behind this solution is an observation that any DMA activity from master
device can be done only when master device is active, thus when master
device is suspended SYSMMU controller device can also be suspended.

This patchset finally solves the situation that power domains are always
enabled, because all SYSMMU controllers (which belongs to those domains)
are permanently active (because existing driver was simplified and kept
SYSMMU device active all the time after initialization).

This patchset requires my previous changes to Exynos IOMMU driver
submitted in the "Exynos IOMMU: improve clock management" thread:
http://www.spinics.net/lists/arm-kernel/msg505695.html  

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Krzysztof Kozlowski (1):
  PM / Runtime: Add notifiers for device runtime PM events

Marek Szyprowski (2):
  iommu/exynos: Remove excessive, useless debug
  iommu/exynos: Add proper runtime pm support

 drivers/base/power/generic_ops.c |   9 ++
 drivers/base/power/power.h       |   6 ++
 drivers/base/power/runtime.c     |  34 ++++++-
 drivers/iommu/exynos-iommu.c     | 214 ++++++++++++++++++---------------------
 include/linux/pm.h               |   2 +
 include/linux/pm_runtime.h       |  51 ++++++++++
 6 files changed, 201 insertions(+), 115 deletions(-)

-- 
1.9.2
