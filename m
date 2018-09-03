From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Sep 2018 17:32:28 +0100
Subject: [PATCH 5/7] arm64: ssbd: Add support for PSTATE.SSBS rather than
 trapping to EL3
In-Reply-To: <35cfe536-0b79-efeb-dec0-119f2bc169cb@arm.com>
References: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
 <1535645767-9901-6-git-send-email-will.deacon@arm.com>
 <35cfe536-0b79-efeb-dec0-119f2bc169cb@arm.com>
Message-ID: <20180903163228.GE6954@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Mon, Sep 03, 2018 at 10:54:41AM +0100, Suzuki K Poulose wrote:
> On 30/08/18 17:16, Will Deacon wrote:
> >On CPUs with support for PSTATE.SSBS, the kernel can toggle the SSBD
> >state without needing to call into firmware.
> >
> >This patch hooks into the existing SSBD infrastructure so that SSBS is
> >used on CPUs that support it, but it's all made horribly complicated by
> >the very real possibility of big/little systems that don't uniformly
> >provide the new capability.
> >
> >Signed-off-by: Will Deacon <will.deacon@arm.com>
> >---
> >  arch/arm64/include/asm/processor.h   |  7 ++++++
> >  arch/arm64/include/asm/ptrace.h      |  1 +
> >  arch/arm64/include/asm/sysreg.h      |  3 +++
> >  arch/arm64/include/uapi/asm/ptrace.h |  1 +
> >  arch/arm64/kernel/cpu_errata.c       | 26 +++++++++++++++++++--
> >  arch/arm64/kernel/cpufeature.c       | 45 ++++++++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/process.c          |  4 ++++
> >  arch/arm64/kernel/ssbd.c             | 21 +++++++++++++++++
> >  8 files changed, 106 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> >index 79657ad91397..f6835374ed9f 100644
> >--- a/arch/arm64/include/asm/processor.h
> >+++ b/arch/arm64/include/asm/processor.h
> >@@ -174,6 +174,10 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
> >  {
> >  	start_thread_common(regs, pc);
> >  	regs->pstate = PSR_MODE_EL0t;
> >+
> >+	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
> >+		regs->pstate |= PSR_SSBS_BIT;
> >+
> >  	regs->sp = sp;
> >  }
> >@@ -190,6 +194,9 @@ static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
> >  	regs->pstate |= PSR_AA32_E_BIT;
> >  #endif
> >+	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
> >+		regs->pstate |= PSR_AA32_SSBS_BIT;
> >+
> >  	regs->compat_sp = sp;
> >  }
> >  #endif
> >diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> >index 177b851ca6d9..6bc43889d11e 100644
> >--- a/arch/arm64/include/asm/ptrace.h
> >+++ b/arch/arm64/include/asm/ptrace.h
> >@@ -50,6 +50,7 @@
> >  #define PSR_AA32_I_BIT		0x00000080
> >  #define PSR_AA32_A_BIT		0x00000100
> >  #define PSR_AA32_E_BIT		0x00000200
> >+#define PSR_AA32_SSBS_BIT	0x00800000
> >  #define PSR_AA32_DIT_BIT	0x01000000
> >  #define PSR_AA32_Q_BIT		0x08000000
> >  #define PSR_AA32_V_BIT		0x10000000
> >diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> >index 2fc6242baf11..3091ae5975a3 100644
> >--- a/arch/arm64/include/asm/sysreg.h
> >+++ b/arch/arm64/include/asm/sysreg.h
> >@@ -86,11 +86,14 @@
> >  #define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
> >  #define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
> >+#define REG_PSTATE_SSBS_IMM		sys_reg(0, 3, 4, 0, 1)
> 
> nit: This is not about the patch, but what we have already established
> for the macros above.
> 
> It looks like these definitions are a bit confusing if you try to
> correlate it with the Arm ARM. For "msr <pstate_field>, #Immediate",
> we have :
> 
> pstate_field => encoded in Op1:Op2 only
> #Immediate => encoded in CRm field.
> 
> And Crn = 4, op0 = 0 and they are not specifically part of any standard
> encoding for the "fields", but for the instruction access. (e.g, they
> don't appear in an ISS for an ESR_ELx unlike the other sys regs).
> 
> So, using the sys_reg() definitions above somehow hides these facts and
> makes it a bit difficult to verify the code. I am wondering if we should
> introduce something like :
> 
> #define pstate_field(op1, op2)	(((op1) << Op1_shift) | ((op2) << Op2_shift))
> #define PSTATE_Imm_shift	CRm_shift
> 
> #define PSTATE_PAN		pstate_field(0, 4)
> #define PSTATE_UAO		pstate_field(0, 3)
> #define PSTATE_SSBS		pstate_field(3, 1)
> 
> #define SET_PSTATE_FIELD(field, val)	\
> 		__emit_insn(0xd500401f | field | ((val) << PSTATE_Imm_shift))
> 
> #define SET_PSTATE_PAN(x)	SET_PSTATE_FIELD(PSTATE_PAN, !!(x))
> 
> etc.
> 
> Of course this has to be a separate patch which I can send if you think it is
> worth pursuing.

I think this would be a useful cleanup, so please go ahead! I suspect I'll
have to backport my stuff to stable, so having the cleanup on top would be
best.


> >diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> >index dec10898d688..c063490d7b51 100644
> >--- a/arch/arm64/kernel/cpu_errata.c
> >+++ b/arch/arm64/kernel/cpu_errata.c
> >@@ -312,6 +312,14 @@ void __init arm64_enable_wa2_handling(struct alt_instr *alt,
> >  void arm64_set_ssbd_mitigation(bool state)
> >  {
> >+	if (this_cpu_has_cap(ARM64_SSBS)) {
> 
> nit: This will take a longer time as it iterates over the entire *arm64_features* and *arm64_errata*
> list until it finds the "cap" requested to run the check. If we tend to use this function a lot
> more and expect it to do it quickly, we may simply make the direct call to the matches or add
> a wrapper to do the same.

I don't think we need to treat this as too much of a hot path, so it should
be fine.

Will
