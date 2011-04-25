From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 26 Apr 2011 10:08:07 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4DB5F0C7.2070903@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2011 06:31 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> instead of reading the registers everytime

Hi Jean, a couple of comments below.

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> ---
>  arch/arm/mach-at91/at91rm9200.c       |    8 -
>  arch/arm/mach-at91/at91sam9260.c      |    1 +
>  arch/arm/mach-at91/at91sam9rl.c       |    1 +
>  arch/arm/mach-at91/cpu.h              |  181 +++++++++++++++++
>  arch/arm/mach-at91/include/mach/cpu.h |  355 ++++++++++++++-------------------
>  arch/arm/mach-at91/soc.c              |   66 +++++-
>  6 files changed, 391 insertions(+), 221 deletions(-)
>  create mode 100644 arch/arm/mach-at91/cpu.h
>  rewrite arch/arm/mach-at91/include/mach/cpu.h (71%)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index abc4cc9..afb29b9 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -263,14 +263,6 @@ static void at91rm9200_reset(void)
>  	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
>  }
>  
> -int rm9200_type;
> -EXPORT_SYMBOL(rm9200_type);
> -
> -void __init at91rm9200_set_type(int type)
> -{
> -	rm9200_type = type;
> -}
> -

This only got introduce a couple of patches ago. I'm aware its a
stop-gap solution, but is it possible to rework/reorder the patches so
that this doesn't need to be temporarily introduced?

<snip>

> +
> +#ifdef CONFIG_ARCH_AT91RM9200
> +#define __cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
> +#else
> +#define __cpu_is_at91rm9200()	(0)
> +#endif

I haven't looked at the subsequent patches yet to see if this patch
simplifies things later but it seems that this just adds more lines of
code by having two copies of the each of the cpu_is_xxx macros (the
__cpu_is_xxx version which reads the register, and the cpu_is_xxx
version which reads the shadow value)?

What is the reasoning behind shadowing the cpu type rather than reading
the registers? The cpu detection macros are mostly used at
initialisation and device probe time, so they don't necessarily need to
be fast.

If this eventually reduces code size then I think it is useful, but
otherwise I'm not sure I see the point?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
