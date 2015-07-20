From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jul 2015 15:01:01 +0100
Subject: [PATCH v2 6/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <1437154221-5736-7-git-send-email-james.morse@arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
 <1437154221-5736-7-git-send-email-james.morse@arm.com>
Message-ID: <20150720140100.GL20385@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 06:30:21PM +0100, James Morse wrote:
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 56391fbae1e1..f243bb1adaa5 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -20,12 +20,21 @@
>  #ifndef __ASM_SYSREG_H
>  #define __ASM_SYSREG_H
>  
> +#include <asm/opcodes.h>
> +
>  #define SCTLR_EL1_CP15BEN	(0x1 << 5)
>  #define SCTLR_EL1_SED		(0x1 << 8)
>  
>  #define sys_reg(op0, op1, crn, crm, op2) \
>  	((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
>  
> +#define REG_PSTATE_PAN_IMM                     sys_reg(2, 0, 4, 0, 4)
> +#define PSTATE_PAN                             (1 << 22)

[...]

> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 6913643bbe54..208db3df135a 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -44,6 +44,7 @@
>  #define PSR_I_BIT	0x00000080
>  #define PSR_A_BIT	0x00000100
>  #define PSR_D_BIT	0x00000200
> +#define PSR_PAN_BIT	0x00400000

What I meant is to use PSR_PAN_BIT instead of PSTATE_PAN, not just to
define it (i.e. remove the latter).

-- 
Catalin
