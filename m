From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:34 +0100
Subject: [PATCH 08/16] ARM: Let arm_check_condition work with Thumb
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_check_condition indicates whether a trapped conditional
instruction would have failed or passed its condition check.

This works perfectly well for ARM code, but it ignores entirely
the Thumb mode, where the condition code is not encoded in the
intruction, but in the IT state contained in the PSR.

This patch adds the necessary decoding, allowing arm_check_condition
to correctly behave when presented with a Thumb instruction.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/opcodes.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/opcodes.c b/arch/arm/kernel/opcodes.c
index f8179c6a817f..827318ee5ff7 100644
--- a/arch/arm/kernel/opcodes.c
+++ b/arch/arm/kernel/opcodes.c
@@ -38,6 +38,21 @@ static const unsigned short cc_map[16] = {
 	0			/* NV                     */
 };
 
+#define PSR_IT_1_0_SHIFT	25
+#define PSR_IT_1_0_MASK		(0x3 << PSR_IT_1_0_SHIFT)
+#define PSR_IT_7_2_SHIFT	10
+#define PSR_IT_7_2_MASK		(0x3f << PSR_IT_7_2_SHIFT)
+
+static u32 psr_get_it_state(u32 psr)
+{
+	u32 it;
+
+	it  = (psr & PSR_IT_1_0_MASK) >> PSR_IT_1_0_SHIFT;
+	it |= ((psr & PSR_IT_7_2_MASK) >> PSR_IT_7_2_SHIFT) << 2;
+
+	return it;
+}
+
 /*
  * Returns:
  * ARM_OPCODE_CONDTEST_FAIL   - if condition fails
@@ -54,10 +69,27 @@ static const unsigned short cc_map[16] = {
  */
 asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr)
 {
-	u32 cc_bits  = opcode >> 28;
+	u32 cc_bits;
 	u32 psr_cond = psr >> 28;
 	unsigned int ret;
 
+	/*
+	 * If the CPU is in Thumb mode Thumb, extract the condition
+	 * code from psr. Otherwise, extract the condition code from
+	 * the instruction itself.
+	 */
+	if (psr & PSR_T_BIT) {
+		u32 it;
+
+		it = psr_get_it_state(psr);
+		if (!it)
+			return ARM_OPCODE_CONDTEST_PASS;
+
+		cc_bits = it >> 4;
+	} else {
+		cc_bits  = opcode >> 28;
+	}
+
 	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
 		if ((cc_map[cc_bits] >> (psr_cond)) & 1)
 			ret = ARM_OPCODE_CONDTEST_PASS;
-- 
2.11.0
