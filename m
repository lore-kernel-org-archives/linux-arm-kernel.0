From: Dave.Martin@arm.com (Dave Martin)
Date: Thu,  1 Mar 2018 17:44:06 +0000
Subject: [PATCH v2 1/3] signal: Add FPE_FLTUNK si_code for undiagnosable fp
 exceptions
In-Reply-To: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1519926248-12591-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures cannot always report accurately what kind of
floating-point exception triggered a floating-point exception trap.

This can occur with fp exceptions occurring on lanes in a vector
instruction on arm64 for example.

Rather than have every architecture come up with its own way of
describing such a condition, this patch adds a common FPE_FLTUNK
si_code value to report that an fp exception caused a trap but we
cannot be certain which kind of fp exception it was.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

--

Changes since v1:

Reported by James Morse:

 * Bump NSIGFPE BUILD_BUG_ON() check for x86 compat.

   FPE_FLTUNK does not current have any implications for x86, since it
   is not currently used and has no implications for the way siginfo
   is populated.
---
 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index ac057f9..954ad99 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -26,7 +26,7 @@ static inline void signal_compat_build_tests(void)
 	 * new fields are handled in copy_siginfo_to_user32()!
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
-	BUILD_BUG_ON(NSIGFPE  != 13);
+	BUILD_BUG_ON(NSIGFPE  != 14);
 	BUILD_BUG_ON(NSIGSEGV != 4);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 4);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 85dc965..10304de 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -229,7 +229,8 @@ typedef struct siginfo {
 # define __FPE_INVASC	12	/* invalid ASCII digit */
 # define __FPE_INVDEC	13	/* invalid decimal digit */
 #endif
-#define NSIGFPE		13
+#define FPE_FLTUNK	14	/* undiagnosed floating-point exception */
+#define NSIGFPE		14
 
 /*
  * SIGSEGV si_codes
-- 
2.1.4
