From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 26 Apr 2011 09:48:10 +1200
Subject: [PATCH 02/14] at91: introduce commom AT91_BASE_SYS
In-Reply-To: <1303756284-26529-2-git-send-email-plagnioj@jcrosoft.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4DB5EC1A.7080400@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2011 06:31 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> on all at91 except rm9200 and x40 have the System Controller start in reallity
> at 0xffffc000 of 16KiB

Hi Jean,

I think this should be reworded as something like:

"On all AT91 variants except the RM9200 and x40 the system controller
starts at address 0xffffc000 and has a size of 16KiB."

> 
> on rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
> at 0xfffff000

This bit is okay.

> so we will use a common AT91_BASE_SYS at 0xffffc000 of 16KiB
> and map the same memory space

"This patch removes the individual definitions of AT91_BASE_SYS and
replaces them with a common version at base 0xfffffc000 and size 16KiB".

<snip>

> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index 7bdf566..46ae08f 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -20,16 +20,12 @@
>  #include <mach/at91_st.h>
>  #include <mach/cpu.h>
>  
> +#include "soc.h"
>  #include "generic.h"
>  #include "clock.h"
>  
>  static struct map_desc at91rm9200_io_desc[] __initdata = {
>  	{
> -		.virtual	= AT91_VA_BASE_SYS,
> -		.pfn		= __phys_to_pfn(AT91_BASE_SYS),
> -		.length		= SZ_4K,
> -		.type		= MT_DEVICE,
> -	}, {

If the RM9200 system controller is not at the same base address as the
other variants then how does the common AT91_BASE_SYS work correctly? I
can't see an offseting code. What am I missing?

<snip>

> diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
> index 3d64a75..b7ff44a 100644
> --- a/arch/arm/mach-at91/include/mach/hardware.h
> +++ b/arch/arm/mach-at91/include/mach/hardware.h
> @@ -16,6 +16,20 @@
>  
>  #include <asm/sizes.h>
>  
> +#if !defined(CONFIG_ARCH_AT91X40)
> +/*
> + * on all at91 except rm9200 and x40 have the System Controller start in reallity
> + * at 0xffffc000 of 16KiB
> + *
> + * on rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
> + * at 0xfffff000
> + *
> + * so we will use a common AT91_BASE_SYS at 0xffffc000 of 16KiB
> + * and map the same memory space

Please reword this as suggested for the changelog.

<snip>

> diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
> new file mode 100644
> index 0000000..6c30d74
> --- /dev/null
> +++ b/arch/arm/mach-at91/soc.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2007 Atmel Corporation.
> + * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> + *
> + * Under GPLv2
> + *
> + */
> +
> +struct at91_soc {
> +	char *name;

Should be const. Do we really need the name of the AT91 variant? We
could just export the initialize function and get rid of this new struct
which would further reduce the line count?

> +
> +	void (*init)(unsigned long main_clock);
> +};
> +
> +extern struct at91_soc at91rm9200_soc;
> +extern struct at91_soc at91sam9260_soc;
> +extern struct at91_soc at91sam9261_soc;
> +extern struct at91_soc at91sam9263_soc;
> +extern struct at91_soc at91sam9rl_soc;
> +extern struct at91_soc at91sam9g45_soc;
> +extern struct at91_soc at91cap9_soc;
> +extern struct at91_soc at572d940hf_soc;

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
