From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jan 2010 11:11:21 +0000
Subject: [RFC PATCH 05/12] arm: mm: retry on QSD icache parity errors
In-Reply-To: <1264719577-5436-6-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-6-git-send-email-dwalker@codeaurora.org>
Message-ID: <1264763482.4242.50.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 22:59 +0000, Daniel Walker wrote:
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 10e0680..bea3e75 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
[...]
>  static struct fsr_info {
>         int     (*fn)(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
>         int     sig;
> @@ -479,7 +513,7 @@ static struct fsr_info {
>         { do_bad,               SIGBUS,  0,             "unknown 19"                       },
>         { do_bad,               SIGBUS,  0,             "lock abort"                       }, /* xscale */
>         { do_bad,               SIGBUS,  0,             "unknown 21"                       },
> -       { do_bad,               SIGBUS,  BUS_OBJERR,    "imprecise external abort"         }, /* xscale */
> +       { do_imprecise_ext,     SIGBUS,  BUS_OBJERR,    "imprecise external abort"         }, /* xscale */

Can you not use hook_fault_code() and move the do_imprecise_ext() to a
platform-specific file (under arch/arm/mach-* maybe)?

-- 
Catalin
