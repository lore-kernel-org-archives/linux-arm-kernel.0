From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Jul 2015 16:37:47 +0100
Subject: [PATCH v3 7/9] arm64/debug: Add missing #includes
In-Reply-To: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
References: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1437752284-14847-8-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/debug-monitors.h> relies on <asm/ptrace.h>, but doesn't
declare this dependency.  This becomes a problem once
debug-monitors.h starts getting included all over the place to get
the BRK immedates.

The missing include of <asm/memory.h> (for UL()) in <asm/esr.h> is
also added.  The series no longer relies on this, but I spotted it
during development and it may as well get fixed.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |    3 +++
 arch/arm64/include/asm/esr.h            |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 6a17fb8..777c36a 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -18,8 +18,11 @@
 
 #ifdef __KERNEL__
 
+#include <linux/errno.h>
+#include <linux/types.h>
 #include <asm/esr.h>
 #include <asm/insn.h>
+#include <asm/ptrace.h>
 
 /* Low-level stepping controls. */
 #define DBG_MDSCR_SS		(1 << 0)
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 1b44cf6..77eeb2c 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -18,6 +18,8 @@
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
+#include <asm/memory.h>
+
 #define ESR_ELx_EC_UNKNOWN	(0x00)
 #define ESR_ELx_EC_WFx		(0x01)
 /* Unallocated EC: 0x02 */
-- 
1.7.10.4
