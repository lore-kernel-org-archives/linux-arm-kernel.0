From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 22 Nov 2018 22:29:15 +0100
Subject: [PATCH 0/3] Meson8b: add the CPU clock post-dividers
In-Reply-To: <59801d61ba4e5d5fc8f0df1adffad1f9c7afb45c.camel@baylibre.com>
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
 <59801d61ba4e5d5fc8f0df1adffad1f9c7afb45c.camel@baylibre.com>
Message-ID: <CAFBinCAgJTRgF-YX2Yt84c57URvV6Tr_R7=s1tjFPyzeWmup-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Thu, Nov 22, 2018 at 10:05 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Fri, 2018-11-16 at 21:53 +0100, Martin Blumenstingl wrote:
> > This is the successor to my previous series "meson8b: add the CPU_DIV16
> > clock for the ARM TWD" from [0]. I decided to not send this as v2 of
> > the original series because the PERIPH clock is not the CPU_DIV16 clock.
> > It's not clear whether a CPU_DIV16 clock exists.
> >
> > With this series we get all the CPU_CLK post-dividers as listed in the
> > public S805 datasheet [1] on pages 31 and 32:
> > - ABP
> > - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> > - AXI
> > - L2 DRAM
> >
> > Each of these clocks has a register called "..._CLK_DIS" which is
> > documented as a "just in case" bit:
> > "Set to 1 to manually disable the [...] clock when changing the mux
> > selection. Typically this bit is set to 0 since the clock muxes can
> > switch without glitches."
> > Since we're not supposed to touch that register we're setting
> > CLK_IS_CRITICAL for these clocks in the driver.
>
> If we are not supposed to touch the register, I'd prefer if you used RO ops
> instead of using CLK_IS_CRITICAL.
that makes sense as other "read-only" clocks are using RO ops as well.
I'll add a new patch which introduces clk_regmap_gate_ro_ops as we
don't have that yet

> >
> > The result of this is that we can use the PERIPH clock which clocks
> > the ARM TWD timer. I will send a separate series to add the TWD timer.
> >
> >
> > [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
> > [1]
> > https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
> >
> > Martin Blumenstingl (3):
> >   dt-bindings: clock: meson8b: export the CPU post dividers
> >   clk: meson: meson8b: rename cpu_div2/cpu_div3 to
> >     cpu_in_div2/cpu_in_div3
> >   clk: meson: meson8b: add the CPU clock post divider clocks
> >
> >  drivers/clk/meson/meson8b.c              | 268 ++++++++++++++++++++++-
> >  drivers/clk/meson/meson8b.h              |  17 +-
> >  include/dt-bindings/clock/meson8b-clkc.h |   4 +
> >  3 files changed, 276 insertions(+), 13 deletions(-)
> >
>
> With CLK_IS_CRITICAL removed, looks good to me:
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
thanks for reviewing this!


Regards
Martin
