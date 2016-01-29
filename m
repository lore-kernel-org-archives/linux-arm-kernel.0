From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:06:29 +0100
Subject: [PATCH 5/9] ARM: pxa: always select one of the two CPU types
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Message-ID: <1454076396-3563101-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When all boards are disabled on PXA, we cannot build a kernel
because no CPU gets selected:

arch/arm/include/uapi/asm/swab.h:26:29: error: "__LINUX_ARM_ARCH__" is not defined [-Werror=undef]

This is a bit annoying for compile-testing, so I'm adding a line
that ensures that at all times, at least one of CPU_XSCALE or
CPU_XSC3 is set and we can at least continue building.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e1aac8bdf84..1d2b5e6cab14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -564,6 +564,7 @@ config ARCH_PXA
 	select CLKSRC_PXA
 	select CLKSRC_MMIO
 	select CLKSRC_OF
+	select CPU_XSCALE if !CPU_XSC3
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
 	select HAVE_IDE
-- 
2.7.0
