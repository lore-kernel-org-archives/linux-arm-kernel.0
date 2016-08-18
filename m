From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Aug 2016 12:02:43 +0200
Subject: [PATCH v3 4/4] arm64: kernel: avoid brute force search on PLT
 generation
In-Reply-To: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1471514563-28172-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given that we now sort the relocation sections in a way that guarantees
that entries that can share a single PLT entry end up adjacently, there
is no a longer a need to go over the entire list to look for an existing
entry that matches our jump target. If such a match exists, it was the
last one to be emitted, so we can simply check the preceding slot.

Note that this will still work correctly in the [theoretical] presence of
call/jump relocations against SHN_UNDEF symbols with non-zero addends,
although not optimally. Since the relocations are presented in the same
order that we checked them for duplicates, any duplicates that we failed
to spot the first time around will be accounted for in the PLT allocation
so there is guaranteed to be sufficient space for them when actually
emitting the PLT.

For instance, the following sequence of relocations:

  000004d8  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  000004fc  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  0000050e  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  00000520  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  00000532  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  00000544  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  00000556  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  00000568  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  0000057a  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  0000058c  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  0000059e  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  000005b0  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  000005c2  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null
  000005d4  00058b0a R_ARM_THM_CALL    00000000   warn_slowpath_null

may result in several PLT entries to be allocated, and also emitted, if
any of the entries in the middle refer to a Place that contains a non-zero
addend (i.e., one for all the preceding zero-addend relocations, one for
all the following zero-addend relocations, and one for the non-zero addend
relocation itself)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/module-plts.c | 60 +++++++++++---------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 5b000ea64fa4..a910f1db0c14 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -33,35 +33,39 @@ struct plt_entries {
 
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 {
-	struct plt_entries *plt, *plt_end;
-	int c;
-
-	plt = (void *)mod->arch.plt->sh_addr;
-	plt_end = (void *)plt + mod->arch.plt->sh_size;
-
-	/* Look for an existing entry pointing to 'val' */
-	for (c = mod->arch.plt_count; plt < plt_end; c -= PLT_ENT_COUNT, plt++) {
-		int i;
-
-		if (!c) {
-			/* Populate a new set of entries */
-			*plt = (struct plt_entries){
-				{ [0 ... PLT_ENT_COUNT - 1] = PLT_ENT_LDR, },
-				{ val, }
-			};
-			mod->arch.plt_count++;
-			return (u32)plt->ldr;
-		}
-		for (i = 0; i < PLT_ENT_COUNT; i++) {
-			if (!plt->lit[i]) {
-				plt->lit[i] = val;
-				mod->arch.plt_count++;
-			}
-			if (plt->lit[i] == val)
-				return (u32)&plt->ldr[i];
-		}
+	struct plt_entries *plt = (struct plt_entries *)mod->arch.plt->sh_addr;
+	int idx = 0;
+
+	/*
+	 * Look for an existing entry pointing to 'val'. Given that the
+	 * relocations are sorted, this will be the last entry we allocated.
+	 * (if one exists).
+	 */
+	if (mod->arch.plt_count > 0) {
+		plt += (mod->arch.plt_count - 1) / PLT_ENT_COUNT;
+		idx = (mod->arch.plt_count - 1) % PLT_ENT_COUNT;
+
+		if (plt->lit[idx] == val)
+			return (u32)&plt->ldr[idx];
+
+		idx = (idx + 1) % PLT_ENT_COUNT;
+		if (!idx)
+			plt++;
 	}
-	BUG();
+
+	mod->arch.plt_count++;
+	BUG_ON(mod->arch.plt_count * PLT_ENT_SIZE > mod->arch.plt->sh_size);
+
+	if (!idx)
+		/* Populate a new set of entries */
+		*plt = (struct plt_entries){
+			{ [0 ... PLT_ENT_COUNT - 1] = PLT_ENT_LDR, },
+			{ val, }
+		};
+	else
+		plt->lit[idx] = val;
+
+	return (u32)&plt->ldr[idx];
 }
 
 #define cmp_3way(a,b)	((a) < (b) ? -1 : (a) > (b))
-- 
2.7.4
