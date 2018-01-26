From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 11:16:09 +0100
Subject: [RFC 23/37] ARM: shmobile: rcar-gen2: Export
 shmobile_set_wdt_clock_status function
In-Reply-To: <1516903391-30467-24-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-24-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdVVazZ=OmThKaLM0a-n=rRUiHdpDH1=w8=ANOuV2u1YPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This patch exposes a function to set the value of variable
> "shmobile_wdt_clock_status" so that the watchdog driver may communicate
> critical information to the SMP bring up assembly routine.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks for your patch, but this is the part I don't like, as it calls into deep
platform code from a driver.

Some generic comments below...

> --- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> @@ -50,6 +50,16 @@ static inline u32 phys_to_sbar(phys_addr_t addr)
>  #define SYSCIER 0x0c
>  #define SYSCIMR 0x10
>
> +static void __iomem *shmobile_boot_vector_start;
> +static unsigned long clock_status;
> +
> +void shmobile_set_wdt_clock_status(unsigned long value)
> +{
> +       memcpy_toio(shmobile_boot_vector_start + clock_status,
> +                   &value, sizeof(value));

writel(shmobile_boot_vector_start + clock_status, value)?

> @@ -120,8 +130,12 @@ void __init rcar_gen2_pm_init(void)
>         if (!p)
>                 return;
>
> +       shmobile_boot_vector_start = p;
> +       clock_status = (&shmobile_wdt_clock_status -
> +                               (unsigned long *)shmobile_boot_vector) *
> +                               sizeof(shmobile_wdt_clock_status);

clock_status = (unsigned long)shmobile_wdt_clock_status -
               (unsigned long)shmobile_boot_vector?

> +
>         memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
> -       iounmap(p);
>
>         /* setup reset vectors */
>         p = ioremap_nocache(RST, 0x63);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
