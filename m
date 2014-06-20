From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jun 2014 14:00:00 +0100
Subject: [PATCH v3 2/9] arm64: move DBG_MDSCR_* to asm/debug-monitors.h
In-Reply-To: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403269207-1625-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to use the DBG_MDSCR_* macros from the KVM code,
move the relevant definitions to the obvious include file.

Also move the debug_el enum to a portion of the file that is guarded
by #ifndef __ASSEMBLY__ in order to use that file from assembly code.

Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h | 19 ++++++++++++++-----
 arch/arm64/kernel/debug-monitors.c      |  9 ---------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 6e9b5b3..7fb3437 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -18,6 +18,15 @@
 
 #ifdef __KERNEL__
 
+/* Low-level stepping controls. */
+#define DBG_MDSCR_SS		(1 << 0)
+#define DBG_SPSR_SS		(1 << 21)
+
+/* MDSCR_EL1 enabling bits */
+#define DBG_MDSCR_KDE		(1 << 13)
+#define DBG_MDSCR_MDE		(1 << 15)
+#define DBG_MDSCR_MASK		~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
+
 #define	DBG_ESR_EVT(x)		(((x) >> 27) & 0x7)
 
 /* AArch64 */
@@ -73,11 +82,6 @@
 
 #define CACHE_FLUSH_IS_SAFE		1
 
-enum debug_el {
-	DBG_ACTIVE_EL0 = 0,
-	DBG_ACTIVE_EL1,
-};
-
 /* AArch32 */
 #define DBG_ESR_EVT_BKPT	0x4
 #define DBG_ESR_EVT_VECC	0x5
@@ -115,6 +119,11 @@ void unregister_break_hook(struct break_hook *hook);
 
 u8 debug_monitors_arch(void);
 
+enum debug_el {
+	DBG_ACTIVE_EL0 = 0,
+	DBG_ACTIVE_EL1,
+};
+
 void enable_debug_monitors(enum debug_el el);
 void disable_debug_monitors(enum debug_el el);
 
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index a7fb874..e022f87 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -30,15 +30,6 @@
 #include <asm/cputype.h>
 #include <asm/system_misc.h>
 
-/* Low-level stepping controls. */
-#define DBG_MDSCR_SS		(1 << 0)
-#define DBG_SPSR_SS		(1 << 21)
-
-/* MDSCR_EL1 enabling bits */
-#define DBG_MDSCR_KDE		(1 << 13)
-#define DBG_MDSCR_MDE		(1 << 15)
-#define DBG_MDSCR_MASK		~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
-
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
 {
-- 
1.8.3.4
