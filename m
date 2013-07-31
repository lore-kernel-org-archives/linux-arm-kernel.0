From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 31 Jul 2013 13:06:58 -0400
Subject: [PATCH] arm: add .text at __CPUINIT places to prevent section
 grandfathering
In-Reply-To: <20130731094352.GV24642@n2100.arm.linux.org.uk>
References: <20130731094352.GV24642@n2100.arm.linux.org.uk>
Message-ID: <1375290418-1848-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 22f0a27367742f65130c0fb25ef00f7297e032c1
("init.h: remove __cpuinit sections from the kernel") the macros
like __CPUINIT were converted from .section commands to no-ops.

This caused CPU hotplug regressions because the code following
the __CPUINIT lines was now grandfathered into whatever the
previous section happened to be.  In most files, __CPUINIT was
at the top of the file, so there was no previous section.

However in the files changed here, there was a previous section,
and so we'd inadvertently garbage collect CPU hotplug related
code.  This changeset inserts ".text" into the exact same spot
that the __CPUINIT section markers were found prior to commit
8bd26e3a7e49af2697449bbcb7187a39dc85d672 ("arm: delete
__cpuinit/__CPUINIT usage from all ARM users:) in the three affected
files, as suggested by Russell.

Bisected-by: Simon Horman <horms@verge.net.au>
Reported-by: Magnus Damm <magnus.damm@gmail.com>
Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[NB: Untested - I've not got an SMP ARM handy at the moment]

 arch/arm/kernel/head-common.S | 1 +
 arch/arm/kernel/head-nommu.S  | 1 +
 arch/arm/kernel/head.S        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 47cd974..def853e 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -149,6 +149,7 @@ ENDPROC(lookup_processor_type)
  *	r5 = proc_info pointer in physical address space
  *	r9 = cpuid (preserved)
  */
+	.text
 __lookup_processor_type:
 	adr	r3, __lookup_processor_type_data
 	ldmia	r3, {r4 - r6}
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index b361de1..14235ba 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -87,6 +87,7 @@ ENTRY(stext)
 ENDPROC(stext)
 
 #ifdef CONFIG_SMP
+	.text
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 9cf6063..2c7cc1e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -343,6 +343,7 @@ __turn_mmu_on_loc:
 	.long	__turn_mmu_on_end
 
 #if defined(CONFIG_SMP)
+	.text
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
-- 
1.8.1.2
