From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 21:03:17 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919120954.GA20314@opensource.wolfsonmicro.com>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
Message-ID: <20110919200317.GC16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:
> I'm seeing linker failures in -next as of today:
> 
> `.exit.text' referenced in section `__bug_table' of fs/built-in.o:
> defined in discarded section `.exit.text' of fs/built-in.o
> `.exit.text' referenced in section `__bug_table' of crypto/built-in.o:
> defined in discarded section `.exit.text' of crypto/built-in.o
> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
> defined in discarded section `.exit.text' of net/built-in.o
> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
> defined in discarded section `.exit.text' of net/built-in.o
> 
> which appears to be due to the chnage to use generic BUG() introduced in
> commit 5254a3 (ARM: 7017/1: Use generic BUG() handler), reverting that
> commit resolves the issue for me.

This might solve the problem - could you check please?

 arch/arm/kernel/vmlinux.lds.S |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7b2541e..20b3041 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -24,8 +24,10 @@
 #if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
 	defined(CONFIG_GENERIC_BUG)
 #define ARM_EXIT_KEEP(x)	x
+#define ARM_EXIT_DISCARD(x)
 #else
 #define ARM_EXIT_KEEP(x)
+#define ARM_EXIT_DISCARD(x)	x
 #endif
 
 OUTPUT_ARCH(arm)
@@ -40,6 +42,11 @@ jiffies = jiffies_64 + 4;
 SECTIONS
 {
 	/*
+	 * XXX: The linker does not define how output sections are
+	 * assigned to input sections when there are multiple statements
+	 * matching the same input section name.  There is no documented
+	 * order of matching.
+	 *
 	 * unwind exit sections must be discarded before the rest of the
 	 * unwind sections get included.
 	 */
@@ -48,6 +55,9 @@ SECTIONS
 		*(.ARM.extab.exit.text)
 		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
 		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
+		ARM_EXIT_DISCARD(EXIT_TEXT)
+		ARM_EXIT_DISCARD(EXIT_DATA)
+		EXIT_CALL
 #ifndef CONFIG_HOTPLUG
 		*(.ARM.exidx.devexit.text)
 		*(.ARM.extab.devexit.text)
@@ -59,6 +69,8 @@ SECTIONS
 #ifndef CONFIG_SMP_ON_UP
 		*(.alt.smp.init)
 #endif
+		*(.discard)
+		*(.discard.*)
 	}
 
 #ifdef CONFIG_XIP_KERNEL
@@ -280,9 +292,6 @@ SECTIONS
 
 	STABS_DEBUG
 	.comment 0 : { *(.comment) }
-
-	/* Default discards */
-	DISCARDS
 }
 
 /*
