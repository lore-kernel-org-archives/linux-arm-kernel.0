From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 25 May 2018 11:49:13 +0200
Subject: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <1527157834-7747-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1527157834-7747-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527157834-7747-3-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdWv2ZRbX=k5+H_WfAeoQ4QsyQLU9iQ9TJ9OQ0fmwg0GOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Thu, May 24, 2018 at 12:30 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
> requires a special enable method to get it started.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

>  arch/arm/mach-shmobile/smp-r9a06g032.c | 85 ++++++++++++++++++++++++++++++++++

I think you can safely call this driver smp-rzn1d.c, or smp-rzn1.c.
Source files are not covered by the stable DT ABI, and can be reordered
later at will.

I expect you will just add more CPU_METHOD_OF_DECLARE() lines later
(perhaps with a little bit of extra code to handle deviations).

> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RZ/N1D Second CA7 enabler.
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + * Derived from action,s500-smp
> + */
> +
> +#include <linux/delay.h>

Do you need this?

> +#include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
> +#include <asm/smp_scu.h>

Do you need these?

> +static void __init rzn1_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +       struct device_node *dn;
> +       int ret;
> +       u32 bootaddr;

> +       pr_info("CPU#1: cpu-release-addr %08x\n", (u32)bootaddr);

The cast is not needed.

> +
> +       cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));
> +       if (!cpu_bootaddr)
> +               pr_err("CPU#1: cpu-release-addr map failed\n");

If this fails, that is basically an OOM condition, which will scream anyway.
So I think you should drop the error message.

> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
