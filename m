From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 14:19:28 +0100
Subject: [GIT PULL] nommu-fixes, r7 and MPU support for 3.11
In-Reply-To: <51B27207.8060208@arm.com>
References: <51B232CA.9060700@arm.com> <51B27207.8060208@arm.com>
Message-ID: <20130617131927.GE2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 12:51:35AM +0100, Jonathan Austin wrote:
> This is rebased (and re-tested) on your devel-stable branch because
> otherwise there were going to be conflicts with Uwe's V7M work now that
> you've merged that. I've included the fix for limiting MPU to CPU_V7.

It looks like you have some rebasing errors:

In your 75709659007e7c33153129082bd85dfb74427078:

@@ -1414,7 +1414,8 @@ config SMP
        depends on CPU_V6K || CPU_V7
        depends on GENERIC_CLOCKEVENTS
        depends on HAVE_SMP
-       depends on MMU
+       depends on MMU || ARM_MPU
+       select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP

Yet, 4c3ffffdbca2e6f6f5125fa7b149d87a13f92c94 (ARM: Push selects for TWD/SCU into
machine entries), that select was removed because it was moved elsewhere:

@@ -1400,7 +1402,6 @@ config SMP
        depends on GENERIC_CLOCKEVENTS
        depends on HAVE_SMP
        depends on MMU
-       select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP

In arch/arm/include/asm/tlbflush.h:

+static inline void local_flush_tlb_all(void)                                                                  { }

Yes, the lines are really that long - needlessly.  What's wrong with:

+static inline void local_flush_tlb_all(void)
+{
+}

?

+               if ((cpsr & MODE32_BIT) && !IS_ENABLED(CONFIG_ARM_MPU)) {
                        /*
                         * 32-bit code can use the new high-page
-                        * signal return code support.
+                        * signal return code support except when the MPU has
+                        * protected the vectors page from PL0

Note that this means you can't support NX, because you need your stack to
be executable.  You need to ensure that arm_elf_read_implies_exec()
returns appropriately for MPU (it needs to return 1 for MPU.)
