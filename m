From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Sep 2018 11:47:00 +0200
Subject: [PATCH] arm64: enable CMT/TMU support for Renesas SoC
In-Reply-To: <ebd7d1f7-d99b-f0a1-f05e-d822254b2e86@cogentembedded.com>
References: <ebd7d1f7-d99b-f0a1-f05e-d822254b2e86@cogentembedded.com>
Message-ID: <CAMuHMdWr3c9m6XHboJj92MOXCrc6m6CiU96FYKA98pCm-D0QnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Aug 31, 2018 at 9:54 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Renesas R-Car gen3 SoCs have both CMT and TMU timers, so we have to enable
> building them in Kconfig.platforms (as they don't normally have the prompts
> in Kconfig).
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> The patch is against the ARM64 repo's 'for-next/core' branch.
>
>  arch/arm64/Kconfig.platforms |    2 ++
>  1 file changed, 2 insertions(+)
>
> Index: linux/arch/arm64/Kconfig.platforms
> ===================================================================
> --- linux.orig/arch/arm64/Kconfig.platforms
> +++ linux/arch/arm64/Kconfig.platforms
> @@ -175,6 +175,8 @@ config ARCH_RENESAS
>         select PM_GENERIC_DOMAINS
>         select RENESAS_IRQC
>         select SOC_BUS
> +       select SYS_SUPPORTS_SH_CMT
> +       select SYS_SUPPORTS_SH_TMU

Perhaps the CONFIG_SH_TIMER_CMT and _TMU logic should be reworked instead,
to allow the user to choose if he wants to enable the driver or not on platforms
that do not select these two symbls?

Hardcoding this to y depending on SYS_SUPPORTS_SH_* may be needed on
SuperH and older Renesas ARM SoCs, but R-Car Gen2+ and RZ/G now use the
ARM architectured timer by default.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
