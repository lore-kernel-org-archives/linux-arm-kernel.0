From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Oct 2018 09:31:31 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC SoC Updates for v4.20
In-Reply-To: <CAK8P3a0Uq+kmSs8Gq9EtqiVOrc6A+92Yc5mcU70Dounx=yycgQ@mail.gmail.com>
References: <cover.1538127537.git.horms+renesas@verge.net.au>
 <CAK8P3a0NreOTfL6L+w2WHnC5uf3jELf6ud_wdBZ7iAU3yuf4VA@mail.gmail.com>
 <CAMuHMdWF2XwWbb0-f_RuSYnFfQzLKNW7Foq9XM7cha3QVU+kHg@mail.gmail.com>
 <CAK8P3a22freS+j7hmB_bzFTq83eDrUidrV=mmaRYfYAV7gbwAQ@mail.gmail.com>
 <CAMuHMdWQ0aiLCra-DQrSQ+UB977PCZ7yNa9U_tT7Da7VuAyVXw@mail.gmail.com>
 <CAMuHMdUGJAMoVstt-UMMREwc5+NtwAe+qLmNZ9b9i1k3M8k=gQ@mail.gmail.com>
 <CAK8P3a0Uq+kmSs8Gq9EtqiVOrc6A+92Yc5mcU70Dounx=yycgQ@mail.gmail.com>
Message-ID: <20181008073131.f7ayp2tnyavp7xph@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 05:36:15PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 4, 2018 at 9:58 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Oct 2, 2018 at 2:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Oct 2, 2018 at 2:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Oct 2, 2018 at 10:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Sep 28, 2018 at 10:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Fri, Sep 28, 2018 at 12:21 PM Simon Horman
> > > > > > <horms+renesas@verge.net.au> wrote:
> > > > > > > * Add support for RZ/G2E (r8a774c0) and RZ/G2M (r8a774a1) SoCs
> > > > > > > * Enable Compare Match Timer (CMT) and Timer Unit (TMU)
> > > > > > >   for Renesas SoCs
> > > > > > > * Remove no longer needed ARCH_SHMOBILE Kconfig symbol
> > > > > >
> > > > > > The ARCH_SHMOBILE removal and cleanup is fine, but I wonder about
> > > > > > the newly added symbols for specific SoCs. I see you already have a
> > > > > > couple of those, but the other manufacturers don't.
> > > > > >
> > > > > > I think what happened here is that I tried to reject those additions
> > > > > > normally, but I never noticed yours. From what I see in drivers,
> > > > > > you have additional symbols depending on these in clk, pinctrl,
> > > > > > drivers/soc, and the dtb files, so at the very least we can't
> > > > > > just drop the config options, but I'd still like to see this work
> > > > > > more like other platforms.
> > > > >
> > > > > The main motivation for SoC-specific controls is to avoid including pinctrl
> > > > > and (to a lesser extent) clock tables for unused SoCs.  Each pinctrl driver
> > > > > consumes a few tens of KiB, each clock driver a few KiB.
> > > > > If we remove the SoC-specific ARCH_* controls, the user has to configure
> > > > > both pinctrl and clock driver selections, thus trading one user-visible
> > > > > symbol for two new user-visible symbols (except for RZ/A and RZ/N,
> > > > > where the pinctrl symbols are already visible, to allow reducing kernel
> > > > > size).
> > > > > Perhaps that is acceptable?
> > > >
> > > > It's definitely fine with me. I understand that this is less user friendly,
> > > > but it does address my concern about consistency between the platforms.
> > > >
> > > > > For the smaller parts in drivers/soc/, removing SoC-specific dependencies
> > > > > may be viable for R-Car and RZ/G Socs, but not for e.g. RZ/A.  The latter
> > > > > may be used without external RAM, and can run with a few MiB of internal
> > > > > SRAM, and XIP (with a still out-of-tree patch).
> > > > > So at least a family-specific dependency is worth to keep.  For now, RZ/A
> > > > > is arm32 only, though.
> > > > >
> > > > > Note that on arm64, there are no family-specific Kconfig symbols yet.
> > > > > We just have ARCH_RENESAS, which is also set on arm32.
> > > > > So either we introduce e.g. ARCH_RCAR_GEN3 (cfr. ARCH_RCAR_GEN1 and
> > > > > ARCH_RCAR_GEN2 or arm32), or use "ARCH_RENESAS && ARM64" for e.g. RST_RCAR
> > > > > in drivers/soc/renesas/Kconfig, which currently depends on all R-Car Gen3
> > > > > (and RZ/G2) SoCs explicitly.
> > > > > Choosing the latter option means we may need to migrate to the former option
> > > > > later, once other families appear (e.g. RZ/A SoCs may start using
> > > > > Cortex-A53 instead of Cortex-A9 cores).
> > > >
> > > > Maybe introducing a hidden ARCH_RCAR_GEN3 makes sense here, and
> > > > that can start out with the same value as ARCH_RENESAS. I think
> > > > if we want to add 64-bit RZ/A support later, having a separate top-level
> > > > symbol for that is also reasonable: as you explained this is rather
> > > > sensitive to memory usage, and that is enough reason to deviate from
> > > > what we do elsewhere.
> > > >
> > > > > For the DTB files, I believe we can just remove the dependencies, and
> > > > > always build all DTBs.
> > > >
> > > > Yes, that seems best, and consistent with how we handle other
> > > > manufacturers.
> > >
> > > OK, I'll put it on my list.
> >
> > Given the current time in the cycle, we can no longer do this for v4.20.
> > Hence, can you please accept Simon's PR as-is, to enable us to move
> > forward?
> 
> Fair enough, pulled into next/soc now.

Thanks Arnd!
