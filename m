From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 2 Oct 2018 10:30:56 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC SoC Updates for v4.20
In-Reply-To: <CAK8P3a0NreOTfL6L+w2WHnC5uf3jELf6ud_wdBZ7iAU3yuf4VA@mail.gmail.com>
References: <cover.1538127537.git.horms+renesas@verge.net.au>
 <CAK8P3a0NreOTfL6L+w2WHnC5uf3jELf6ud_wdBZ7iAU3yuf4VA@mail.gmail.com>
Message-ID: <CAMuHMdWF2XwWbb0-f_RuSYnFfQzLKNW7Foq9XM7cha3QVU+kHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Sep 28, 2018 at 10:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 28, 2018 at 12:21 PM Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > * Add support for RZ/G2E (r8a774c0) and RZ/G2M (r8a774a1) SoCs
> > * Enable Compare Match Timer (CMT) and Timer Unit (TMU)
> >   for Renesas SoCs
> > * Remove no longer needed ARCH_SHMOBILE Kconfig symbol
>
> The ARCH_SHMOBILE removal and cleanup is fine, but I wonder about
> the newly added symbols for specific SoCs. I see you already have a
> couple of those, but the other manufacturers don't.
>
> I think what happened here is that I tried to reject those additions
> normally, but I never noticed yours. From what I see in drivers,
> you have additional symbols depending on these in clk, pinctrl,
> drivers/soc, and the dtb files, so at the very least we can't
> just drop the config options, but I'd still like to see this work
> more like other platforms.

The main motivation for SoC-specific controls is to avoid including pinctrl
and (to a lesser extent) clock tables for unused SoCs.  Each pinctrl driver
consumes a few tens of KiB, each clock driver a few KiB.
If we remove the SoC-specific ARCH_* controls, the user has to configure
both pinctrl and clock driver selections, thus trading one user-visible
symbol for two new user-visible symbols (except for RZ/A and RZ/N,
where the pinctrl symbols are already visible, to allow reducing kernel
size).
Perhaps that is acceptable?

For the smaller parts in drivers/soc/, removing SoC-specific dependencies
may be viable for R-Car and RZ/G Socs, but not for e.g. RZ/A.  The latter
may be used without external RAM, and can run with a few MiB of internal
SRAM, and XIP (with a still out-of-tree patch).
So at least a family-specific dependency is worth to keep.  For now, RZ/A
is arm32 only, though.

Note that on arm64, there are no family-specific Kconfig symbols yet.
We just have ARCH_RENESAS, which is also set on arm32.
So either we introduce e.g. ARCH_RCAR_GEN3 (cfr. ARCH_RCAR_GEN1 and
ARCH_RCAR_GEN2 or arm32), or use "ARCH_RENESAS && ARM64" for e.g. RST_RCAR
in drivers/soc/renesas/Kconfig, which currently depends on all R-Car Gen3
(and RZ/G2) SoCs explicitly.
Choosing the latter option means we may need to migrate to the former option
later, once other families appear (e.g. RZ/A SoCs may start using
Cortex-A53 instead of Cortex-A9 cores).

For the DTB files, I believe we can just remove the dependencies, and
always build all DTBs.

What do you think?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
