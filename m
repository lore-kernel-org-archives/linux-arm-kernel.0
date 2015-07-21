From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jul 2015 12:37:05 +0100
Subject: [PATCH v2 6/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <55AE1F30.6020803@arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
 <1437154221-5736-7-git-send-email-james.morse@arm.com>
 <55AE1F30.6020803@arm.com>
Message-ID: <20150721113705.GD7250@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 11:30:08AM +0100, Suzuki K. Poulose wrote:
> On 17/07/15 18:30, James Morse wrote:
> >diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> >index 56391fbae1e1..f243bb1adaa5 100644
> >--- a/arch/arm64/include/asm/sysreg.h
> >+++ b/arch/arm64/include/asm/sysreg.h
> >@@ -20,12 +20,21 @@
> >  #ifndef __ASM_SYSREG_H
> >  #define __ASM_SYSREG_H
> >
> >+#include <asm/opcodes.h>
> >+
> >  #define SCTLR_EL1_CP15BEN      (0x1 << 5)
> >  #define SCTLR_EL1_SED          (0x1 << 8)
> >
> >  #define sys_reg(op0, op1, crn, crm, op2) \
> >         ((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
> >
> >+#define REG_PSTATE_PAN_IMM                     sys_reg(2, 0, 4, 0, 4)
> 
> I think the above encoding is incorrect (even though, the code works fine).
> While setting the PAN with an immediate value, the PAN is treated just like
> a Process state field and the encoding becomes:
>  Op0=0, Op1=0 ...
> The encoding 2,0 ,... works fine in this case due to a bug in the sys_reg()
> macro above, where op0 is encoded as (op0 - 2). I took a look at the ARMv8 ARM,
> section C5.2.{3, 4, 5, 6} and the system instruction class reserves bits[20-19] for Op0.
> I think we should fix that first and use the appropriate encoding mandated by the
> architecture to avoid further errors.

The sys_reg() was initially meant for MSR/MRS with a register operand
where op0 is encoded as a single bit (19) and bit 20 is always 1. But
looking at the overall encoding for MSR/MRS in the ARMv8 ARM, I'm happy
to make the sys_reg macro more generic with ((op0 & 3) << 19) together
with changing the 0xd51/0xd53 values in the mrs_s/msr_s macros. Maybe
with a comment as well on the encoding of op0 (I guess you'll post a
patch since you started it ;)).

-- 
Catalin
