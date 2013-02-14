From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:47:50 +0100
Subject: [PATCH 8/9] [HACK] ARM: imx: work around v7_cpu_resume link error
In-Reply-To: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
Message-ID: <1360882071-4072668-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch c08e20d24 "arm: Add v7_invalidate_l1 to cache-v7.S"
moves the v7_invalidate_l1 symbol out of imx/headsmp.S,
which seems to cause a link error because it is now
too far away from v7_cpu_resume when building an
allyesconfig kernel.

If we move the v7_cpu_resume function from the .data
section to .text, that creates another link error
for the reference to phys_l2x0_saved_regs, but we
can move all of the above to .text.

I believe that this is not a correct bug fix but just
a bad workaround, so I'm open to ideas from people
who understand the bigger picture.

Without this patch, building allyesconfig results in:

arch/arm/mach-imx/built-in.o: In function `v7_cpu_resume':
arch/arm/mach-imx/headsmp.S:55:(.data+0x87f8): relocation truncated to fit: R_ARM_CALL against symbol `v7_invalidate_l1' defined in .text section in arch/arm/mm/built-in.o

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@altera.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-imx/headsmp.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index 921fc15..0de76cc 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -30,7 +30,7 @@ ENDPROC(v7_secondary_startup)
  * allow phys_l2x0_saved_regs to be accessed with a relative load
  * as we are running on physical address here.
  */
-	.data
+	.text
 	.align
 
 #ifdef CONFIG_CACHE_L2X0
@@ -51,6 +51,8 @@ phys_l2x0_saved_regs:
 	.endm
 #endif
 
+	.text
+
 ENTRY(v7_cpu_resume)
 	bl	v7_invalidate_l1
 	pl310_resume
-- 
1.8.1.2
