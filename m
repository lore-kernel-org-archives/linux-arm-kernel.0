From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 17 May 2017 11:54:33 +0200
Subject: [PATCH 08/31] arm64: Add a facility to turn an ESR syndrome into
 a sysreg encoding
In-Reply-To: <20170503104606.19342-9-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
 <20170503104606.19342-9-marc.zyngier@arm.com>
Message-ID: <9a81564d-8bb3-36ea-f0f8-a61cbc7fb345@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/05/2017 12:45, Marc Zyngier wrote:
> It is often useful to compare an ESR syndrome reporting the trapping
> of a system register with a value matching that system register.
> 
> Since encoding both the sysreg and the ESR version seem to be a bit
> overkill, let's add a set of macros that convert an ESR value into
> the corresponding sysreg encoding.
> 
> We handle both AArch32 and AArch64, taking advantage of identical
> encodings between system registers and CP15 accessors.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/esr.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index ad42e79a5d4d..db8f13137443 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -19,6 +19,7 @@
>  #define __ASM_ESR_H
>  
>  #include <asm/memory.h>
> +#include <asm/sysreg.h>
>  
>  #define ESR_ELx_EC_UNKNOWN	(0x00)
>  #define ESR_ELx_EC_WFx		(0x01)
> @@ -177,6 +178,30 @@
>  
>  #define ESR_ELx_SYS64_ISS_SYS_CNTVCT	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 2, 14, 0) | \
>  					 ESR_ELx_SYS64_ISS_DIR_READ)
> +
> +#define esr_sys64_to_sysreg(e)					\
> +	sys_reg((((e) & ESR_ELx_SYS64_ISS_OP0_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_OP0_SHIFT),			\
> +		(((e) & ESR_ELx_SYS64_ISS_OP1_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_OP1_SHIFT),			\
> +		(((e) & ESR_ELx_SYS64_ISS_CRN_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_CRN_SHIFT),			\
> +		(((e) & ESR_ELx_SYS64_ISS_CRM_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_CRM_SHIFT),			\
> +		(((e) & ESR_ELx_SYS64_ISS_OP2_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_OP2_SHIFT))
> +
> +#define esr_cp15_to_sysreg(e)					\
> +	sys_reg(3,						\
> +		(((e) & ESR_ELx_SYS64_ISS_OP1_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_OP1_SHIFT),			\
> +		(((e) & ESR_ELx_SYS64_ISS_CRN_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_CRN_SHIFT),			\
> +		(((e) & ESR_ELx_SYS64_ISS_CRM_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_CRM_SHIFT),			\
> +		(((e) & ESR_ELx_SYS64_ISS_OP2_MASK) >>		\
> +		 ESR_ELx_SYS64_ISS_OP2_SHIFT))
> +
>  #ifndef __ASSEMBLY__
>  #include <asm/types.h>

Needs a rebase on top
9842119  arm64: Add CNTFRQ_EL0 trap handler

Otherwise
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

>  
> 
