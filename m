From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Mar 2013 13:50:42 +0000
Subject: [PATCH 04/29] arm64: KVM: system register definitions for 64bit
 guests
In-Reply-To: <513F2BA7.6020004@codeaurora.org>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-5-git-send-email-marc.zyngier@arm.com>
 <513F2BA7.6020004@codeaurora.org>
Message-ID: <513F32B2.6070700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/13 13:20, Christopher Covington wrote:

Hi Christopher,

> Here are a few minor questions and suggestions.
> 
> On 03/04/2013 10:47 PM, Marc Zyngier wrote:
>> Define the saved/restored registers for 64bit guests.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_asm.h | 68 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/kvm_asm.h
> 
> [...]
> 
>> +/*
>> + * 0 is reserved as an invalid value.
>> + * Order *must* be kept in sync with the hyp switch code.
>> + */
>> +#define	MPIDR_EL1	1	/* MultiProcessor Affinity Register */
>> +#define	CSSELR_EL1	2	/* Cache Size Selection Register */
>> +#define	SCTLR_EL1	3	/* System Control Register */
>> +#define	ACTLR_EL1	4	/* Auxilliary Control Register */
>> +#define	CPACR_EL1	5	/* Coprocessor Access Control */
>> +#define	TTBR0_EL1	6	/* Translation Table Base Register 0 */
>> +#define	TTBR1_EL1	7	/* Translation Table Base Register 1 */
>> +#define	TCR_EL1		8	/* Translation Control Register */
>> +#define	ESR_EL1		9	/* Exception Syndrome Register */
>> +#define	AFSR0_EL1	10	/* Auxilary Fault Status Register 0 */
>> +#define	AFSR1_EL1	11	/* Auxilary Fault Status Register 1 */
>> +#define	FAR_EL1		12	/* Fault Address Register */
>> +#define	MAIR_EL1	13	/* Memory Attribute Indirection Register */
>> +#define	VBAR_EL1	14	/* Vector Base Address Register */
>> +#define	CONTEXTIDR_EL1	15	/* Context ID Register */
>> +#define	TPIDR_EL0	16	/* Thread ID, User R/W */
>> +#define	TPIDRRO_EL0	17	/* Thread ID, User R/O */
>> +#define	TPIDR_EL1	18	/* Thread ID, Privileged */
>> +#define	AMAIR_EL1	19	/* Aux Memory Attribute Indirection Register */
>> +#define	CNTKCTL_EL1	20	/* Timer Control Register (EL1) */
> 
> Any particular reason to have CNTKCTL_EL1 enumerated here and handled by
> (dump|load)_sysregs, but all the other timer registers handled by
> (save|restore)_timer_state in hyp.S?

This one is a bit of an odd one, as it controls the guest kernel
decision to expose its timer/counter to its own userspace. It is not
directly involved into the timekeeping itself.

As such, my choice was to make it part of the CPU state rather than the
timer state. But I admit this may not be the most obvious choice.

>> +#define	NR_SYS_REGS	21
> 
> [...]
> 
>> +/* Hyp Syndrome Register (HSR) bits */
>> +#define ESR_EL2_EC_SHIFT	(26)
>> +#define ESR_EL2_EC		(0x3fU << ESR_EL2_EC_SHIFT)
>> +#define ESR_EL2_IL		(1U << 25)
>> +#define ESR_EL2_ISS		(ESR_EL2_IL - 1)
>> +#define ESR_EL2_ISV_SHIFT	(24)
>> +#define ESR_EL2_ISV		(1U << ESR_EL2_ISV_SHIFT)
>> +#define ESR_EL2_SAS_SHIFT	(22)
>> +#define ESR_EL2_SAS		(3U << ESR_EL2_SAS_SHIFT)
>> +#define ESR_EL2_SSE		(1 << 21)
>> +#define ESR_EL2_SRT_SHIFT	(16)
>> +#define ESR_EL2_SRT_MASK	(0x1f << ESR_EL2_SRT_SHIFT)
>> +#define ESR_EL2_SF 		(1 << 15)
>> +#define ESR_EL2_AR 		(1 << 14)
>> +#define ESR_EL2_EA 		(1 << 9)
>> +#define ESR_EL2_CM 		(1 << 8)
>> +#define ESR_EL2_S1PTW 		(1 << 7)
>> +#define ESR_EL2_WNR		(1 << 6)
>> +#define ESR_EL2_FSC		(0x3f)
>> +#define ESR_EL2_FSC_TYPE	(0x3c)
>> +
>> +#define ESR_EL2_CV_SHIFT	(24)
>> +#define ESR_EL2_CV		(1U << ESR_EL2_CV_SHIFT)
>> +#define ESR_EL2_COND_SHIFT	(20)
>> +#define ESR_EL2_COND		(0xfU << ESR_EL2_COND_SHIFT)
> 
> [...]
> 
>> +#define ESR_EL2_EC_UNKNOWN	(0x00)
>> +#define ESR_EL2_EC_WFI		(0x01)
>> +#define ESR_EL2_EC_CP15_32	(0x03)
>> +#define ESR_EL2_EC_CP15_64	(0x04)
>> +#define ESR_EL2_EC_CP14_MR	(0x05)
>> +#define ESR_EL2_EC_CP14_LS	(0x06)
>> +#define ESR_EL2_EC_SIMD_FP	(0x07)
>> +#define ESR_EL2_EC_CP10_ID	(0x08)
>> +#define ESR_EL2_EC_CP14_64	(0x0C)
>> +#define ESR_EL2_EC_ILL_ISS	(0x0E)
>> +#define ESR_EL2_EC_SVC32	(0x11)
>> +#define ESR_EL2_EC_HVC32	(0x12)
>> +#define ESR_EL2_EC_SMC32	(0x13)
>> +#define ESR_EL2_EC_SVC64	(0x14)
>> +#define ESR_EL2_EC_HVC64	(0x16)
>> +#define ESR_EL2_EC_SMC64	(0x17)
>> +#define ESR_EL2_EC_SYS64	(0x18)
>> +#define ESR_EL2_EC_IABT		(0x20)
>> +#define ESR_EL2_EC_IABT_HYP	(0x21)
>> +#define ESR_EL2_EC_PC_ALIGN	(0x22)
>> +#define ESR_EL2_EC_DABT		(0x24)
>> +#define ESR_EL2_EC_DABT_HYP	(0x25)
>> +#define ESR_EL2_EC_SP_ALIGN	(0x26)
>> +#define ESR_EL2_EC_FP32		(0x28)
>> +#define ESR_EL2_EC_FP64		(0x2C)
>> +#define ESR_EL2_EC_SERRROR	(0x2F)
>> +#define ESR_EL2_EC_BREAKPT	(0x30)
>> +#define ESR_EL2_EC_BREAKPT_HYP	(0x31)
>> +#define ESR_EL2_EC_SOFTSTP	(0x32)
>> +#define ESR_EL2_EC_SOFTSTP_HYP	(0x33)
>> +#define ESR_EL2_EC_WATCHPT	(0x34)
>> +#define ESR_EL2_EC_WATCHPT_HYP	(0x35)
>> +#define ESR_EL2_EC_BKPT32	(0x38)
>> +#define ESR_EL2_EC_VECTOR32	(0x3A)
>> +#define ESR_EL2_EC_BKPT64	(0x3C)
> 
> Is there any functional difference between these fields and bits at EL2 and
> these fields at other exception levels? If not, you could consider omitting
> "_EL2".
> 
> [...]

A few values here are EL2 specific (ESR_EL2_EC_*_HYP,
ESR_EL2_EC_HVC{32,64}, ESR_EL2_EC_CP1*...).

The fields themselves should be broadly compatible (I should go and
verify this though). Now, what I want to avoid is any sort of confusion
between exception levels, and make clear which level we're operating on.

If I can be sure we always operate in a non-ambiguous context, then _EL2
can go indeed.

	M.
-- 
Jazz is not dead. It just smells funny...
