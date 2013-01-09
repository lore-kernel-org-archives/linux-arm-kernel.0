From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed,  9 Jan 2013 18:15:28 +0000
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
Message-ID: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Since 617276307cd4c ("ARM: vexpress: convert to multi-platform") it has
been impossible to select ARCH_VEXPRESS without ARCH_MULTIPLATFORM.

ARCH_MULTIPLATFORM doesn't make sense for NOMMU targets, not least
because of the need to hard-code the memory map. However, it should
still be possible to run NOMMU kernels on top of the Versatile Express
by selecting it as the only platform.

This patch creates a shim ARCH_VEXPRESS_NOMMU config option in the 'choice'
for "ARM system type" to make this possible again.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
CC: Nicolas Pitre <nico@fluxnic.net>
CC: Arnd Bergmann <arnd@arndb.de>
---

Arnd and Nicolas: I've removed your acks as I've changed the location
of the new block (as Nicolas suggested) and ever so slightly tweaked
the name of the new option.

 arch/arm/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 335e220..3357d0b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -322,6 +322,11 @@ config ARCH_VERSATILE
 	help
 	  This enables support for ARM Ltd Versatile board.
 
+config ARCH_VEXPRESS_NOMMU
+	bool "ARM Ltd. Versatile Express family for NOMMU"
+	depends on !MMU
+	select ARCH_VEXPRESS
+
 config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.7.9.5
