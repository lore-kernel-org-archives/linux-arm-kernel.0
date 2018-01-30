From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 30 Jan 2018 18:50:41 +0000
Subject: [RFC PATCH v2 1/3] signal: Add FPE_FLTUNK si_code for undiagnosable
 fp exceptions
In-Reply-To: <1517338243-9749-1-git-send-email-Dave.Martin@arm.com>
References: <1517338243-9749-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1517338243-9749-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures cannot always report accurately what kind of
floating-point exception triggered a floating-point exception trap.

This can occur with fp exceptions occuring on lanes in a vector
instruction on arm64 for example.

Rather than have every architecture come up with its own way of
descrbing such a condition, this patch adds a common FPE_FLTUNK do
report that an fp exception caused a trap but we cannot be certain
which kind of fp exception it was.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 include/uapi/asm-generic/siginfo.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 254afc3..450b31f 100644
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
