From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Tue, 18 Nov 2014 19:53:19 +0400
Subject: [PATCH RFC 2/3] ARM: enable TTBR0/TTBR1 split in short mode
In-Reply-To: <20141118165313.9958.1242.stgit@buzz>
References: <20141118165313.9958.1242.stgit@buzz>
Message-ID: <20141118165319.9958.67009.stgit@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This feature was partially implemented long time ago. All cpus load
swapper_pg_dir into TTBR1 since commit d427958a46af24f75d0017c45eadd172273bbf33
("ARM: 6942/1: mm: make TTBR1 always point to swapper_pg_dir on ARMv6/7").
But TTBRx split is never been enabled in TTBCR.

This patch enables TTBRx split for 2Gb/2Gb and 1Gb/3Gb combinations.
Area covered by TTBR0 must be power of two, thus 3Gb/1Gb mode is unsupported.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 arch/arm/include/asm/pgtable-2level-hwdef.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
index c2ed1fa..605652c 100644
--- a/arch/arm/include/asm/pgtable-2level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
@@ -90,6 +90,19 @@
 
 #define PHYS_MASK		(~0UL)
 
+/*
+ * TTBR0/TTBR1 split (PAGE_OFFSET):
+ *   0x40000000: TTBCR.N = 2
+ *   0x80000000: TTBCR.N = 1
+ *   0xc0000000: TTBCR.N = 0 (not used)
+ */
+
+#ifdef CONFIG_VMSPLIT_1G
+#define TTBR1_SIZE	2
+#elif defined CONFIG_VMSPLIT_2G
+#define TTBR1_SIZE	1
+#elif defined CONFIG_VMSPLIT_3G
 #define TTBR1_SIZE	0
+#endif
 
 #endif
