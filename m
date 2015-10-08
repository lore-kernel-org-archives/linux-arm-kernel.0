From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 16:03:46 +0100
Subject: [PATCH v2 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <56163D7F.4000003@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-8-git-send-email-suzuki.poulose@arm.com>
 <20151007171621.GD17192@e104818-lin.cambridge.arm.com>
 <56163D7F.4000003@arm.com>
Message-ID: <20151008150346.GK17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 10:55:11AM +0100, Suzuki K. Poulose wrote:
> >>@@ -82,6 +114,22 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
> >>  	return (s64)(features << (64 - 4 - field)) >> (64 - 4);
> >>  }
> >>
> >>+static inline s64 __attribute_const__
> >>+cpuid_feature_extract_field_width(u64 features, int field, u8 width)
> >>+{
> >>+	return (s64)(features << (64 - width - field)) >> (64 - width);
> >>+}
> >
> >I think you should rewrite cpuid_feature_extract_field() in terms of the
> >_width one (the latter being more generic).
> >
> 
> OK, somehow, I was thinking that cpuid_feature_extract_field() could be
> optimised by the compiler for a fixed width of for. Hence didn't change it.

Since both are static inline, the compiler should be smart enough to
optimise it already.

> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>index 1ae8b24..d42ad90 100644
> >>--- a/arch/arm64/kernel/cpufeature.c
> >>+++ b/arch/arm64/kernel/cpufeature.c
> >>@@ -58,8 +58,442 @@ static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
> >>  	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
> >>  }
> >>
> >>+#define ARM64_FTR_BITS(ftr_strict, ftr_type, ftr_shift, ftr_width, ftr_safe_val) \
> >>+	{							\
> >>+		.strict = ftr_strict,				\
> >>+		.type = ftr_type,				\
> >>+		.shift = ftr_shift,				\
> >>+		.width = ftr_width,				\
> >>+		.safe_val = ftr_safe_val,			\
> >>+	}
> >
> >You can drop "ftr_" from all the arguments, it makes the macro
> >definition shorter.
> 
> In fact I tried that before, but then the macro expansion will replace the
> field names with the supplied values and hence won't compile. Either we
> should change the field names or the values.

OK, keep them in this case.

> >[...]
> >>+static struct arm64_ftr_bits ftr_id_pfr0[] = {
> >>+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 16, 16, 0),	// RAZ
> >>+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 12, 4, 0),	// State3
> >>+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 8, 4, 0),	// State2
> >>+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 4, 0),	// State1
> >>+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 4, 0),	// State0
> >>+	ARM64_FTR_END,
> >>+};
> >
> >Do we care about the RAZ/RAO fields? Or we use this later to check a new
> >CPU's compatibility with the overall features?
> 
> Its just for sanity checks.
> 
> >Also, you captured lots of fields that Linux does not care about. Is it
> >possible to ignore them altogether, only keep those which are relevant.
> >
> 
> The list is entierly from the SANITY check. If there are any registers
> that we think need not be cross checked, we could get rid of them.

So we have three types of fields in these registers:

a) features defined but not something we care about in Linux
b) reserved fields
c) features important to Linux

I guess for (a), Linux may not even care if they don't match (though we
need to be careful which fields we ignore). As for (b), even if they
differ, since we don't know the meaning at this point, I think we should
just ignore them. If, for example, they add a feature that Linux doesn't
care about, they practically fall under the (a) category.

Regarding exposing reserved CPUID fields to user, I assume we would
always return 0.

> >>+ * sys_reg() encoding.
> >>+ *
> >>+ * We track only the following space:
> >>+ * Op0 = 3, Op1 = 0, CRn = 0, CRm = [1 - 7], Op2 = [0 - 7]
> >>+ * Op0 = 3, Op1 = 3, CRn = 0, CRm = 0, Op2 = { 1, 7 } 	(CTR, DCZID)
> >>+ * Op0 = 3, Op1 = 3, CRn = 14, CRm = 0, Op2 = 0		(CNTFRQ)
> >>+ *
> >>+ * The space (3, 0, 0, {1-7}, {0-7}) is arranged in a 2D array op1_0,
> >>+ * indexed by CRm and Op2. Since not all CRm's have fully allocated Op2's
> >>+ * arm64_reg_table[CRm-1].n indicates the largest Op2 tracked for CRm.
> >>+ *
> >>+ * Since we have limited number of entries with Op1 = 3, we use linear search
> >>+ * to find the reg.
> >>+ *
> >>+ */
> >>+static struct arm64_ftr_reg* get_arm64_sys_reg(u32 sys_id)
> >>+{
> >>+	int i;
> >>+	u8 op2, crn, crm;
> >>+	u8 op1 = sys_reg_Op1(sys_id);
> >>+
> >>+	if (sys_reg_Op0(sys_id) != 3)
> >>+		return NULL;
> >>+	switch (op1) {
> >>+	case 0:
> >>+
> >>+		crm = sys_reg_CRm(sys_id);
> >>+		op2 = sys_reg_Op2(sys_id);
> >>+		crn = sys_reg_CRn(sys_id);
> >>+		if (crn || !crm || crm > 7)
> >>+			return NULL;
> >>+		if (op2 < op1_0[crm - 1].n &&
> >>+			op1_0[crm - 1].regs[op2].sys_id == sys_id)
> >>+			return &op1_0[crm - 1].regs[op2];
> >>+		return NULL;
> >>+	case 3:
> >>+		for (i = 0; i < ARRAY_SIZE(op1_3); i++)
> >>+			if (op1_3[i].sys_id == sys_id)
> >>+				return &op1_3[i];
> >>+	}
> >>+	return NULL;
> >>+}
[...]
> >Is this function ever called on a hot path? If not, just keep everything
> >in an array and do a linear search rather than having different arrays
> >based on op*. Especially if we managed to limit the number of registers
> >to only those that Linux cares about.
> 
> I started with linear array in the RFC post. But since then the number of
> users for the API has gone up. Hence thought of optimising it. The only
> 'intensive' user is SANITY check for each register at CPU bring up.

This shouldn't be that bad since it's not happening very often. However,
do we need this thing for MRS emulation (not many registers though)? You
could use a binary search (something like radix tree seems overkill)

-- 
Catalin
