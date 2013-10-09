From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  9 Oct 2013 15:29:52 +0100
Subject: [RFC PATCH 3/4] ARM: Add const cpu_to_le32 for asm
In-Reply-To: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
References: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1381328993-12724-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, it's common for big-endian systems to use little-endian
byte order for devices.

This patch adds a __asm_cpu_to_le32() helper, similar to
cpu_to_le32().  This is intended for preparing 32-bit constants to
be stored to a device, or compared with data loaded from a device.

Rather than add umpteen variants up front, extra variants can be
added when needed.  Accessing devices directly from asm is not the
common case.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/assembler.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 860256c..ec869e9 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -403,4 +403,10 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 ")"
 #endif /* ! __ASSEMBLY__ */
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define __asm_cpu_to_le32(x) __asm_swab32(x)
+#else
+#define __asm_cpu_to_le32(x) "(" x ")"
+#endif		 
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
1.7.9.5
