From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 Oct 2018 17:39:31 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC SoC Updates for v4.20
In-Reply-To: <CAMuHMdWQ0aiLCra-DQrSQ+UB977PCZ7yNa9U_tT7Da7VuAyVXw@mail.gmail.com>
References: <cover.1538127537.git.horms+renesas@verge.net.au>
 <CAK8P3a0NreOTfL6L+w2WHnC5uf3jELf6ud_wdBZ7iAU3yuf4VA@mail.gmail.com>
 <CAMuHMdWF2XwWbb0-f_RuSYnFfQzLKNW7Foq9XM7cha3QVU+kHg@mail.gmail.com>
 <CAK8P3a22freS+j7hmB_bzFTq83eDrUidrV=mmaRYfYAV7gbwAQ@mail.gmail.com>
 <CAMuHMdWQ0aiLCra-DQrSQ+UB977PCZ7yNa9U_tT7Da7VuAyVXw@mail.gmail.com>
Message-ID: <CAMuHMdXvU17JkfsZrZmci0nAhh0oJrXO3wYQ5nyox_aWUBdRzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Oct 2, 2018 at 2:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Oct 2, 2018 at 2:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Oct 2, 2018 at 10:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Sep 28, 2018 at 10:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Sep 28, 2018 at 12:21 PM Simon Horman
> > > > <horms+renesas@verge.net.au> wrote:
> > > > > * Add support for RZ/G2E (r8a774c0) and RZ/G2M (r8a774a1) SoCs
> > > > > * Enable Compare Match Timer (CMT) and Timer Unit (TMU)
> > > > >   for Renesas SoCs
> > > > > * Remove no longer needed ARCH_SHMOBILE Kconfig symbol
> > > >
> > > > The ARCH_SHMOBILE removal and cleanup is fine, but I wonder about
> > > > the newly added symbols for specific SoCs. I see you already have a
> > > > couple of those, but the other manufacturers don't.
> > > >
> > > > I think what happened here is that I tried to reject those additions
> > > > normally, but I never noticed yours. From what I see in drivers,
> > > > you have additional symbols depending on these in clk, pinctrl,
> > > > drivers/soc, and the dtb files, so at the very least we can't
> > > > just drop the config options, but I'd still like to see this work
> > > > more like other platforms.
> > >
> > > The main motivation for SoC-specific controls is to avoid including pinctrl
> > > and (to a lesser extent) clock tables for unused SoCs.  Each pinctrl driver
> > > consumes a few tens of KiB, each clock driver a few KiB.
> > > If we remove the SoC-specific ARCH_* controls, the user has to configure
> > > both pinctrl and clock driver selections, thus trading one user-visible
> > > symbol for two new user-visible symbols (except for RZ/A and RZ/N,
> > > where the pinctrl symbols are already visible, to allow reducing kernel
> > > size).
> > > Perhaps that is acceptable?
> >
> > It's definitely fine with me. I understand that this is less user friendly,

Upon closer look, the SoC-specific controls are also used to control compilation
of the SYSC (power domain) tables,  each consuming a few 100 bytes.
So either they become user-visible, too, or always compiled in (depending
on SoC family?).

> > but it does address my concern about consistency between the platforms.

I've just noticed Tegra also has SoC-specific controls, but they're located
in drivers/soc/tegra/Kconfig, not the main arch/arm64/Kconfig.platforms.
Do you consider that a viable alternative?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
