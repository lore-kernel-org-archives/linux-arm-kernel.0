From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 11 Jun 2010 19:09:41 -0500
Subject: [PATCH] ep93xx: clear devcfg bits before setting them
Message-ID: <0D753D10438DA54287A00B027084269763711321BA@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ep93xx core helper function ep93xx_devcfg_set_clear should mask the
clear_bits before setting the new set_bits in case the clear_bits are a
mask value that also includes the set_bits.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 9092677..92f2ebb 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -215,8 +215,8 @@ void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
 	spin_lock_irqsave(&syscon_swlock, flags);
 
 	val = __raw_readl(EP93XX_SYSCON_DEVCFG);
-	val |= set_bits;
 	val &= ~clear_bits;
+	val |= set_bits;
 	__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
 	__raw_writel(val, EP93XX_SYSCON_DEVCFG);
 
