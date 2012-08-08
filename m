From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 23:27:52 +0200
Subject: [PATCH 04/10] ARM: pass -marm to gcc by default
In-Reply-To: <1344461278-28245-1-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
Message-ID: <1344461278-28245-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linaro cross toolchain and probably others nowadays default to
building in THUMB2 mode. When building a kernel for a CPU that does
not support THUMB2, the compiler complains about incorrect flags.
We can work around this by setting -marm for all non-T2 builds.

Without this patch, building assabet_defconfig results in:

usr/initramfs_data.S:1:0: warning: target CPU does not support THUMB instructions [enabled by default]
arch/arm/nwfpe/entry.S:1:0: warning: target CPU does not support THUMB instructions [enabled by default]
firmware/cis/PCMLM28.cis.gen.S:1:0: warning: target CPU does not support THUMB instructions [enabled by default]
(and many more)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/Makefile |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..b4c2296 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -111,6 +111,9 @@ AFLAGS_THUMB2	:=$(CFLAGS_THUMB2) -Wa$(comma)-mthumb
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
 CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
+else
+CFLAGS_THUMB2  :=-marm
+AFLAGS_THUMB2	:=-marm
 endif
 
 # Need -Uarm for gcc < 3.x
-- 
1.7.10
