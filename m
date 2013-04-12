From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 12 Apr 2013 16:09:59 +0100
Subject: [PATCH] arm64: remove PSR bit macros from uapi
Message-ID: <1365779399-16654-1-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exposing these in ptrace.h ends up polluting the namespace for user
applications which include headers such as <signal.h>, e.g. when building Xen
userspace tools on arm64:

tools/include/xen/arch-arm.h:229:0: error: "PSR_MODE_EL0t" redefined [-Werror]
In file included from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/user.h:25:0,
                 from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/procfs.h:34,
                 from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/sys/ucontext.h:26,
                 from /usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/signal.h:360,
                 from xentrace.c:21:
/usr/lib/gcc-cross/aarch64-linux-gnu/4.7/../../../../aarch64-linux-gnu/include/asm/ptrace.h:30:0: note: this is the location of the previous definition

I think these were brought over as part of the uapi transition in error
because they were not protected by the __KERNEL__ define.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: xen-devel at lists.xen.org
---
 arch/arm64/include/asm/ptrace.h      |   34 ++++++++++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/ptrace.h |   36 ----------------------------------
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 4ce845f..758e41e 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -21,6 +21,40 @@
 
 #include <uapi/asm/ptrace.h>
 
+/*
+ * PSR bits
+ */
+#define PSR_MODE_EL0t	0x00000000
+#define PSR_MODE_EL1t	0x00000004
+#define PSR_MODE_EL1h	0x00000005
+#define PSR_MODE_EL2t	0x00000008
+#define PSR_MODE_EL2h	0x00000009
+#define PSR_MODE_EL3t	0x0000000c
+#define PSR_MODE_EL3h	0x0000000d
+#define PSR_MODE_MASK	0x0000000f
+
+/* AArch32 CPSR bits */
+#define PSR_MODE32_BIT		0x00000010
+
+/* AArch64 SPSR bits */
+#define PSR_F_BIT	0x00000040
+#define PSR_I_BIT	0x00000080
+#define PSR_A_BIT	0x00000100
+#define PSR_D_BIT	0x00000200
+#define PSR_Q_BIT	0x08000000
+#define PSR_V_BIT	0x10000000
+#define PSR_C_BIT	0x20000000
+#define PSR_Z_BIT	0x40000000
+#define PSR_N_BIT	0x80000000
+
+/*
+ * Groups of PSR bits
+ */
+#define PSR_f		0xff000000	/* Flags		*/
+#define PSR_s		0x00ff0000	/* Status		*/
+#define PSR_x		0x0000ff00	/* Extension		*/
+#define PSR_c		0x000000ff	/* Control		*/
+
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
 #define COMPAT_PTRACE_SETREGS		13
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 6913643..fd3ed98 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -23,42 +23,6 @@
 
 #include <asm/hwcap.h>
 
-
-/*
- * PSR bits
- */
-#define PSR_MODE_EL0t	0x00000000
-#define PSR_MODE_EL1t	0x00000004
-#define PSR_MODE_EL1h	0x00000005
-#define PSR_MODE_EL2t	0x00000008
-#define PSR_MODE_EL2h	0x00000009
-#define PSR_MODE_EL3t	0x0000000c
-#define PSR_MODE_EL3h	0x0000000d
-#define PSR_MODE_MASK	0x0000000f
-
-/* AArch32 CPSR bits */
-#define PSR_MODE32_BIT		0x00000010
-
-/* AArch64 SPSR bits */
-#define PSR_F_BIT	0x00000040
-#define PSR_I_BIT	0x00000080
-#define PSR_A_BIT	0x00000100
-#define PSR_D_BIT	0x00000200
-#define PSR_Q_BIT	0x08000000
-#define PSR_V_BIT	0x10000000
-#define PSR_C_BIT	0x20000000
-#define PSR_Z_BIT	0x40000000
-#define PSR_N_BIT	0x80000000
-
-/*
- * Groups of PSR bits
- */
-#define PSR_f		0xff000000	/* Flags		*/
-#define PSR_s		0x00ff0000	/* Status		*/
-#define PSR_x		0x0000ff00	/* Extension		*/
-#define PSR_c		0x000000ff	/* Control		*/
-
-
 #ifndef __ASSEMBLY__
 
 /*
-- 
1.7.2.5
