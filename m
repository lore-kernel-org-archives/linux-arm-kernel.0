From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:37 +0100
Subject: [PATCH 05/11] ARM: davinci: multi-soc kernels require AUTO_ZRELADDR
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci DA8xx and DMx families have incompatible zreladdr
settings, and attempting to build a kernel with both enabled
results in an error unless AUTO_ZRELADDR is set:

multiple zreladdrs: 0xc0008000 0x80008000
This needs CONFIG_AUTO_ZRELADDR to be set

This patch changes Kconfig to make the two families mutually
exclusive when this is unset.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 584e8d4e2892..cd30f6f5f2ff 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -32,12 +32,14 @@ config ARCH_DAVINCI_DM646x
 
 config ARCH_DAVINCI_DA830
 	bool "DA830/OMAP-L137/AM17x based system"
+	depends on !ARCH_DAVINCI_DMx || AUTO_ZRELADDR
 	select ARCH_DAVINCI_DA8XX
 	select CPU_DCACHE_WRITETHROUGH # needed on silicon revs 1.0, 1.1
 	select CP_INTC
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
+	depends on !ARCH_DAVINCI_DMx || AUTO_ZRELADDR
 	select ARCH_DAVINCI_DA8XX
 	select CP_INTC
 
-- 
2.1.0.rc2
