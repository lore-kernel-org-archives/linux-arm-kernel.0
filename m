From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:17 -0400
Subject: [PATCH 2/9] ARM: zImage: Fix bad SP address after relocating kernel
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tony Lindgren <tony@atomide.com>

Otherwise cache_clean_flush can overwrite some of the relocated
area depending on where the kernel image gets loaded. This fixes
booting on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
(ARM: 6750/1: improvements to compressed/head.S).

Thanks to Aaro Koskinen <aaro.koskinen@nokia.com> for debugging
the address of the relocated area that gets corrupted, and to
Nicolas Pitre <nicolas.pitre@linaro.org> for the other uncompress
related fixes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/head.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 84ac4d6..55a5bcb 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -253,6 +253,11 @@ restart:	adr	r0, LC0
 		/* Preserve offset to relocated code. */
 		sub	r6, r9, r6
 
+#ifndef CONFIG_ZBOOT_ROM
+		/* cache_clean_flush may use the stack, so relocate it */
+		add	sp, sp, r6
+#endif
+
 		bl	cache_clean_flush
 
 		adr	r0, BSYM(restart)
-- 
1.7.4
