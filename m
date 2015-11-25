From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 Nov 2015 13:55:25 +0100
Subject: [PATCH 0/2] Exynos4210: fix power domain for MDMA1 device
Message-ID: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes mysterious boot hang on Exynos 4210 SoCs, when IOMMU
is enabled. There is no direct dependency between IOMMU devices and
MDMA1. However enabling IOMMU changes the device probe order, what
results in LCD0 power domain being turned off for some time. During that
time the registration of MDMA1 device happens, what results in system
hangs, because the common bus code tries to read PID/CID registers from
turned-off device.

The first patch adds support for enabling power domain during AMBA
device registration process, which require access to device's registers
to read PID/CID values. The second assigns MDMA1 device on Exynos 4210
to proper power domain.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (2):
  drivers: amba: properly handle devices with power domains
  ARM: dts: exynos4210: MDMA1 device belongs to LCD0 power domain

 arch/arm/boot/dts/exynos4210.dtsi | 4 ++++
 drivers/amba/bus.c                | 7 +++++++
 2 files changed, 11 insertions(+)

-- 
1.9.2
