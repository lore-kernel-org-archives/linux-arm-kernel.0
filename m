From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Jun 2010 11:45:35 +0100
Subject: [PATCH 2/2] ARM: Do not ARM_DMA_MEM_BUFFERABLE on RealView boards
	with L210/L220
In-Reply-To: <20100630104105.16712.66741.stgit@e102109-lin.cambridge.arm.com>
References: <20100630104105.16712.66741.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100630104534.16712.60870.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RealView boards with certain revisions of the L210/L220 cache controller
may have issues (hardware deadlock) with the mandatory barriers (DSB
followed by an L2 cache sync) when ARM_DMA_MEM_BUFFERABLE is enabled.
The patch disables ARM_DMA_MEM_BUFFERABLE for these boards.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3053731..9f10a9b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -828,6 +828,8 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
+	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
+		     MACH_REALVIEW_PB11MP)
 	default y if CPU_V6 || CPU_V7
 	help
 	  Historically, the kernel has used strongly ordered mappings to
