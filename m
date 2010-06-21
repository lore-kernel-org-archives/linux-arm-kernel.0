From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 13:23:35 +0100
Subject: [PATCH 2/2] ARM: Do not enable ARM_DMA_MEM_BUFFERABLE for some
	RealView boards
In-Reply-To: <20100621115703.7162.95491.stgit@e102109-lin.cambridge.arm.com>
References: <20100621115703.7162.95491.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621122335.7162.55877.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RealView boards with certain revisions of the L210/L220 cache controller
may have issues with recent changes to the mb() barrier implementation
(DSB followed by an L2 cache sync). The patch disables
ARM_DMA_MEM_BUFFERABLE for some of the RealView boards with L210/L220.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index fc1b2fa..101105e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -813,6 +813,8 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
+	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
+		     MACH_REALVIEW_PB11MP)
 	default y if CPU_V6 || CPU_V7
 	help
 	  Historically, the kernel has used strongly ordered mappings to
