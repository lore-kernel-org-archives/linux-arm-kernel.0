From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Nov 2012 15:13:07 +0000
Subject: [PATCH V6 4/5] arm: mm: Add support for PJ4B cpu and init routines
In-Reply-To: <1353509970-5237-5-git-send-email-gregory.clement@free-electrons.com>
References: <1353509970-5237-1-git-send-email-gregory.clement@free-electrons.com>
 <1353509970-5237-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121121151307.GN11990@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 02:59:29PM +0000, Gregory CLEMENT wrote:
> PJ4B is an implementation of the ARMv7 (such as the Cortex A9 for
> example) released by Marvell. This CPU is currently found in
> Armada 370 and Armada XP SoCs. This patch provides a support for the
> specific initialization of this CPU.
> 
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/mach-mvebu/Kconfig |    2 +-
>  arch/arm/mm/Kconfig         |    4 +++
>  arch/arm/mm/proc-v7.S       |   66 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 79299cd..f4c3bf8 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -21,7 +21,7 @@ menu "Marvell SOC with device tree"
>  config MACH_ARMADA_370_XP
>  	bool
>  	select ARMADA_370_XP_TIMER
> -	select CPU_V7
> +	select CPU_PJ4B
>  
>  config MACH_ARMADA_370
>  	bool "Marvell Armada 370 boards"
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 94186b6..3fd629d 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -352,6 +352,10 @@ config CPU_PJ4
>  	select ARM_THUMBEE
>  	select CPU_V7
>  
> +config CPU_PJ4B
> +	bool
> +	select CPU_V7
> +
>  # ARMv6
>  config CPU_V6
>  	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 846d279..1aa3891 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -169,6 +169,62 @@ __v7_ca15mp_setup:
>  	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
>  	mcreq	p15, 0, r0, c1, c0, 1
>  #endif
> +
> +__v7_pj4b_setup:
> +#ifdef CONFIG_CPU_PJ4B
> +
> +/* Auxiliary Debug Modes Control 1 Register */
> +#define STATIC_BP     (1 << 2) /* Enable Static BP */
> +#define INTER_PARITY  (1 << 8) /* Disable Internal Parity Handling */
> +#define BCK_OFF_STREX (1 << 5) /* Enable the back off of STREX instr */
> +#define CLEAN_LINE    (1 << 16) /* Disable data transfer for clean line */
> +
> +/* Auxiliary Debug Modes Control 2 Register */
> +#define FAST_LDR      (1 << 23) /* Disable fast LDR */
> +#define SNOOP_DATA    (1 << 25) /* Do not interleave write and snoop data */
> +#define CWF           (1 << 27) /* Disable Critical Word First feature */
> +#define OUTSANDING_NC (1 << 29) /* Disable outstanding non cacheable request */

OUTSTANDING

> +#define L1_REP_RR     (1 << 30) /* L1 replacement - Strict round robin */
> +#define AUX_DBG_CTRL2 (SNOOP_DATA | CWF | OUTSANDING_NC | L1_REP_RR)
> +
> +/* Auxiliary Functional Modes Control Register 0 */
> +#define SMP_CFB         (1 << 1) /* Set SMP mode. Join the coherency fabric */
> +#define L1_PAR_CHK      (1 << 2) /* Support L1 parity checking */
> +#define BROADCAST_CACHE (1 << 8) /* Broadcast Cache and TLB maintenance */
> +
> +/* Auxiliary Debug Modes Control 0 Register */
> +#define WFI_WFE         (1 << 22) /* WFI/WFE - serve the DVM and back to idle */

It's probably worth prefixing these with PJ4B as well, since they don't
apply to other CPUs supported in this file.

Will
