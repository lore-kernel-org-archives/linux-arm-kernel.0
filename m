From: steve.capper@arm.com (Steve Capper)
Date: Thu, 10 May 2018 17:23:45 +0100
Subject: [PATCH v3 6/8] arm64: module-plts: Extend veneer to address 52-bit VAs
In-Reply-To: <20180510162347.3858-1-steve.capper@arm.com>
References: <20180510162347.3858-1-steve.capper@arm.com>
Message-ID: <20180510162347.3858-7-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Bieusheuval <ard.biesheuvel@linaro.org>

In preparation for 52-bit VA support in the Linux kernel, we extend the
plts veneer to support 52-bit addresses via an extra movk instruction.

[Steve: code from Ard off-list, changed the #ifdef logic to inequality]
Signed-off-by: Steve Capper <steve.capper@arm.com>

---

New in V3 of the series.

I'm not sure if this is strictly necessary as the VAs of the module
space will fit within 48-bits of addressing even when a 52-bit VA space
is enabled. However, this may act to future-proof the 52-bit VA support
should any future adjustments be made to the VA space.
---
 arch/arm64/include/asm/module.h | 13 ++++++++++++-
 arch/arm64/kernel/module-plts.c | 12 ++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 97d0ef12e2ff..30b8ca95d19a 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -59,6 +59,9 @@ struct plt_entry {
 	__le32	mov0;	/* movn	x16, #0x....			*/
 	__le32	mov1;	/* movk	x16, #0x...., lsl #16		*/
 	__le32	mov2;	/* movk	x16, #0x...., lsl #32		*/
+#if CONFIG_ARM64_VA_BITS > 48
+	__le32  mov3;   /* movk x16, #0x...., lsl #48		*/
+#endif
 	__le32	br;	/* br	x16				*/
 };
 
@@ -71,7 +74,8 @@ static inline struct plt_entry get_plt_entry(u64 val)
 	 * +--------+------------+--------+-----------+-------------+---------+
 	 *
 	 * Rd     := 0x10 (x16)
-	 * hw     := 0b00 (no shift), 0b01 (lsl #16), 0b10 (lsl #32)
+	 * hw     := 0b00 (no shift), 0b01 (lsl #16), 0b10 (lsl #32),
+	 *           0b11 (lsl #48)
 	 * opc    := 0b11 (MOVK), 0b00 (MOVN), 0b10 (MOVZ)
 	 * sf     := 1 (64-bit variant)
 	 */
@@ -79,6 +83,9 @@ static inline struct plt_entry get_plt_entry(u64 val)
 		cpu_to_le32(0x92800010 | (((~val      ) & 0xffff)) << 5),
 		cpu_to_le32(0xf2a00010 | ((( val >> 16) & 0xffff)) << 5),
 		cpu_to_le32(0xf2c00010 | ((( val >> 32) & 0xffff)) << 5),
+#if CONFIG_ARM64_VA_BITS > 48
+		cpu_to_le32(0xf2e00010 | ((( val >> 48) & 0xffff)) << 5),
+#endif
 		cpu_to_le32(0xd61f0200)
 	};
 }
@@ -86,6 +93,10 @@ static inline struct plt_entry get_plt_entry(u64 val)
 static inline bool plt_entries_equal(const struct plt_entry *a,
 				     const struct plt_entry *b)
 {
+#if CONFIG_ARM64_VA_BITS > 48
+	if (a->mov3 != b->mov3)
+		return false;
+#endif
 	return a->mov0 == b->mov0 &&
 	       a->mov1 == b->mov1 &&
 	       a->mov2 == b->mov2;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index f0690c2ca3e0..4d5617e09943 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -50,6 +50,9 @@ u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val)
 	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
 	int i = pltsec->plt_num_entries++;
 	u32 mov0, mov1, mov2, br;
+#if CONFIG_ARM64_VA_BITS > 48
+	u32 mov3;
+#endif
 	int rd;
 
 	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
@@ -69,6 +72,12 @@ u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val)
 	mov2 = aarch64_insn_gen_movewide(rd, (u16)(val >> 32), 32,
 					 AARCH64_INSN_VARIANT_64BIT,
 					 AARCH64_INSN_MOVEWIDE_KEEP);
+#if CONFIG_ARM64_VA_BITS > 48
+	mov3 = aarch64_insn_gen_movewide(rd, (u16)(val >> 48), 48,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_KEEP);
+#endif
+
 	br = aarch64_insn_gen_branch_imm((u64)&plt[i].br, (u64)loc + 4,
 					 AARCH64_INSN_BRANCH_NOLINK);
 
@@ -76,6 +85,9 @@ u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val)
 			cpu_to_le32(mov0),
 			cpu_to_le32(mov1),
 			cpu_to_le32(mov2),
+#if CONFIG_ARM64_VA_BITS > 48
+			cpu_to_le32(mov3),
+#endif
 			cpu_to_le32(br)
 		};
 
-- 
2.11.0
