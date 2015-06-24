From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 24 Jun 2015 14:11:26 +0200
Subject: [PATCH/RFC 02/15] ARM: shmobile: R-Car: Add DT support for PM
 domains
In-Reply-To: <1433444021-22167-3-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
 <1433444021-22167-3-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdUfRBkBEU4CyTPVZ7BW=xk-6jn9BYwzL7-F_VMUwJC0YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 8:53 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- a/arch/arm/mach-shmobile/pm-rcar.c
> +++ b/arch/arm/mach-shmobile/pm-rcar.c

> @@ -51,11 +54,29 @@
>  static void __iomem *rcar_sysc_base;
>  static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
>
> +static unsigned int rcar_gen;
> +
>  static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
>  {
>         unsigned int sr_bit, reg_offs;
>         int k;
>
> +       /*
> +        * Only R-Car H1 can control power to CPUs
> +        * Use WFI to power off, CPG/APMU to resume ARM cores on later R-Car
> +        * Generations
> +        */
> +       switch (rcar_gen) {
> +       case 2:
> +               /* FIXME Check rcar_pm_domain.cpu instead? */
> +               switch (sysc_ch->chan_offs) {
> +               case SYSC_PWR_CA15_CPU:
> +               case SYSC_PWR_CA7_CPU:

Woops, this patch lacked:

+/*
+ * SYSC Power Control Register Base Addresses (R-Car Gen2)
+ */
+#define SYSC_PWR_CA15_CPU      0x40    /* CA15 cores (incl. L1C) (H2/M2/V2H) */
+#define SYSC_PWR_CA7_CPU       0x1c0   /* CA7 cores (incl. L1C) (H2/E2) */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
