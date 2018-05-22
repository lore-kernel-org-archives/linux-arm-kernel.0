From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 May 2018 12:38:05 +0200
Subject: [PATCH 07/14] ARM: spectre-v2: add Cortex A8 and A15 validation
 of the IBE bit
In-Reply-To: <E1fIuBF-0003q0-3d@rmk-PC.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuBF-0003q0-3d@rmk-PC.armlinux.org.uk>
Message-ID: <CAMuHMdWdfjmdnQVmX7PJsXV8PcHhCCwAeHgxXRSV3CjX4C_amg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, May 16, 2018 at 1:01 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:
> When the branch predictor hardening is enabled, firmware must have set
> the IBE bit in the auxiliary control register.  If this bit has not
> been set, the Spectre workarounds will not be functional.
>
> Add validation that this bit is set, and print a warning at alert level
> if this is not the case.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/mm/proc-v7-bugs.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/smp.h>
> +
> +static __maybe_unused void cpu_v7_check_auxcr_set(u32 mask, const char *msg)
> +{
> +       u32 aux_cr;
> +
> +       asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (aux_cr));
> +
> +       if ((aux_cr & mask) != mask)
> +               pr_err("CPU%u: %s", smp_processor_id(), msg);

pr_alert(), to match the patch description.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
