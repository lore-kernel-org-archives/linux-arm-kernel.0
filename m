From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Dec 2017 15:23:07 +0000
Subject: [PATCH v2 8/8] arm64: enable 52-bit physical address support
In-Reply-To: <20171222152307.11252-1-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
Message-ID: <20171222152307.11252-9-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kristina Martsenko <kristina.martsenko@arm.com>

Now that 52-bit physical address support is in place, add the kconfig
symbol to enable it. As described in ARMv8.2, the larger addresses are
only supported with the 64k granule. Also ensure that PAN is configured
(or TTBR0 PAN is not), as explained in an earlier patch in this series.

Tested-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
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
