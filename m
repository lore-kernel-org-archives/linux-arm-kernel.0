From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 15 Nov 2018 11:08:43 +0100
Subject: [RFC v1 0/7] Meson8b: make the CPU clock mutable
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
Message-ID: <ae3ede9e-ecc7-ad47-bd2c-9b760480ad85@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 14/11/2018 23:57, Martin Blumenstingl wrote:
> This allows changing the CPU clock on the 32-bit Amlogic Meson SoCs
> (Meson8, Meson8b and Meson8m2).
> CPU frequency scaling will be enabled with a separate series by adding
> the CPU clock and the OPP tables to meson8.dtsi and meson8b.dtsi.
> 
> While changing the CPU frequency (sys_pll or any of it's post-dividers)
> we need to run the CPU clock off the XTAL clock. Otherwise the system
> will lock up because we need to disable the sys_pll to change it's
> rate.
> 
> This also makes the clk-pll's .enable hook a no-op if the clock is
> already enabled. Otherwise we're getting lockups when calling the
> first clk_{prepare_}enable on the sys_pll or any of it's children (as
> the CCF propagates the enable event up to the sys_pll). This is because
> the .enable hook unconditionally disables and enables the clock.
> However, we can't disable that clock (not even temporarily) if the CPU
> is running off sys_pll.
> 
> Additionally this adds support for more M/N combinations in sys_pll to
> achieve all of the OPPs on Meson8b and all OPPs <= 1608 MHz on Meson8
> and Meson8m2.
> 
> Compared to Amlogic's 3.10 kernel there's one notable difference: we
> are actually allowing changes to the sys_pll. Amlogic's kernel sets
> sys_pll to a fixed rate during boot and then uses a timer generate a
> "virtual clock rate" by toggling between various dividers (for example:
> sys_pll is set to 1536MHz. to achieve 1008MHz they are toggling every
> 2500us between 1536MHZ and 768MHz so the average over <period, for
> example one second> is 1008MHz).
> I could reproduce any situation where changing sys_pll failed (for
> example due to high temperature). To prove that I ran "stress --cpu 4"
> for multiple hours and then cycled through all available CPU
> frequencies (while keeping "stress" running in the background). This
> worked fine on my Meson8b Odroid-C1 and EC-100 boards as well as my
> Meson8m2 board.
> 
> 
> Martin Blumenstingl (7):
>   clk: meson: meson8b: run from the XTAL when changing the CPU frequency
>   clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
>   clk: meson: clk-pll: check if the clock is already enabled
>   clk: meson: clk-pll: add the is_enabled function in the clk_ops
>   clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
>   clk: meson: meson8b: add support for more M/N values in sys_pll
>   clk: meson: meson8b: allow changing the CPU clock tree
> 
>  drivers/clk/meson/clk-pll.c | 23 +++++++++
>  drivers/clk/meson/meson8b.c | 94 +++++++++++++++++++++++++++++++++----
>  2 files changed, 108 insertions(+), 9 deletions(-)
> 

I suppose it depends on the fixes you sent earlier ?

Anyway, resend it without RFC and by squashing patch 4 in 3 and
address the small comment issue and I'll take it for 4.21 !

Thanks,
Neil
