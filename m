From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 12 Nov 2013 22:57:47 -0800
Subject: [PATCH v2] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
In-Reply-To: <1384325867-5140-1-git-send-email-victor.kamensky@linaro.org>
References: <1384325867-5140-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1384325867-5140-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of armv7-m architecture arm instructions are not allowed.
For this architecture CONFIG_CPU_THUMBONLY is set. Let's
explicitly set minimal architecture that allows both required
thumb and arm opcodes. It is OK to do, since file as used as
array of code snippets, which is indexed by signal.c code.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/sigreturn_codes.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
index 3c5d0f2..081a041 100644
--- a/arch/arm/kernel/sigreturn_codes.S
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -30,12 +30,12 @@
  * snippets.
  */
 
-#if __LINUX_ARM_ARCH__ <= 4
+#if (__LINUX_ARM_ARCH__ <= 4) || defined(CONFIG_CPU_THUMBONLY)
 	/*
 	 * Note we manually set minimally required arch that supports
-	 * required thumb opcodes for early arch versions. It is OK
-	 * for this file to be used in combination with other
-	 * lower arch variants, since these code snippets are only
+	 * required thumb and arm opcodes for early arch versions or
+	 * thumb only CPU. It is OK for this file to be used in combination
+	 * with other arch variants, since these code snippets are only
 	 * used as input data.
 	 */
 	.arch armv4t
-- 
1.8.1.4
