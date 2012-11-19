From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Nov 2012 10:51:51 +0000
Subject: [PATCH V3 4/5] arm: mm: Added support for PJ4B cpu and init
 routines
In-Reply-To: <1352931637-3405-5-git-send-email-gregory.clement@free-electrons.com>
References: <1352931637-3405-1-git-send-email-gregory.clement@free-electrons.com>
 <1352931637-3405-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAHkRjk6BYB=OAFyQKwmA2vcpJ1w9MaYx6gRthEEy6F8GL48Kng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 14 November 2012 22:20, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 94186b6..3fd629d 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -352,6 +352,10 @@ config CPU_PJ4
>         select ARM_THUMBEE
>         select CPU_V7
>
> +config CPU_PJ4B
> +       bool
> +       select CPU_V7

With ARMv6 we started just using the generic architecture name for
different processors (i.e. CPU_V6, CPU_V7). Is PJ4B another ARMv7
implementation (like Cortex-A9)?

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 846d279..a4c0ccf 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -169,6 +169,47 @@ __v7_ca15mp_setup:
>         orreq   r0, r0, r10                     @ Enable CPU-specific SMP bits
>         mcreq   p15, 0, r0, c1, c0, 1
>  #endif
> +
> +__v7_pj4b_setup:
> +#ifdef CONFIG_CPU_PJ4B
> +
> +#define SNOOP_DATA    (1 << 25) /* Dont interleave write and snoop data */
> +#define CWF           (1 << 27) /* Disable Critical Word First feature */
> +#define OUTSANDING_NC (1 << 29) /* Disable outstanding non cacheable request */
> +#define L1_REP_RR     (1 << 30) /* L1 replacement - Strict round robin */
> +
> +#define AUX_DBG_CTRL2 (SNOOP_DATA | CWF | OUTSANDING_NC | L1_REP_RR)
> +
> +       /* Auxiliary Debug Modes Control 1 Register */
> +       mrc     p15, 1, r0, c15, c1, 1
> +       orr     r0, r0, #(1 << 16)     @ Disable data transfer for clean line.
> +       orr     r0, r0, #(1 << 5)      @ Enable the back off of STREX instr
> +       orr     r0, r0, #(1 << 8)      @ Disable Internal Parity Handling
> +       bic     r0, r0, #(1 << 2)      @ Disable Static BP
> +       mcr     p15, 1, r0, c15, c1, 1
> +
> +       /* Auxiliary Debug Modes Control 2 Register */
> +       mrc     p15, 1, r0, c15, c1, 2
> +       bic     r0, r0, #(1 << 23)   @ Enable fast LDR.
> +       orr     r0, r0, #AUX_DBG_CTRL2
> +       mcr     p15, 1, r0, c15, c1, 2
> +
> +       /* Auxiliary Functional Modes Control Register 0 */
> +       mrc     p15, 1, r0, c15, c2, 0
> +#ifdef CONFIG_SMP
> +       orr     r0, r0, #(1 << 1)     @ Set SMP mode. Join the coherency fabric
> +#endif
> +       orr     r0, r0, #(1 << 2)     @ Support L1 parity checking
> +       orr     r0, r0, #(1 << 8)     @ Broadcast Cache and TLB maintenance
> +       mcr     p15, 1, r0, c15, c2, 0
> +
> +       /* Auxiliary Debug Modes Control 0 Register */
> +       mrc     p15, 1, r0, c15, c1, 0
> +       orr     r0, r0, #(1 << 22)   @ WFI/WFE - serve the DVM and back to idle
> +       mcr     p15, 1, r0, c15, c1, 0

Any chance that these could be set by the firmware prior to starting
the kernel? We don't have any guidance for Linux here but longer term
it seems to cause problems (i.e. you add some secure layer in a new
CPU version).

-- 
Catalin
