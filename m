From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:17 +0000
Subject: [RFC PATCH 29/29] arm64/sve: Limit vector length to 512 bits by
 default
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-30-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a transitional workaround for userspace incompatibilities caused
by enlargement of the signal frame, this patch adds a new config
option CONFIG_ARM64_SVE_FULL_VECTOR_LENGTH, which default to n.

Unless this option is set to y, the vector length for SVE will be
limited to 512 bits.  This leaves a bit of free space for other
architecture extensions just in case we need it.

This option will be removed and replaced with a user/kernel control
interface in the future.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig   | 35 +++++++++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S |  5 +++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bf9915cb..7cd9812 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -887,6 +887,41 @@ config ARM64_SVE
 
 	  To enable use of this extension on CPUs that implement it, say Y.
 
+if ARM64_SVE
+
+config ARM64_SVE_FULL_VECTOR_LENGTH
+	bool "Enable full hardware vector length for userspace"
+	default n
+	help
+	  SVE vector lengths greater than 512 bits impact the size of signal
+	  frames and therefore the size requirements for any userspace stack
+	  onto which a signal may be delivered.  Using larger vector lengths
+	  may therefore cause problems for some software.  For this reason, the
+	  kernel currently limits the maximum vector length for userspace
+	  software to 512 bits by default.
+
+	  Enabling this option removes the limit, so that the full vector
+	  length implemented by the hardware is made available to userspace.
+
+	  Be aware: in general, software that (a) does not use SVE (including
+	  via libraries), or (b) does not handle signals, or (c) uses default
+	  process/thread stack sizes and does not use sigaltstack(2) should be
+	  unaffected by enabling larger vectors.  Software that does not meet
+	  these criteria or that relies on certain legacy uses of the ucontext
+	  API may be affected however.
+
+	  This is a transitional compatibility option only and will be replaced
+	  by a userspace ABI extension in the future.  Do not assume that this
+	  option will be available with compatible effect in future Linux
+	  releases.
+
+	  If you are developing software that uses SVE and understand the
+	  implications, you can consider saying Y here.
+
+	  If unsure, say N.
+
+endif
+
 config ARM64_MODULE_CMODEL_LARGE
 	bool
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 1da8160..a2839e6 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -198,6 +198,11 @@ ENTRY(__cpu_setup)
 
 	mrs_s	x5, ZIDR_EL1			// SVE: Enable full vector len
 	and	x5, x5, #ZCR_EL1_LEN_MASK	// initially
+#ifndef CONFIG_ARM64_SVE_FULL_VECTOR_LENGTH
+	mov	x6, #(512 / 128 - 1)		// Clamp VL to 512 bits
+	cmp	x5, x6
+	csel	x5, x5, x6, lo
+#endif
 	msr_s	ZCR_EL1, x5
 
 	b	2f
-- 
2.1.4
