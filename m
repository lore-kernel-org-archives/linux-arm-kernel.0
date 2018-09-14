From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Sep 2018 18:12:39 +0100
Subject: [PATCH] arm64: sysreg: Clean up instructions for modifying
 PSTATE fields
In-Reply-To: <20180914090749.18562-1-suzuki.poulose@arm.com>
References: <20180914090749.18562-1-suzuki.poulose@arm.com>
Message-ID: <20180914171238.ztf6qcy6ws7sjzkf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Fri, Sep 14, 2018 at 10:07:49AM +0100, Suzuki K. Poulose wrote:
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index c1470931b897..68c22360551e 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -84,13 +84,23 @@
>  
>  #endif	/* CONFIG_BROKEN_GAS_INST */
>  
> -#define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
> -#define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
> +/*
> + * Instructions for modifying PSTATE fields.
> + * As per Arm ARM for v8-A, Section "C.5.1.3 op0 == 0b00, architectural hints,
> + * barriers and CLREX, and PSTATE access", ARM DDI 0487 C.a, system instructions
> + * for accessing PSTATE fields have the following encoding:
> + *	Op0 = 0, CRn = 4
> + *	Op1, Op2 encodes the PSTATE field modified and defines the constraints.
> + *	CRm = Imm4 for the instruction.
> + *	Rt = 0x1f
> + */
> +#define pstate_field(op1, op2)		((op1) << Op1_shift | (op2) << Op2_shift)
> +#define PSTATE_Imm_shift		CRm_shift
> +#define PSTATE_PAN			pstate_field(0, 4)
> +#define PSTATE_UAO			pstate_field(0, 3)
>  
> -#define SET_PSTATE_PAN(x) __emit_inst(0xd5000000 | REG_PSTATE_PAN_IMM |	\
> -				      (!!x)<<8 | 0x1f)
> -#define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |	\
> -				      (!!x)<<8 | 0x1f)
> +#define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
> +#define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))

Could you please rebase this on top of arm64 for-next/core and also fix
Will's SSBS macros which conflict with the above?

Thanks.

-- 
Catalin
