From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue,  2 Aug 2011 17:48:38 +0200
Subject: [PATCH] mach-davinci: fix cache flush build error
Message-ID: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The TNET variant of DaVinci compiles some code that it shares
with other DaVinci variants, however it has a V6 CPU rather than
an ARM926T, thus the hardcoded call to arm926_flush_kern_cache_all()
in sleep.S will obviously fail, and we need to build with the
v6_flush_kern_cache_all() call instead. This was triggered by
manually altering the DaVinci config to build the TNET version.

Cc: Dave Martin <dave.martin@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is just an ifdef to get the DaVinci TNET variant to compile,
if there is a way to call out to some abstract flush function in a
MULTI CPU/cache configuration from _assembler_ code, please tell me,

I'm not all that happy about this since it blocks proper multiboard
support for DaVinci, would be nice to find a better solution.
---
 arch/arm/mach-davinci/sleep.S |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index fb5e72b..5f1e045 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -217,7 +217,11 @@ ddr2clk_stop_done:
 ENDPROC(davinci_ddr_psc_config)
 
 CACHE_FLUSH:
-	.word	arm926_flush_kern_cache_all
+#ifdef CONFIG_CPU_V6
+	.word	v6_flush_kern_cache_all
+#else
+	.word   arm926_flush_kern_cache_all
+#endif
 
 ENTRY(davinci_cpu_suspend_sz)
 	.word	. - davinci_cpu_suspend
-- 
1.7.6
