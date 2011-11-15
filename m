From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Tue, 15 Nov 2011 10:06:20 +0800
Subject: [PATCH 1/6] ARM: fix be8 support for phys/virt address conversion
Message-ID: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

phys_to_virt() and virt_to_phys() is implemented by one assembler instruction,
add/sub an offset between the physical and virtual address. For some arm machines
with CONFIG_ARM_PATCH_PHYS_VIRT defined, this offset is unknown at compile time,
it is calculated dynamically at run time and then patched to the add/sub instruction.
To support BE8 mode, firstly we need to convert the instruntion to big-endian after
loading it from the memory, and then modify its offset field, at last convert it to
little-endian and write it back to the memory.

Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>
---
 arch/arm/kernel/head.S |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 566c54c..838fb0c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -522,8 +522,14 @@ __fixup_a_pv_table:
 	b	2f
 1:	add     r7, r3
 	ldrh	ip, [r7, #2]
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	rev16	ip, ip
+#endif
 	and	ip, 0x8f00
 	orr	ip, r6	@ mask in offset bits 31-24
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	rev16	ip, ip
+#endif
 	strh	ip, [r7, #2]
 2:	cmp	r4, r5
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
@@ -532,8 +538,14 @@ __fixup_a_pv_table:
 #else
 	b	2f
 1:	ldr	ip, [r7, r3]
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	rev	ip, ip
+#endif
 	bic	ip, ip, #0x000000ff
 	orr	ip, ip, r6	@ mask in offset bits 31-24
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	rev	ip, ip
+#endif
 	str	ip, [r7, r3]
 2:	cmp	r4, r5
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
-- 
1.7.0.4
