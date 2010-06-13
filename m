From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 13 Jun 2010 11:10:39 +1000
Subject: [PATCH 3/4] arm/orion5x: Fix soft-reset for some platforms
Message-ID: <1276391439.1962.265.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms, such as the DNS-323 rev C requires the soft reset line
to be toggled on and back off for the reset to work.

Note: The choice of 200ms delay comes from the 2.6.12 based vendor kernel.
It seems to be a -lot- though and I had my device working fine with much
smaller delays but better safe...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/mach-orion5x/include/mach/system.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-orion5x/include/mach/system.h b/arch/arm/mach-orion5x/include/mach/system.h
index 60e734c..a1d6e46 100644
--- a/arch/arm/mach-orion5x/include/mach/system.h
+++ b/arch/arm/mach-orion5x/include/mach/system.h
@@ -25,6 +25,8 @@ static inline void arch_reset(char mode, const char *cmd)
 	 */
 	orion5x_setbits(RSTOUTn_MASK, (1 << 2));
 	orion5x_setbits(CPU_SOFT_RESET, 1);
+	mdelay(200);
+	orion5x_clrbits(CPU_SOFT_RESET, 1);
 }
 
 
