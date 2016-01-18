From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 Jan 2016 10:12:18 +0000
Subject: [PATCH 04/19] arm64: Cleanup SCTLR flags
In-Reply-To: <20160115200727.GQ3262@leverpostej>
References: <cover.1452884156.git.geoff@infradead.org>
 <701b44f00cdb8dbc7881c12508f55e993b9ce6dd.1452884156.git.geoff@infradead.org>
 <20160115200727.GQ3262@leverpostej>
Message-ID: <569CBA82.9050102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/16 20:07, Mark Rutland wrote:
> [Adding Marc as this touches KVM code]
> 
> On Fri, Jan 15, 2016 at 07:18:37PM +0000, Geoff Levand wrote:
>> We currently have macros defining flags for the arm64 sctlr registers in both
>> kvm_arm.h and sysreg.h.  To clean things up and simplify move the definitions
>> of the SCTLR_EL2 flags from kvm_arm.h to sysreg.h, rename any SCTLR_EL1 or
>> SCTLR_EL2 flags that are common to both registers to be SCTLR_ELx, with 'x'
>> indicating a common flag, and fixup all files to include the proper header or
>> to use the new macro names.
> 
> I am certainly in favour of having consistently named and located macros
> for register fields.
> 
>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>> ---
>>  arch/arm64/include/asm/kvm_arm.h | 11 -----------
>>  arch/arm64/include/asm/sysreg.h  | 19 +++++++++++++++----
>>  arch/arm64/kvm/hyp-init.S        |  6 +++---
>>  3 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index 5e6857b..92ef6f6 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -83,17 +83,6 @@
>>  #define HCR_INT_OVERRIDE   (HCR_FMO | HCR_IMO)
>>  
>>  
>> -/* Hyp System Control Register (SCTLR_EL2) bits */
>> -#define SCTLR_EL2_EE	(1 << 25)
>> -#define SCTLR_EL2_WXN	(1 << 19)
>> -#define SCTLR_EL2_I	(1 << 12)
>> -#define SCTLR_EL2_SA	(1 << 3)
>> -#define SCTLR_EL2_C	(1 << 2)
>> -#define SCTLR_EL2_A	(1 << 1)
>> -#define SCTLR_EL2_M	1
>> -#define SCTLR_EL2_FLAGS	(SCTLR_EL2_M | SCTLR_EL2_A | SCTLR_EL2_C |	\
>> -			 SCTLR_EL2_SA | SCTLR_EL2_I)
> 
> SCTLR_EL2_FLAGS is a KVM-specific value (i.e. the SCTLR_EL2 flags which
> KVM wants to set), even if it consists solely of common fields.
> 
> I believe it should stay here (with an include for <asm/sysreg.h>),
> perhaps with a KVM_ prefix to imply it's not as generic as one might
> assume it is.
> 
>> -
>>  /* TCR_EL2 Registers bits */
>>  #define TCR_EL2_RES1	((1 << 31) | (1 << 23))
>>  #define TCR_EL2_TBI	(1 << 20)
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index d48ab5b..109d46e 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -80,10 +80,21 @@
>>  #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
>>  				     (!!x)<<8 | 0x1f)
>>  
>> -/* SCTLR_EL1 */
>> -#define SCTLR_EL1_CP15BEN	(0x1 << 5)
>> -#define SCTLR_EL1_SED		(0x1 << 8)
>> -#define SCTLR_EL1_SPAN		(0x1 << 23)
>> +/* Common SCTLR_ELx flags. */
>> +#define SCTLR_ELx_EE    (1 << 25)
>> +#define SCTLR_ELx_I	(1 << 12)
>> +#define SCTLR_ELx_SA	(1 << 3)
>> +#define SCTLR_ELx_C	(1 << 2)
>> +#define SCTLR_ELx_A	(1 << 1)
>> +#define SCTLR_ELx_M	1
> 
> For consistency, (1 << 0) would be preferable.
> 
>> +
>> +#define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
>> +			 SCTLR_ELx_SA | SCTLR_ELx_I)
>> +
>> +/* SCTLR_EL1 specific flags. */
>> +#define SCTLR_EL1_SPAN		(1 << 23)
>> +#define SCTLR_EL1_SED		(1 << 8)
>> +#define SCTLR_EL1_CP15BEN	(1 << 5)
>>  
>>  
>>  /* id_aa64isar0 */
>> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>> index 178ba22..1d7e502 100644
>> --- a/arch/arm64/kvm/hyp-init.S
>> +++ b/arch/arm64/kvm/hyp-init.S
>> @@ -20,7 +20,7 @@
>>  #include <asm/assembler.h>
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_mmu.h>
>> -#include <asm/pgtable-hwdef.h>
>> +#include <asm/sysreg.h>
>>  
>>  	.text
>>  	.pushsection	.hyp.idmap.text, "ax"
>> @@ -105,8 +105,8 @@ __do_hyp_init:
>>  	dsb	sy
>>  
>>  	mrs	x4, sctlr_el2
>> -	and	x4, x4, #SCTLR_EL2_EE	// preserve endianness of EL2
>> -	ldr	x5, =SCTLR_EL2_FLAGS
>> +	and	x4, x4, #SCTLR_ELx_EE	// preserve endianness of EL2
>> +	ldr	x5, =SCTLR_ELx_FLAGS
> 
> Marc, Christoffer, I note that in SCTLR_EL2_FLAGS we don't set the RES1
> bits of SCTLR_EL2 (not in head.S el2_setup). Should we perhaps be doing
> so so as to avoid any future surprises?

Yes, that's one of the numerous instances of the same problem - I think
Dave Martin also has some fixes in that area.

I'll definitely take patches!

	M.
-- 
Jazz is not dead. It just smells funny...
