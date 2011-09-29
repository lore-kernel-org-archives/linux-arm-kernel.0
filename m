From: zdevai@gmail.com (Zoltan Devai)
Date: Thu, 29 Sep 2011 17:03:34 +0200
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <1317206507-18867-3-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
Message-ID: <CAGVye5O492Ev1Zz_8tTZKo16K+FALZ6Oo3TgyuzPuf7RYVyBzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/28 Jamie Iles <jamie@jamieiles.com>:
> Add a handler for the VIC that is suitable for MULTI_IRQ_HANDLER
> platforms. ?This can replace the ASM entry macros for platforms that use
> the VIC.
>
> v2: ? ? - allow the handler be used for !CONFIG_OF
> ? ? ? ?- use irq_domain_to_irq()
>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
> ?arch/arm/common/vic.c ? ? ? ? ? ? ? | ? 29 +++++++++++++++++++++++++++++
> ?arch/arm/include/asm/hardware/vic.h | ? ?4 ++++
> ?2 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 3f9c8f2..71adced 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c

> +asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
> +{
> + ? ? ? int i;
> +
> + ? ? ? for (i = 0; i < vic_id; ++i)
> + ? ? ? ? ? ? ? vic_single_handle_irq(&vic_devices[i], regs);
> +}
> +#endif /* CONFIG_MULTI_IRQ_HANDLER */

__exception_irq_entry doesn't compile with CONFIG_FUNCTION_GRAPH_TRACER enabled.
Either this file, or arch/arm/include/asm/system.h needs an #include
<linux/ftrace.h>

Cheers,
Zoltan
