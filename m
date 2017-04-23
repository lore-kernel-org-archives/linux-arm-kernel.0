From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:17 +0200
Subject: [PULL 07/79] arm64: sysreg: add Set/Way sys encodings
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-8-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Cache maintenance ops fall in the SYS instruction class, and KVM needs
to handle them. So as to keep all SYS encodings in one place, this
patch adds them to sysreg.h.

The encodings were taken from ARM DDI 0487A.k_iss10775, Table C5-2.

To make it clear that these are instructions rather than registers, and
to allow us to change the way these are handled in future, a new
sys_insn() alias for sys_reg() is added and used for these new
definitions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f623320..128eae8 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -48,6 +48,8 @@
 	 ((crn) << CRn_shift) | ((crm) << CRm_shift) | \
 	 ((op2) << Op2_shift))
 
+#define sys_insn	sys_reg
+
 #define sys_reg_Op0(id)	(((id) >> Op0_shift) & Op0_mask)
 #define sys_reg_Op1(id)	(((id) >> Op1_shift) & Op1_mask)
 #define sys_reg_CRn(id)	(((id) >> CRn_shift) & CRn_mask)
@@ -89,6 +91,10 @@
 #define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |	\
 				      (!!x)<<8 | 0x1f)
 
+#define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
 #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
-- 
2.9.0
