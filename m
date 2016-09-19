From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Sep 2016 10:54:38 +0200
Subject: [PATCH RFC 4/8] ARM: shmobile: r8a7743: basic SoC support
In-Reply-To: <7093322.WFIWVqz40g@wasted.cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <7093322.WFIWVqz40g@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXpoSYQFXu17hc-jt-GrbgMsXuzjkzubujZTY3UJ95BRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Sep 16, 2016 at 3:33 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add minimal support for the RZ/G1M (R8A7743) SoC.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/mach-shmobile/Kconfig         |    5 ++++
>  arch/arm/mach-shmobile/Makefile        |    1
>  arch/arm/mach-shmobile/setup-r8a7743.c |   34 +++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> Index: renesas/arch/arm/mach-shmobile/Kconfig
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/Kconfig
> +++ renesas/arch/arm/mach-shmobile/Kconfig
> @@ -68,6 +68,11 @@ config ARCH_R8A7740
>         select ARCH_RMOBILE
>         select RENESAS_INTC_IRQPIN
>
> +config ARCH_R8A7743
> +       bool "RZ/G1M (R8A77430)"
> +       select ARCH_RCAR_GEN2
> +       select I2C

The only reason R8A779[013] selects I2C is because they need
regulator-quirk-rcar-gen2.c. Without schematics, it's hard to say if this is
needed for SK-RZG1M, too.

The Board Hardware Manual states SK-RZG1M has both DA9063 and DA9210.
It does state DA9063 is connected to IRQ2, but doesn't mention an interrupt
line for DA9210, so we don't know if they share IRQ2. Note that the Koelsch
fails to mention that DA9210 uses IRQ2, so this doesn't mean much.
For Porter we do not have the quirk enabled, while it has both regulators, too.

You can try to enable regulator-quirk-rcar-gen2.c for "renesas,sk-rzg1m" too,
and see what's printed by the kernel after a cold boot...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
