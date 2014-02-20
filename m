From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 01:36:18 -0800
Subject: [PATCH] ARM: shmobile: Break out R-Car SYSC PM code
In-Reply-To: <20140115074308.8471.64824.sendpatchset@w520>
References: <20140115074308.8471.64824.sendpatchset@w520>
Message-ID: <CAOesGMjaTB-kBrm1av0uc8N-+4TRBZm5fxjJbsZLJe5OuqLu+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I spotted this patch since it adds new include/mach contents, comment below:

On Tue, Jan 14, 2014 at 11:43 PM, Magnus Damm <magnus.damm@gmail.com> wrote:

> --- /dev/null
> +++ work/arch/arm/mach-shmobile/include/mach/pm-rcar.h  2014-01-15 13:30:38.000000000 +0900
> @@ -0,0 +1,15 @@
> +#ifndef PM_RCAR_H
> +#define PM_RCAR_H
> +
> +struct rcar_sysc_ch {
> +       unsigned long chan_offs;
> +       unsigned int chan_bit;
> +       unsigned int isr_bit;
> +};
> +
> +int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
> +int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
> +bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
> +void __iomem *rcar_sysc_init(phys_addr_t base);
> +
> +#endif /* PM_RCAR_H */


These prototypes are only ever used by code in arch/arm/mach-shmobile,
right? There's no reason to expose it to the global include namespace,
and you'll just have to remove it when the platform is converted to
multiplatform.

So, I suggest moving this to be at arch/arm/mach-shmobile/pm-rcar.h
instead (and included as "pm-rcar.h" instead of <mach/pm-rcar.h>).


-Olof
