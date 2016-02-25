From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:56 +0900
Subject: [PATCH 2/2] arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs
 with PM Domains
In-Reply-To: <cover.1456442718.git.horms+renesas@verge.net.au>
References: <cover.1456442718.git.horms+renesas@verge.net.au>
Message-ID: <2ee98234b88174f2bcafefb7918e2794a1fdbc98.1456442718.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

All supported Renesas ARM64 SoCs have clock and power domains. To ensure
proper operation of on-SoC modules, module clocks must be ungated, and
power domains must be powered up when needed.

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
CONFIG_PM_GENERIC_DOMAINS unconditionally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/Kconfig.platforms | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 757220cb1b7f..e011ac0e17a3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -76,7 +76,8 @@ config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
 	select ARCH_SHMOBILE
 	select PINCTRL
-	select PM_GENERIC_DOMAINS if PM
+	select PM
+	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
-- 
2.7.0.rc3.207.g0ac5344
