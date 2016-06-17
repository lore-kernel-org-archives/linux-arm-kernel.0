From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Fri, 17 Jun 2016 17:57:30 +0200
Subject: [PATCH v4 04/13] soc: renesas: rcar-sysc: Move SYSC interrupt
 config to rcar-sysc driver
In-Reply-To: <1466072862-28030-5-git-send-email-geert+renesas@glider.be>
References: <1466072862-28030-1-git-send-email-geert+renesas@glider.be>
 <1466072862-28030-5-git-send-email-geert+renesas@glider.be>
Message-ID: <CAO3366wPzeUYLg9bS-fj=kom+jowrQq8p_=vGSOKrh7kutxVww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 12:27 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> On R-Car H1 and Gen2, the SYSC interrupt registers are always configured
> using hardcoded values in platform code. For R-Car Gen2, values are
> provided for H2 and M2-W only, other SoCs are not yet supported, and
> never will be.
>
> Move this configuration from SoC-specific platform code to the
> rcar_sysc_init() wrapper, so it can be skipped if the SYSC is configured
> from DT. This would be the case not only for H1, H2, and M2-W using a
> modern DTS, but also for other R-Car Gen2 SoCs not supported by the
> platform code, relying purely on DT.
>
> There is no longer a need to return the mapped register block, hence
> make the function return void.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - New.
> ---
>  arch/arm/mach-shmobile/pm-r8a7779.c   |  6 +-----
>  arch/arm/mach-shmobile/pm-rcar-gen2.c |  6 +-----
>  drivers/soc/renesas/rcar-sysc.c       | 12 ++++++++----
>  include/linux/soc/renesas/rcar-sysc.h |  2 +-
>  4 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
> index 4174cbcbc467d047..5c9a93f5e650181a 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7779.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7779.c
> @@ -23,11 +23,7 @@
>
>  static void __init r8a7779_sysc_init(void)
>  {
> -       void __iomem *base = rcar_sysc_init(0xffd85000);
> -
> -       /* enable all interrupt sources, but do not use interrupt handler */
> -       iowrite32(0x0131000e, base + SYSCIER);
> -       iowrite32(0, base + SYSCIMR);
> +       rcar_sysc_init(0xffd85000, 0x0131000e);
>  }
>
>  #else /* CONFIG_PM || CONFIG_SMP */
> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> index 61361dac6068210a..dd9ac366868f4336 100644
> --- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> @@ -36,11 +36,7 @@
>
>  static void __init rcar_gen2_sysc_init(u32 syscier)
>  {
> -       void __iomem *base = rcar_sysc_init(0xe6180000);
> -
> -       /* enable all interrupt sources, but do not use interrupt handler */
> -       iowrite32(syscier, base + SYSCIER);
> -       iowrite32(0, base + SYSCIMR);
> +       rcar_sysc_init(0xe6180000, syscier);
>  }
>
>  #else /* CONFIG_SMP */
> diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
> index 68d6856c9d3cd192..22f0d646225c444e 100644
> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -400,10 +400,14 @@ out_put:
>  }
>  early_initcall(rcar_sysc_pd_init);
>
> -void __iomem * __init rcar_sysc_init(phys_addr_t base)
> +void __init rcar_sysc_init(phys_addr_t base, u32 syscier)
>  {
> -       if (rcar_sysc_pd_init())
> -               rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
> +       if (!rcar_sysc_pd_init())
> +               return;
>
> -       return rcar_sysc_base;
> +       rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
> +
> +       /* enable all interrupt sources, but do not use interrupt handler */
> +       iowrite32(syscier, rcar_sysc_base + SYSCIER);
> +       iowrite32(0, rcar_sysc_base + SYSCIMR);
>  }
> diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
> index 92fc613ab23db091..7b8b280c181b8389 100644
> --- a/include/linux/soc/renesas/rcar-sysc.h
> +++ b/include/linux/soc/renesas/rcar-sysc.h
> @@ -11,6 +11,6 @@ struct rcar_sysc_ch {
>
>  int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
>  int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
> -void __iomem *rcar_sysc_init(phys_addr_t base);
> +void rcar_sysc_init(phys_addr_t base, u32 syscier);
>
>  #endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
> --
> 1.9.1
>

Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

CU
Uli
