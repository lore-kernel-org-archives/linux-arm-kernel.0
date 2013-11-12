From: robherring2@gmail.com (Rob Herring)
Date: Tue, 12 Nov 2013 08:19:52 -0600
Subject: [PATCH 1/7] ARM: sa1100: switch to MULTI_IRQ_HANDLER
In-Reply-To: <1384264061-6174-1-git-send-email-linus.walleij@linaro.org>
References: <1384264061-6174-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_JsqJz6deAwLd1i+S-H59AQep3LWBosSRtzOSa+EQeeEd7VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 7:47 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This rewrites the entry-macro for the SA1100 in C and selects
> MULTI_IRQ_HANDLER for this platform, creates a local struct for
> two of the irq_chips in the SA1100 irq controller, and uses
> an irqdomain to map the 32 non-cascaded IRQs on this platform.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/Kconfig                                |   2 +
>  arch/arm/mach-sa1100/assabet.c                  |   1 +
>  arch/arm/mach-sa1100/badge4.c                   |   1 +
>  arch/arm/mach-sa1100/cerf.c                     |   1 +
>  arch/arm/mach-sa1100/collie.c                   |   1 +
>  arch/arm/mach-sa1100/generic.h                  |   3 +
>  arch/arm/mach-sa1100/h3100.c                    |   1 +
>  arch/arm/mach-sa1100/h3600.c                    |   1 +
>  arch/arm/mach-sa1100/hackkit.c                  |   1 +
>  arch/arm/mach-sa1100/include/mach/entry-macro.S |  41 ---------
>  arch/arm/mach-sa1100/irq.c                      | 112 ++++++++++++++++--------
>  arch/arm/mach-sa1100/jornada720.c               |   1 +
>  arch/arm/mach-sa1100/lart.c                     |   1 +
>  arch/arm/mach-sa1100/nanoengine.c               |   1 +
>  arch/arm/mach-sa1100/pleb.c                     |   1 +
>  arch/arm/mach-sa1100/shannon.c                  |   1 +
>  arch/arm/mach-sa1100/simpad.c                   |   1 +
>  17 files changed, 93 insertions(+), 78 deletions(-)
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c0c4ea0582f..dedca8a21e77 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -687,7 +687,9 @@ config ARCH_SA1100
>         select CPU_SA1100
>         select GENERIC_CLOCKEVENTS
>         select HAVE_IDE
> +       select IRQ_DOMAIN
>         select ISA
> +       select MULTI_IRQ_HANDLER
>         select NEED_MACH_MEMORY_H
>         select SPARSE_IRQ
>         help
> diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
> index e838ba27e443..e0285a9581de 100644
> --- a/arch/arm/mach-sa1100/assabet.c
> +++ b/arch/arm/mach-sa1100/assabet.c
> @@ -622,6 +622,7 @@ MACHINE_START(ASSABET, "Intel-Assabet")
>         .map_io         = assabet_map_io,
>         .nr_irqs        = SA1100_NR_IRQS,
>         .init_irq       = sa1100_init_irq,
> +       .handle_irq     = sa1100_handle_irq,

In interest of shrinking the machine_desc, can you set the handler in
sa1100_init_irq instead? That is how the gic and vic initialization
work now. sa1100_handle_irq can also then become static.

Rob
