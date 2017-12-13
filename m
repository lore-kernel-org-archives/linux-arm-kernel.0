From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed, 13 Dec 2017 17:07:25 +0000
Subject: [PATCH 10/10] arm64: enable 52-bit physical address support
In-Reply-To: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1513184845-8711-11-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that 52-bit physical address support is in place, add the kconfig
symbol to enable it. As described in ARMv8.2, the larger addresses are
only supported with the 64k granule. Also ensure that PAN is configured
(or TTBR0 PAN is not), as explained in an earlier patch in this series.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8dc937823eeb..337a696c9b02 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -656,11 +656,24 @@ choice
 config ARM64_PA_BITS_48
 	bool "48-bit"
 
+config ARM64_PA_BITS_52
+	bool "52-bit (ARMv8.2)"
+	depends on ARM64_64K_PAGES
+	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
+	help
+	  Enable support for a 52-bit physical address space, introduced as
+	  part of the ARMv8.2-LPA extension.
+
+	  With this enabled, the kernel will also continue to work on CPUs that
+	  do not support ARMv8.2-LPA, but with some added memory overhead (and
+	  minor performance overhead).
+
 endchoice
 
 config ARM64_PA_BITS
 	int
 	default 48 if ARM64_PA_BITS_48
+	default 52 if ARM64_PA_BITS_52
 
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
-- 
2.1.4
