From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 22 Jun 2017 10:12:31 +0100
Subject: [PATCH] ARM: always enable AEABI for ARMv6+
Message-ID: <E1dNyAB-00065m-3A@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always enable AEABI for ARMv6+, as these use the double-word exclusives
which must be passed an even register to avoid errors such as:

/tmp/ccG2rCwe.s:905: Error: even register required -- `ldrexd r5,r6,[r7]'
/tmp/ccG2rCwe.s:909: Error: even register required -- `strexd sl,r3,r4,[r7]'

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 270ab2549def..78e42f691270 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1542,7 +1542,6 @@ config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
 	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
 	default y if CPU_THUMBONLY
-	select AEABI
 	select ARM_ASM_UNIFIED
 	select ARM_UNWIND
 	help
@@ -1605,7 +1604,8 @@ config ARM_PATCH_IDIV
 	  code to do integer division.
 
 config AEABI
-	bool "Use the ARM EABI to compile the kernel"
+	bool "Use the ARM EABI to compile the kernel" if !THUMB2_KERNEL && !CPU_V7 && !CPU_V7M && !CPU_V6 && !CPU_V6K
+	default THUMB2_KERNEL || CPU_V7 || CPU_V7M || CPU_V6 || CPU_V6K
 	help
 	  This option allows for the kernel to be compiled using the latest
 	  ARM ABI (aka EABI).  This is only useful if you are using a user
-- 
2.7.4
