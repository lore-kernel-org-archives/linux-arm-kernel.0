From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 11 Sep 2013 22:42:37 -0700
Subject: [PATCH] ARM: signal: sigreturn_codes fix build breakage for old arch
In-Reply-To: <1378964557-24520-1-git-send-email-victor.kamensky@linaro.org>
References: <1378964557-24520-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1378964557-24520-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After "ARM: signal: sigreturn_codes should be endian neutral to
work in BE8" patch, old platforms that use old -march values
(like armv3) fails to compile sigreturn_codes.S. The reason is
that for such arch values '.thumb' directive and thumb opcodes
are not allowed.

Fix it by manually setting explicit .arch directive to 'armv4t'
if build is done for lower values of __LINUX_ARM_ARCH__. Note
we do it only for lower __LINUX_ARM_ARCH__ values because
otherwise we want sigreturn_codes.o "File Attributes"
Tag_CPU_name, and Tag_CPU_arch tag values to match other .o
files.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/sigreturn_codes.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
index c888c43..3c5d0f2 100644
--- a/arch/arm/kernel/sigreturn_codes.S
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -30,6 +30,17 @@
  * snippets.
  */
 
+#if __LINUX_ARM_ARCH__ <= 4
+	/*
+	 * Note we manually set minimally required arch that supports
+	 * required thumb opcodes for early arch versions. It is OK
+	 * for this file to be used in combination with other
+	 * lower arch variants, since these code snippets are only
+	 * used as input data.
+	 */
+	.arch armv4t
+#endif
+
 	.section .rodata
 	.global sigreturn_codes
 	.type	sigreturn_codes, #object
-- 
1.8.1.4
