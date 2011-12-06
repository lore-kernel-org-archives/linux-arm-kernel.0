From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 06 Dec 2011 15:40:25 +0400
Subject: [PATCH] ARM: davinci: dm368 evm: add support for CPLD version
 specific cpu_is_* macro
In-Reply-To: <1323168359-17943-1-git-send-email-prakash.pm@ti.com>
References: <1323168359-17943-1-git-send-email-prakash.pm@ti.com>
Message-ID: <4EDDFF29.1020009@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06-12-2011 14:45, Manjunathappa, Prakash wrote:

> From: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

> DM368 and DM365 EVMs have different CPLD versions. This patch
> adds function which differentiates DM368 from DM365 EVMs.

> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> ---
>   arch/arm/mach-davinci/include/mach/common.h  |    1 +
>   arch/arm/mach-davinci/include/mach/cputype.h |   11 +++++++++++
>   2 files changed, 12 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
> index a57cba2..f89cd2a 100644
> --- a/arch/arm/mach-davinci/include/mach/common.h
> +++ b/arch/arm/mach-davinci/include/mach/common.h
> @@ -52,6 +52,7 @@ struct davinci_soc_info {
>   	u32				cpu_id;
>   	u32				jtag_id;
>   	u32				jtag_id_reg;
> +	u8				cpld_version;

    Come on, CPLD is not a part of a SoC and the structure is called 
*davinci_soc_info*.

> diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/include/mach/cputype.h
> index 957fb87..ef02ab1 100644
> --- a/arch/arm/mach-davinci/include/mach/cputype.h
> +++ b/arch/arm/mach-davinci/include/mach/cputype.h
> @@ -49,6 +49,15 @@ IS_DAVINCI_CPU(da830, DAVINCI_CPU_ID_DA830)
>   IS_DAVINCI_CPU(da850, DAVINCI_CPU_ID_DA850)
>   IS_DAVINCI_CPU(tnetv107x, DAVINCI_CPU_ID_TNETV107X)
>
> +#define IS_DAVINCI_CPU_CPLD_VER(type, id, cpld_ver)			\
> +static inline int is_davinci_ ##type(void)				\
> +{									\
> +	return ((davinci_soc_info.cpu_id == (id))&&			\
> +		(davinci_soc_info.cpld_version == (cpld_ver)));		\
> +}
> +
> +IS_DAVINCI_CPU_CPLD_VER(dm368, DAVINCI_CPU_ID_DM365, 0x21)
> +

    If DM365 is indistinguishable from DM368 except when being on an EVM 
board, so be it.

WBR, Sergei
