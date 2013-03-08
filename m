From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 08 Mar 2013 04:23:57 +0100
Subject: [kvmarm] [PATCH 04/29] arm64: KVM: system register definitions for
 64bit guests
In-Reply-To: <39149D17-D998-413F-AB9C-A76E95483BED@suse.de>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-5-git-send-email-marc.zyngier@arm.com>
 <39149D17-D998-413F-AB9C-A76E95483BED@suse.de>
Message-ID: <9774bec864d923cdf3861f1ab7d5ed3c@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013 11:33:12 +0100, Alexander Graf <agraf@suse.de> wrote:
> On 05.03.2013, at 04:47, Marc Zyngier wrote:
> 
>> Define the saved/restored registers for 64bit guests.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> arch/arm64/include/asm/kvm_asm.h | 68
>> ++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 68 insertions(+)
>> create mode 100644 arch/arm64/include/asm/kvm_asm.h
>> 
>> diff --git a/arch/arm64/include/asm/kvm_asm.h
>> b/arch/arm64/include/asm/kvm_asm.h
>> new file mode 100644
>> index 0000000..851fee5
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kvm_asm.h
>> @@ -0,0 +1,68 @@
>> +/*
>> + * Copyright (C) 2012 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see
<http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ARM_KVM_ASM_H__
>> +#define __ARM_KVM_ASM_H__
>> +
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
>> +#define	NR_SYS_REGS	21
> 
> These are internal representations of the system registers. Keeping
> everything strictly linear is quite cumbersome, why not let the compiler
do
> this for you?
> 
> enum kvm_sysreg_id {
>     MPIDR_EL1 = 1,
>     ...
>     NR_SYS_REGS
> }
> 
> That way gcc automatically counts the IDs up for you. You eliminate a
> potential source of breakage (duplicate IDs) and the code is even easier
to
> read ;).

I thought of that, but it doesn't fly because of the HYP assembly code,
which directly uses these constants.

        M.
-- 
Fast, cheap, reliable. Pick two.
