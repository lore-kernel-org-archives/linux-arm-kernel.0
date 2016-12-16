From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 10:14:39 +0100
Subject: [PATCH] ARM: disallow ARM_THUMB for ARMv4 builds
Message-ID: <20161216091457.2452987-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With old compilers (gcc-4.3 and earlier), we run into a build error
when CONFIG_ARM_THUMB is enabled in kernels that have both ARMv4 and
ARMv4T/ARMv5 CPU support:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:938: Error: selected processor does not support `bx lr' in ARM mode
arch/arm/kernel/entry-armv.S:961: Error: selected processor does not support `bx lr' in ARM mode
arch/arm/kernel/entry-armv.S:1004: Error: selected processor does not support `bx lr' in ARM mode

The problem evidently is that 'bx' cannot work on the old CPUs, but
the new ones have to use it whenever returning to THUMB user space.

This was discussed a while ago without a conclusion about what
the proper patch should be to solve it, and came again up now when I
experimented with old toolchain versions.

This sidesteps the problem by declaring that we do not support
the configuration and instead have to disable CONFIG_ARM_THUMB
and not use THUMB user space with a kernel that supports the
FA526 CPU, which is the only one that is allowed in a multiplatform
configuration together with ARMv4T/ARMv5 anyway. This is not
a regression because the configuration never worked anyway.
The only platform affected by this is moxart, as no other ARMv4
platforms are part of ARCH_MULTIPLATFORM.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Link: http://lkml.iu.edu/hypermail/linux/kernel/1404.1/00908.html
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5d4920c069f2..f7b7aa37964f 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -655,11 +655,7 @@ config ARCH_DMA_ADDR_T_64BIT
 
 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY
-	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
-		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
-		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
-		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || \
-		CPU_V7 || CPU_FEROCEON || CPU_V7M
+	depends on !(CPU_32v3 || CPU_32v4)
 	default y
 	help
 	  Say Y if you want to include kernel support for running user space
-- 
2.9.0
