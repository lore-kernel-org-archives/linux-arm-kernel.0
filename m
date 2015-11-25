From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:17 +0100
Subject: [PATCH 04/10] ARM: no longer force unbuffered DMA for realview
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 42c4dafe803dca ("ARM: 6202/1: Do not ARM_DMA_MEM_BUFFERABLE
on RealView boards with L210/L220") changed the generic setting for
ARM_DMA_MEM_BUFFERABLE to be disabled on any Realview kernel that includes
support for any of the ARM11 variations. Doing this was required to
allow doing DMA without a lockup in the l2x0 cache controller on the
Realview platform.

Unfortunately, in a kernel that also contains support for any ARMv7
based machine, the same change makes it impossible to do DMA on ARMv7,
which gets in the way of enabling multiplatform support on Realview.

As confirmed by Catalin Marinas and Linus Walleij, the current
code for Realview that we have in the kernel does not actually
perform any DMA, and this is unlikely to change in the future.
Therefore we can revert 42c4dafe803dca without introducing regressions,
but we must never start using DMA on this platform in the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 41218867a9a6..76f65f2d59b1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1005,8 +1005,6 @@ config ARM_L1_CACHE_SHIFT
 
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
-	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
-		     MACH_REALVIEW_PB11MP)
 	default y if CPU_V6 || CPU_V6K || CPU_V7
 	help
 	  Historically, the kernel has used strongly ordered mappings to
-- 
2.1.0.rc2
