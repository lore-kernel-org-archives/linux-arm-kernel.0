From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 10:21:31 +0900
Subject: [PATCH 6/6] ARM: shmobile: Enable PM and PM_GENERIC_DOMAINS for SoCs
 with PM Domains
In-Reply-To: <cover.1456275652.git.horms+renesas@verge.net.au>
References: <cover.1456275652.git.horms+renesas@verge.net.au>
Message-ID: <71d076ceb245f0d9a05e552bbebd5911660bd2ac.1456275652.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

All supported Renesas ARM SoCs (except for Emma Mobile EV2) have clock
domains. Some SoCs also have power domains. To ensure proper operation
of on-SoC modules, module clocks must be ungated, and power domains must
be powered up when needed.

Currently the user can choose to build a kernel with power management
enabled or disabled:
  - If CONFIG_PM=y, power domains and/or module clocks are handled
    dynamically by Runtime PM and the generic power domain.
  - If CONFIG_PM=n, power domains are assumed to be powered up by reset
    state or by the boot loader, and module clocks are handled by the
    legacy clock domain on driver (un)bind.
    The latter is implemented using a platform bus notifier, which
    applies not only to all on-SoC devices, but to all platform devices
    present in the system.

To remove the dependency on implicit assumptions, and to get rid of the
peculiarities of the legacy clock domain, enable CONFIG_PM and
CONFIG_PM_GENERIC_DOMAINS unconditionally, for all Renesas ARM SoCs with
clock and/or power domains.

This does cause an increase in kernel size.  Given bloat-o-meter reports
a modest increase of 26 KiB for an RZ/A1H kernel, this should not be a
problem, even when used on RZ/A1H with XIP and internal RAM only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cd5f171f83ce..2824b81f1a39 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -6,28 +6,30 @@ config ARCH_SHMOBILE_MULTI
 
 config PM_RCAR
 	bool
-	select PM_GENERIC_DOMAINS if PM
+	select PM
+	select PM_GENERIC_DOMAINS
 
 config PM_RMOBILE
 	bool
+	select PM
 	select PM_GENERIC_DOMAINS
 
 config ARCH_RCAR_GEN1
 	bool
-	select PM_RCAR if PM || SMP
+	select PM_RCAR
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_RCAR_GEN2
 	bool
-	select PM_RCAR if PM || SMP
+	select PM_RCAR
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
 
 config ARCH_RMOBILE
 	bool
-	select PM_RMOBILE if PM
+	select PM_RMOBILE
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
@@ -55,7 +57,8 @@ config ARCH_EMEV2
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
-	select PM_GENERIC_DOMAINS if PM
+	select PM
+	select PM_GENERIC_DOMAINS
 	select SYS_SUPPORTS_SH_MTU2
 
 config ARCH_R8A73A4
-- 
2.1.4
