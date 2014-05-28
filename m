From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 May 2014 12:24:50 +0100
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140527143745.386c77d9@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
 <20140527135216.7eaf3b3f@free-electrons.com>
 <20140527121806.GF3693@n2100.arm.linux.org.uk>
 <20140527143745.386c77d9@free-electrons.com>
Message-ID: <20140528112450.GH3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 02:37:45PM +0200, Thomas Petazzoni wrote:
> How do we address the problem that Armada 370 has different
> requirements than the other I/O coherency SoC ? In RFC PATCHv2, it was
> solved by having:
> 
>  * Armada 370 needs only write-allocate and does not work with
>    shareable pages. Since write-allocate was becoming the default for
>    ARMv6+, this requirement was met. And since Armada 370 is recognized
>    as non-SMP by the SMP_ON_UP, is_smp() continues to return false, and
>    shareable pages are not used.
> 
>  * Armada XP/375/38x need both write-allocate and shareable pages.
>    Write-allocate is coming from the fact that i was becoming the
>    default for ARMv6+. The shareable pages were coming from the fact
>    that is_smp() returns true when SMP_ON_UP is enabled.

But the way you go about this is totally silly - you effectively end
up enabling all the SMP stuff even though you don't need it (which means
that on a SMP kernel, you end up with a bunch of extra stuff on those
platforms which aren't SMP, just because you want maybe one or two
is_smp() sites to return true.

How about this patch for a start - which incidentally fixes two minor
bugs where specifying cachepolicy=<anything> on ARMv6 provokes a warning,
and sets the policy to writeback read-allocate, only to have it overriden
later.  The second bug is that we "hoped" that is_smp() reflects the asm
code's page table setup - this patch makes it more explicit by reading
the PMD flags, finding the appropriate entry in the table, and setting
the cache policy to that.  I've left the is_smp() check in because we
really do want to detect if something goes awry there.

However, the effect of this patch is that the C code now follows how
the assembly code sets up the page tables, which means that this is now
controllable via the PMD MMU flags in the assembly procinfo structure.
This means that for the Armada devices which need write-alloc for
coherency, you can specify that in the proc-*.S files - yes, it means
that you need a separate entry.

We should probably do a similar thing for the shared flag, but that's
something which can come after this patch.

8<==
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: ARMv6: ensure C page table setup code follows assembly
 code

Fix a long standing minor bug where, for ARMv6, we don't enforce the C
code setting the same cache policy as the assembly code.  This was
introduced partially by commit 11179d8ca28d ([ARM] 4497/1: Only allow
safe cache configurations on ARMv6 and later) and also by adding SMP
support.

This patch sets the default cache policy based on the flags used by the
assembly code, and then ensures that when a cache policy command line
argument is used, we verify that on ARMv6, it matches the initial setup.

This has the side effect that the C code will now follow the settings
that the proc-*.S files use, effectively allowing them to control the
policy.  This is desirable for coherency support, which, like SMP, also
requires write-allocate cache mode.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c |  5 +++-
 arch/arm/mm/mmu.c       | 63 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index df21f9f98945..aa516bc4ca30 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -72,6 +72,7 @@ static int __init fpe_setup(char *line)
 __setup("fpe=", fpe_setup);
 #endif
 
+extern void init_default_cache_policy(unsigned long);
 extern void paging_init(const struct machine_desc *desc);
 extern void early_paging_init(const struct machine_desc *,
 			      struct proc_info_list *);
@@ -603,7 +604,9 @@ static void __init setup_processor(void)
 #ifndef CONFIG_ARM_THUMB
 	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
 #endif
-
+#ifdef CONFIG_CPU_CP15
+	init_default_cache_policy(list->__cpu_mm_mmu_flags);
+#endif
 	erratum_a15_798181_init();
 
 	feat_v6_fixup();
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a476051c0567..704ff018e67b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -118,6 +118,29 @@ static struct cachepolicy cache_policies[] __initdata = {
 };
 
 #ifdef CONFIG_CPU_CP15
+/*
+ * Initialise the cache_policy variable with the initial state specified
+ * via the "pmd" value.  This is used to ensure that on ARMv6 and later,
+ * the C code sets the page tables up with the same policy as the head
+ * assembly code, which avoids an illegal state where the TLBs can get
+ * confused.  See comments in early_cachepolicy() for more information.
+ */
+void __init init_default_cache_policy(unsigned long pmd)
+{
+	int i;
+
+	pmd &= PMD_SECT_TEX(1) | PMD_SECT_BUFFERABLE | PMD_SECT_CACHEABLE;
+
+	for (i = 0; i < ARRAY_SIZE(cache_policies); i++)
+		if (cache_policies[i].pmd == pmd) {
+			cachepolicy = i;
+			break;
+		}
+
+	if (i == ARRAY_SIZE(cache_policies))
+		pr_err("ERROR: could not find cache policy\n");
+}
+
 unsigned long __init __clear_cr(unsigned long mask)
 {
 	cr_alignment = cr_alignment & ~mask;
@@ -125,27 +148,26 @@ unsigned long __init __clear_cr(unsigned long mask)
 }
 
 /*
- * These are useful for identifying cache coherency
- * problems by allowing the cache or the cache and
- * writebuffer to be turned off.  (Note: the write
- * buffer should not be on and the cache off).
+ * These are useful for identifying cache coherency problems by allowing
+ * the cache or the cache and writebuffer to be turned off.  (Note: the
+ * write buffer should not be on and the cache off).
  */
 static int __init early_cachepolicy(char *p)
 {
-	unsigned long cr = get_cr();
-	int i;
+	int i, selected = -1;
 
 	for (i = 0; i < ARRAY_SIZE(cache_policies); i++) {
 		int len = strlen(cache_policies[i].policy);
 
 		if (memcmp(p, cache_policies[i].policy, len) == 0) {
-			cachepolicy = i;
-			cr = __clear_cr(cache_policies[i].cr_mask);
+			selected = i;
 			break;
 		}
 	}
-	if (i == ARRAY_SIZE(cache_policies))
-		printk(KERN_ERR "ERROR: unknown or unsupported cache policy\n");
+
+	if (selected == -1)
+		pr_err("ERROR: unknown or unsupported cache policy\n");
+
 	/*
 	 * This restriction is partly to do with the way we boot; it is
 	 * unpredictable to have memory mapped using two different sets of
@@ -153,12 +175,18 @@ static int __init early_cachepolicy(char *p)
 	 * change these attributes once the initial assembly has setup the
 	 * page tables.
 	 */
-	if (cpu_architecture() >= CPU_ARCH_ARMv6) {
-		printk(KERN_WARNING "Only cachepolicy=writeback supported on ARMv6 and later\n");
-		cachepolicy = CPOLICY_WRITEBACK;
+	if (cpu_architecture() >= CPU_ARCH_ARMv6 && selected != cachepolicy) {
+		pr_warn("Only cachepolicy=%s supported on ARMv6 and later\n",
+			cache_policies[cachepolicy].policy);
+		return 0;
+	}
+
+	if (selected != cachepolicy) {
+		unsigned long cr = __clear_cr(cache_policies[selected].cr_mask);
+		cachepolicy = selected;
+		flush_cache_all();
+		set_cr(cr);
 	}
-	flush_cache_all();
-	set_cr(cr);
 	return 0;
 }
 early_param("cachepolicy", early_cachepolicy);
@@ -392,8 +420,11 @@ static void __init build_mem_type_table(void)
 			cachepolicy = CPOLICY_WRITEBACK;
 		ecc_mask = 0;
 	}
-	if (is_smp())
+
+	if (is_smp() && cachepolicy != CPOLICY_WRITEALLOC) {
+		pr_warn("Forcing write-allocate cache policy for SMP\n");
 		cachepolicy = CPOLICY_WRITEALLOC;
+	}
 
 	/*
 	 * Strip out features not present on earlier architectures.
-- 
1.8.3.1



-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
