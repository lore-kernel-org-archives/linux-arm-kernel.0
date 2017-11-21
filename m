From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 21 Nov 2017 11:57:57 +0000
Subject: [RFC 1/9] arm64: add kconfig symbol to enable 52-bit PA
In-Reply-To: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
References: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1511265485-27163-2-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.2 introduces support for 52-bit physical addresses if the 64k
granule is used. To enable this, add a new kconfig symbol to configure
the physical address space size, with 52-bit as one option. The symbols
will be used to enable 52-bit PA functionality in subsequent patches.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/Kconfig | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..30d0cc272903 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -609,6 +609,34 @@ config ARM64_VA_BITS
 	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48
 
+choice
+	prompt "Physical address space size"
+	default ARM64_PA_BITS_48
+	help
+	  Choose the maximum physical address range that the kernel will
+	  support.
+
+config ARM64_PA_BITS_48
+	bool "48-bit"
+
+config ARM64_PA_BITS_52
+	bool "52-bit (ARMv8.2)"
+	depends on ARM64_64K_PAGES
+	help
+	  Enable support for a 52-bit physical address space, introduced as
+	  part of the ARMv8.2-LPA extension.
+
+	  With this enabled, the kernel will also continue to work on CPUs that
+	  do not support ARMv8.2-LPA, but with some added memory overhead (and
+	  minor performance overhead).
+
+endchoice
+
+config ARM64_PA_BITS
+	int
+	default 48 if ARM64_PA_BITS_48
+	default 52 if ARM64_PA_BITS_52
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
-- 
2.1.4
