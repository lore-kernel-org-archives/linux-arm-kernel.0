From: vincent.abriou@st.com (Vincent ABRIOU)
Date: Mon, 28 Aug 2017 14:05:58 +0000
Subject: [v2,1/8] ARM: implement get_tls syscall
In-Reply-To: <20170817072347.19990-2-nicolas.pitre@linaro.org>
References: <20170817072347.19990-2-nicolas.pitre@linaro.org>
Message-ID: <9921300a-2fa4-9e2e-73a9-8b56b34d39eb@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

I have successfully tested your set of patches on cortex-M7 STM32 MCU.


On 08/17/2017 09:23 AM, Nicolas Pitre wrote:
> When there is no dedicated register to hold the tp value and no MMU
> to provide a fixed address kuser helper entry point, all that is
> left as fallback is a syscall.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent

> ---
>   arch/arm/include/uapi/asm/unistd.h | 1 +
>   arch/arm/kernel/traps.c            | 3 +++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
> index 28bd456494..575b25fc29 100644
> --- a/arch/arm/include/uapi/asm/unistd.h
> +++ b/arch/arm/include/uapi/asm/unistd.h
> @@ -35,5 +35,6 @@
>   #define __ARM_NR_usr26			(__ARM_NR_BASE+3)
>   #define __ARM_NR_usr32			(__ARM_NR_BASE+4)
>   #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
> +#define __ARM_NR_get_tls		(__ARM_NR_BASE+6)
>   
>   #endif /* _UAPI__ASM_ARM_UNISTD_H */
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 948c648fea..43c0560f7b 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -647,6 +647,9 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
>   		set_tls(regs->ARM_r0);
>   		return 0;
>   
> +	case NR(get_tls):
> +		return current_thread_info()->tp_value[0];
> +
>   	default:
>   		/* Calls 9f00xx..9f07ff are defined to return -ENOSYS
>   		   if not implemented, rather than raising SIGILL.  This
> 
