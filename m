From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:27:24 +0100
Subject: [PATCH v2 2/3] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <1368530845-7415-1-git-send-email-jonathan.austin@arm.com>
References: <1368530845-7415-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368530845-7415-3-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 617276307cd4c ("ARM: vexpress: convert to multi-platform") it has been
impossible to select ARCH_VEXPRESS without ARCH_MULTIPLATFORM.

ARCH_MULTIPLATFORM doesn't make sense for NOMMU targets, not least because
of the need to hard-code the memory map. However, it should still be
possible to run NOMMU kernels on top of the Versatile Express by selecting
it as the only platform.

This patch creates a shim ARCH_VEXPRESS_NOMMU config option in the 'choice'
for "ARM system type" to make this possible again.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Acked-by: Arnd Bergmann <arnd@arndb.de>
CC: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 408eb33..541d90e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -350,6 +350,23 @@ config ARCH_VERSATILE
 	help
 	  This enables support for ARM Ltd Versatile board.
 
+config ARCH_VEXPRESS_NOMMU
+	bool "ARM Ltd. Versatile Express family for NOMMU"
+	depends on !MMU
+	select ARCH_VEXPRESS
+	select SPARSE_IRQ
+	select ARM_GENERIC_HEADERS
+	help
+	  This option enables support for systems using Cortex processor based
+	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
+	  in configurations WITHOUT an MMU. You must boot using a Flattened
+	  Device Tree - the traditional ATAGs boot method is not usable with
+	  this configuration.
+
+	  If your system has an MMU and you want to make use of it, you
+	  should instead choose to build a multiplatform kernel and
+	  select ARCH_VEXPRESS
+
 config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.7.9.5
