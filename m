From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Feb 2018 13:57:21 +0100
Subject: [PATCH v5 01/26] ARM: shmobile: Add watchdog support
In-Reply-To: <1518457475-4480-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-2-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdUx3A_8MeZmrwiBRqUS0oGjwrg13fy1QMsA2SUw+dR0Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Mon, Feb 12, 2018 at 6:44 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> On R-Car Gen2 and RZ/G1 platforms, we use the SBAR registers to make non
> boot CPUs run a routine designed to bring up SMP and deal with hot plug.
> The value contained in the SBAR registers is not initialized by a WDT
> triggered reset, which means that after a WDT triggered reset we jump
> to the SMP bring up routine, preventing the system from executing the
> bootrom code.
>
> The purpose of this patch is to jump to the bootrom code in case of a
> WDT triggered reset, and keep the SMP functionality untouched.
> In order to tell if the code had been called due to the WDT overflowing
> we are testing WOVF from register RWTCSRA.
>
> The new function shmobile_boot_vector_gen2 isn't replacing
> shmobile_boot_vector for backward compatibility reasons. The kernel
> will install the best option (either shmobile_boot_vector or
> shmobile_boot_vector_gen2) to ICRAM1 after parsing the device tree,
> according to the amount of memory available.
>
> Since shmobile_boot_vector has become bigger, "reg" property of nodes
> compatible with "renesas,smp-sram" now need to be set to a value
> greater or equal to "<0 0x60>".
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

> --- a/arch/arm/mach-shmobile/common.h
> +++ b/arch/arm/mach-shmobile/common.h
> @@ -7,6 +7,12 @@ extern void shmobile_init_delay(void);
>  extern void shmobile_boot_vector(void);
>  extern unsigned long shmobile_boot_fn;
>  extern unsigned long shmobile_boot_size;
> +#ifdef CONFIG_ARCH_RCAR_GEN2

I think this #ifdef can be removed.

> +extern void shmobile_boot_vector_gen2(void);
> +extern unsigned long shmobile_boot_fn_gen2;
> +extern unsigned long shmobile_boot_cpu_gen2;
> +extern unsigned long shmobile_boot_size_gen2;
> +#endif /* CONFIG_ARCH_RCAR_GEN2 */
>  extern void shmobile_smp_boot(void);
>  extern void shmobile_smp_sleep(void);
>  extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
