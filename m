From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 29 Jun 2017 16:40:12 +0200
Subject: [PATCH v2] arm64: fix endianness annotation for
 __apply_alternatives()/get_alt_insn()
In-Reply-To: <20170629132645.difv6xdjrkp5qvlh@ltop.local>
References: <20170628145557.24454-1-luc.vanoostenryck@gmail.com>
 <20170629102851.GF14607@arm.com>
 <20170629132645.difv6xdjrkp5qvlh@ltop.local>
Message-ID: <20170629144011.zdte2n3x2shfud45@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_alt_insn() is used to read and create ARM instructions, which
are always stored in memory in little-endian order. These values
are thus correctly converted to/from native order when processed
but the pointers used to hold the address of these instructions
are declared as for native order values.

Fix this by declaring the pointers as __le32* instead of u32* and
make the few appropriate needed changes like removing the unneeded
cast '(u32*)' in front of __ALT_PTR()'s definition.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
Change since v1:
- remove the unneeded cast '(u32*)' in front of __ALT_PTR()'s definition.
- remove the now unneeded forced cast to __le32* when using
  ALT_ORIG_PTR() or ALT_REPL_PTR().
- remove an unnneded cast in front of lm_alias().

 arch/arm64/kernel/alternative.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 8840c109c..6dd0a3a3e 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -28,7 +28,7 @@
 #include <asm/sections.h>
 #include <linux/stop_machine.h>
 
-#define __ALT_PTR(a,f)		(u32 *)((void *)&(a)->f + (a)->f)
+#define __ALT_PTR(a,f)		((void *)&(a)->f + (a)->f)
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
@@ -60,7 +60,7 @@ static bool branch_insn_requires_update(struct alt_instr *alt, unsigned long pc)
 
 #define align_down(x, a)	((unsigned long)(x) & ~(((unsigned long)(a)) - 1))
 
-static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
+static u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr, __le32 *altinsnptr)
 {
 	u32 insn;
 
@@ -109,7 +109,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-	u32 *origptr, *replptr, *updptr;
+	__le32 *origptr, *replptr, *updptr;
 
 	for (alt = region->begin; alt < region->end; alt++) {
 		u32 insn;
@@ -124,7 +124,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 
 		origptr = ALT_ORIG_PTR(alt);
 		replptr = ALT_REPL_PTR(alt);
-		updptr = use_linear_alias ? (u32 *)lm_alias(origptr) : origptr;
+		updptr = use_linear_alias ? lm_alias(origptr) : origptr;
 		nr_inst = alt->alt_len / sizeof(insn);
 
 		for (i = 0; i < nr_inst; i++) {
-- 
2.13.0
