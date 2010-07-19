From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 19 Jul 2010 14:11:32 +0400
Subject: [PATCH 4/5] ARMv6K and ARMv7 use fault statuses 3 and 6 as Access
	Flag fault
In-Reply-To: <bfd71c480c8d137cc4cc6261a42f514f9024ee53.1279529223.git.kirill@shutemov.name>
References: <cover.1279529223.git.kirill@shutemov.name>
	<bfd71c480c8d137cc4cc6261a42f514f9024ee53.1279529223.git.kirill@shutemov.name>
Message-ID: <4C4424D4.3000002@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Kirill A. Shutsemov wrote:

> Statuses 3 (0b00011) and 6 (0x00110) of DFSR are Access Flags faults on
> ARMv6K and ARMv7. Let's patch fsr_info[] at runtime if we are on ARMv7
> or later.

> Unfortunately, we don't have runtime check for 'K' extension, so we
> can't check for it.

> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
[...]
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 77cfdbe..d073b64 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -926,8 +926,18 @@ static int __init alignment_init(void)
>  
>  	hook_fault_code(1, do_alignment, SIGBUS, BUS_ADRALN,
>  			"alignment exception");
> -	hook_fault_code(3, do_alignment, SIGBUS, BUS_ADRALN,
> -			"alignment exception");
> +
> +	/*
> +	 * ARMv6K and ARMv7 use fault status 3 (0b00011) as Access Flag section
> +	 * fault, not as alignment error.
> +	 *
> +	 * TODO: handle ARMv6K properly. Runtime check for 'K' extension is
> +	 * needed.
> +	 */
> +	if (cpu_architecture() <= CPU_ARCH_ARMv6) {
> +		hook_fault_code(3, do_alignment, SIGBUS, BUS_ADRALN,
> +				"alignment exception");
> +	}

    Curly braces not neeed here. I assume you haven't run your patch thru 
scripts/checkpatch.pl?

WBR, Sergei
