From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:09 +0900
Subject: [PATCH 4/4] ARM: shmobile: Select CONFIG_ZONE_DMA when
 CONFIG_ARM_LPAE is enabled
In-Reply-To: <cover.1415058939.git.horms+renesas@verge.net.au>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
Message-ID: <3794705aeb318c431c07072f04380c78cc5a84ac.1415058939.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Most IP cores on ARM Renesas platforms can only address 32 bits of
physical memory for DMA. Without CONFIG_ZONE_DMA enabled and with the
recent CMA highmem allocation support, the default CMA zone is reserved
above the 4GiB limit when LPAE is enabled, resulting in various driver
failures.

Fix the problem by selecting CONFIG_ZONE_DMA. Other options to
investigate in the future would be to either enable IOMMU support or use
custom CMA reservations for peripherals not supporting LPAE.

While not a strict dependency, the "[PATCH 0/4] Low/high memory CMA
reservation fixes" series is also required to fix a different but related CMA
allocation problem.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 21f457b..6bc018f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_SHMOBILE
 	bool
+	select ZONE_DMA if ARM_LPAE
 
 config PM_RCAR
 	bool
-- 
2.1.1
