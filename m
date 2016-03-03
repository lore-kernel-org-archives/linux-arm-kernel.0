From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 15:10:59 +0100
Subject: [PATCH] arm64: enable CONFIG_DEBUG_RODATA by default
Message-ID: <1457014259-32015-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In spite of its name, CONFIG_DEBUG_RODATA is an important hardening feature
for production kernels, and distros all enable it by default in their
kernel configs. However, since enabling it used to result in more granular,
and thus less efficient kernel mappings, it is not enabled by default for
performance reasons.

However, since commit 2f39b5f91eb4 ("arm64: mm: Mark .rodata as RO"), the
various kernel segments (.text, .rodata, .init and .data) are already
mapped individually, and the only effect of setting CONFIG_DEBUG_RODATA is
that the existing .text and .rodata mappings are updated late in the boot
sequence to have their read-only attributes set, which means that any
performance concerns related to enabling CONFIG_DEBUG_RODATA are no longer
valid.

So from now on, make CONFIG_DEBUG_RODATA default to 'y'

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index e13c4bf84d9e..7e76845a0434 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -50,13 +50,13 @@ config DEBUG_SET_MODULE_RONX
 
 config DEBUG_RODATA
 	bool "Make kernel text and rodata read-only"
+	default y
 	help
 	  If this is set, kernel text and rodata will be made read-only. This
 	  is to help catch accidental or malicious attempts to change the
-	  kernel's executable code. Additionally splits rodata from kernel
-	  text so it can be made explicitly non-executable.
+	  kernel's executable code.
 
-          If in doubt, say Y
+	  If in doubt, say Y
 
 config DEBUG_ALIGN_RODATA
 	depends on DEBUG_RODATA && ARM64_4K_PAGES
-- 
2.5.0
