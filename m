From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Jan 2015 01:17:33 -0700
Subject: [PATCH 1/2] arm64: Kconfig: add basic support for the Tegra SoC
 family and the Tegra132 SoC
In-Reply-To: <20150107081638.14381.42444.stgit@dusk.lan>
References: <20150107081638.14381.42444.stgit@dusk.lan>
Message-ID: <20150107081729.14381.47835.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic Kbuild support for the Tegra SoC family, and specifically,
the Tegra132 SoC.  Tegra132 pairs the NVIDIA Denver CPU complex with
the SoC integration of Tegra124 - hence the use of ARCH_TEGRA and the
Tegra124 pinctrl option.

For the time being, Tegra ARM64 support is added with a dependency on
CONFIG_BROKEN.  This is temporary and can be removed when the
following two patches for compilation failures have been merged:

"soc: tegra: pmc: restrict compilation of suspend-related support to ARM"
https://git.kernel.org/cgit/linux/kernel/git/pjw/tegra-dev.git/commit/?id=053decbf3900d4e8fee799f9a29cf8d905b2fcb1

"clocksource: tegra: wrap arch/arm-specific sections in CONFIG_ARM"
https://git.kernel.org/cgit/linux/kernel/git/pjw/tegra-dev.git/commit/?id=220aa7fcc74a1a089916be6cb34b0e326f31841f

This patch was based on a patch originally written by Allen Martin
<amartin@nvidia.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Allen Martin <amartin@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1f9a20a3677..f2f8ade6f3e9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -153,6 +153,35 @@ config ARCH_SEATTLE
 	help
 	  This enables support for AMD Seattle SOC Family
 
+config ARCH_TEGRA
+	bool
+	depends on BROKEN
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select HAVE_SMP
+	select PINCTRL
+	help
+	  This enables support for the NVIDIA Tegra SoC family
+
+config ARCH_TEGRA_132_SOC
+	bool "NVIDIA Tegra132 SoC"
+	depends on BROKEN
+	select ARCH_TEGRA
+	select PINCTRL_TEGRA124
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select USB_ULPI if USB_PHY
+	select USB_ULPI_VIEWPORT if USB_PHY
+	help
+	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
+	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
+	  but contains an NVIDIA Denver CPU complex in place of
+	  Tegra124's "4+1" Cortex-A15 CPU complex.
+
 config ARCH_THUNDER
 	bool "Cavium Inc. Thunder SoC Family"
 	help
