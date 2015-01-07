From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jan 2015 12:04:14 +0000
Subject: [PATCH 1/7] arm64: introduce common ESR_ELx_* definitions
In-Reply-To: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1420632260-8798-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have separate ESR_EL{1,2}_* macros, despite the fact that
the encodings are common. While encodings are architected to refer to
the current EL or a lower EL, the macros refer to particular ELs (e.g.
ESR_ELx_EC_DABT_EL0). Having these duplicate definitions is redundant,
and their naming is misleading.

This patch introduces common ESR_ELx_* macros that can be used in all
cases, in preparation for later patches which will migrate existing
users over. Some additional cleanups are made in the process:

* Suffixes for particular exception levelts (e.g. _EL0, _EL1) are
  replaced with more general _LOW and _CUR suffixes, matching the
  architectural intent.

* ESR_ELx_EC_WFx, rather than ESR_ELx_EC_WFI is introduced, as this
  EC encoding covers traps from both WFE and WFI. Similarly,
  ESR_ELx_WFx_ISS_WFE rather than ESR_ELx_EC_WFI_ISS_WFE is introduced.

* Multi-bit fields are given consistently named _SHIFT and _MASK macros.

* UL() is used for compatiblity with assembly files.

* Comments are added for currently unallocated ESR_ELx.EC encodings.

For fields other than ESR_ELx.EC, macros are only implemented for fields
for which there is already an ESR_EL{1,2}_* macro.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/esr.h | 78 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 72674f4..eaee379 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -54,4 +54,82 @@
 #define ESR_EL1_EC_BKPT32	(0x38)
 #define ESR_EL1_EC_BRK64	(0x3C)
 
+#define ESR_ELx_EC_UNKNOWN	(0x00)
+#define ESR_ELx_EC_WFx		(0x01)
+/* Unallocated EC: 0x02 */
+#define ESR_ELx_EC_CP15_32	(0x03)
+#define ESR_ELx_EC_CP15_64	(0x04)
+#define ESR_ELx_EC_CP14_MR	(0x05)
+#define ESR_ELx_EC_CP14_LS	(0x06)
+#define ESR_ELx_EC_FP_ASIMD	(0x07)
+#define ESR_ELx_EC_CP10_ID	(0x08)
+/* Unallocated EC: 0x09 - 0x0B */
+#define ESR_ELx_EC_CP14_64	(0x0C)
+/* Unallocated: 0x0d */
+#define ESR_ELx_EC_ILL		(0x0E)
+/* Unallocated EC: 0x0F - 0x10 */
+#define ESR_ELx_EC_SVC32	(0x11)
+#define ESR_ELx_EC_HVC32	(0x12)
+#define ESR_ELx_EC_SMC32	(0x13)
+/* Unallocated EC: 0x14 */
+#define ESR_ELx_EC_SVC64	(0x15)
+#define ESR_ELx_EC_HVC64	(0x16)
+#define ESR_ELx_EC_SMC64	(0x17)
+#define ESR_ELx_EC_SYS64	(0x18)
+/* Unallocated EC: 0x19 - 0x1E */
+#define ESR_ELx_EC_IMP_DEF	(0x1f)
+#define ESR_ELx_EC_IABT_LOW	(0x20)
+#define ESR_ELx_EC_IABT_CUR	(0x21)
+#define ESR_ELx_EC_PC_ALIGN	(0x22)
+/* Unallocated EC: 0x23 */
+#define ESR_ELx_EC_DABT_LOW	(0x24)
+#define ESR_ELx_EC_DABT_CUR	(0x25)
+#define ESR_ELx_EC_SP_ALIGN	(0x26)
+/* Unallocated EC: 0x27 */
+#define ESR_ELx_EC_FP_EXC32	(0x28)
+/* Unallocated EC: 0x29 - 0x2B */
+#define ESR_ELx_EC_FP_EXC64	(0x2C)
+/* Unallocated EC: 0x2D - 0x2E */
+#define ESR_ELx_EC_SERROR	(0x2F)
+#define ESR_ELx_EC_BREAKPT_LOW	(0x30)
+#define ESR_ELx_EC_BREAKPT_CUR	(0x31)
+#define ESR_ELx_EC_SOFTSTP_LOW	(0x32)
+#define ESR_ELx_EC_SOFTSTP_CUR	(0x33)
+#define ESR_ELx_EC_WATCHPT_LOW	(0x34)
+#define ESR_ELx_EC_WATCHPT_CUR	(0x35)
+/* Unallocated EC: 0x36 - 0x37 */
+#define ESR_ELx_EC_BKPT32	(0x38)
+/* Unallocated EC: 0x39 */
+#define ESR_ELx_EC_VECTOR32	(0x3A)
+/* Unallocted EC: 0x3B */
+#define ESR_ELx_EC_BRK64	(0x3C)
+/* Unallocated EC: 0x3D - 0x3F */
+#define ESR_ELx_EC_MAX		(0x3F)
+
+#define ESR_ELx_EC_SHIFT	(26)
+#define ESR_ELx_EC_MASK		(UL(0x3F) << ESR_ELx_EC_SHIFT)
+
+#define ESR_ELx_IL		(UL(1) << 25)
+#define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
+#define ESR_ELx_ISV		(UL(1) << 24)
+#define ESR_ELx_SAS		(UL(1) << 22)
+#define ESR_ELx_SSE		(UL(1) << 21)
+#define ESR_ELx_SRT_SHIFT	(16)
+#define ESR_ELx_SRT_MASK	(UL(0x1F) << ESR_ELx_SRT_SHIFT)
+#define ESR_ELx_SF 		(UL(1) << 15)
+#define ESR_ELx_AR 		(UL(1) << 14)
+#define ESR_ELx_EA 		(UL(1) << 9)
+#define ESR_ELx_CM 		(UL(1) << 8)
+#define ESR_ELx_S1PTW 		(UL(1) << 7)
+#define ESR_ELx_WNR		(UL(1) << 6)
+#define ESR_ELx_FSC		(0x3F)
+#define ESR_ELx_FSC_TYPE	(0x3C)
+#define ESR_ELx_FSC_EXTABT	(0x10)
+#define ESR_ELx_FSC_FAULT	(0x04)
+#define ESR_ELx_FSC_PERM	(0x0F)
+#define ESR_ELx_CV		(UL(1) << 24)
+#define ESR_ELx_COND_SHIFT	(20)
+#define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
+#define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
+
 #endif /* __ASM_ESR_H */
-- 
1.9.1
