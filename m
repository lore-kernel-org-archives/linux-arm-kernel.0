From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 17 Jan 2018 17:42:19 +0000
Subject: [PATCH v2 1/2] arm64: capabilities: Clarify argument passed to enable
 call back
In-Reply-To: <20180117174220.7959-1-suzuki.poulose@arm.com>
References: <20180117174220.7959-1-suzuki.poulose@arm.com>
Message-ID: <20180117174220.7959-2-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We issue the enable() call back for all CPU hwcaps capabilities
available on the system, on all the CPUs. So far we have ignored
the argument passed to the call back, which had a prototype to
accept a "void *" for use with on_each_cpu() and later with
stop_machine(). However, with commit 0a0d111d40fd1
("arm64: cpufeature: Pass capability structure to ->enable callback"),
there are some users of the argument who wants the matching capability
struct pointer where there are multiple matching criteria for a single
capability. Changing the prototype is quite an invasive change and
will be part of a future series. For now, add a comment to clarify
what is expected.

Suggested-by: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ac67cfc2585a..c049e28274d4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -97,7 +97,14 @@ struct arm64_cpu_capabilities {
 	u16 capability;
 	int def_scope;			/* default scope */
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
-	int (*enable)(void *);		/* Called on all active CPUs */
+	/*
+	 * For each @capability set in CPU hwcaps, @enable() is called on all
+	 * active CPUs with const struct arm64_cpu_capabilities * as argument.
+	 * It is upto the callback (especially when multiple entries for the
+	 * same capability exists) to determine if any action should be taken
+	 * based on @matches() applies to thie CPU.
+	 */
+	int (*enable)(void *caps);
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
-- 
2.13.6
