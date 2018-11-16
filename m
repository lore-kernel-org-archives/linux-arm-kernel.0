From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 16 Nov 2018 21:55:51 +0100
Subject: [PATCH 0/3] Meson8b: add the CPU clock post-dividers
In-Reply-To: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCB7i9QdCchqx1sV+cpD6b8Bp9rgK9Z+yv1UovdX3kasUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 9:53 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> This is the successor to my previous series "meson8b: add the CPU_DIV16
> clock for the ARM TWD" from [0]. I decided to not send this as v2 of
> the original series because the PERIPH clock is not the CPU_DIV16 clock.
> It's not clear whether a CPU_DIV16 clock exists.
>
> With this series we get all the CPU_CLK post-dividers as listed in the
> public S805 datasheet [1] on pages 31 and 32:
> - ABP
> - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> - AXI
> - L2 DRAM
>
> Each of these clocks has a register called "..._CLK_DIS" which is
> documented as a "just in case" bit:
> "Set to 1 to manually disable the [...] clock when changing the mux
> selection. Typically this bit is set to 0 since the clock muxes can
> switch without glitches."
> Since we're not supposed to touch that register we're setting
> CLK_IS_CRITICAL for these clocks in the driver.
>
> The result of this is that we can use the PERIPH clock which clocks
> the ARM TWD timer. I will send a separate series to add the TWD timer.
>
>
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
> [1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
>
> Martin Blumenstingl (3):
>   dt-bindings: clock: meson8b: export the CPU post dividers
>   clk: meson: meson8b: rename cpu_div2/cpu_div3 to
>     cpu_in_div2/cpu_in_div3
>   clk: meson: meson8b: add the CPU clock post divider clocks
I ran various tests for the PERIPH clock by enabling the TWD timer
without specifying a clock. In that case the TWD driver will try to
auto-detect the PERIPH clock rate. my results confirm that this
implementation is correct:

case #1: EC-100 with it's default boot settings:

[    0.000252] smp_twd: clock not found -2
[    0.000736] Calibrating local timer... 197.86MHz.

# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_out_sel        1        1        0   792000000
        0     0  50000
                cpu_clk               4        4        0   792000000
        0     0  50000
...
                   cpu_clk_div4       2        2        0   198000000
        0     0  50000
                      axi_clk_sel       1        1        0
198000000          0     0  50000
                         axi_clk_dis       1        1        0
198000000          0     0  50000
                      periph_clk_sel       1        1        0
198000000          0     0  50000
                         periph_clk_dis       1        1        0
198000000          0     0  50000
...


case #2: switch the parent of the cpu_in_sel clock to xtal:

m8b_m201_1G#md.l 0xC110419C 1
c110419c: 000000b1    ....
m8b_m201_1G#mw.l 0xC110419C 0xb0 1
m8b_m201_1G#md.l 0xC110419C
c110419c: 000000b0    ....

[    0.007005] smp_twd: clock not found -2
[    0.022680] Calibrating local timer... 5.98MHz.

# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
 xtal                                 4        4        0    24000000
        0     0  50000
...
    cpu_in_sel                        1        1        0    24000000
        0     0  50000
       cpu_scale_out_sel              1        1        0    24000000
        0     0  50000
          cpu_clk                     4        4        0    24000000
        0     0  50000
...
             cpu_clk_div4             2        2        0     6000000
        0     0  50000
                axi_clk_sel           1        1        0     6000000
        0     0  50000
                   axi_clk_dis        1        1        0     6000000
        0     0  50000
                periph_clk_sel        1        1        0     6000000
        0     0  50000
                   periph_clk_dis       1        1        0
6000000          0     0  50000
...


case #3: set cpu_scale_div to cpu_in_sel/6 and use cpu_scale_div as
parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#md.l 0xC110415C 1
c110415c: 800016a2    ....
m8b_m201_1G#mw.l 0xC110415C 0x802016A2 1
m8b_m201_1G#mw.l 0xC110419C 0xbd 1

[    0.001317] smp_twd: clock not found -2
[    0.003907] Calibrating local timer... 32.93MHz.


# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_div            1        1        0   132000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
132000000          0     0  50000
                   cpu_clk            4        4        0   132000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
33000000          0     0  50000
                         axi_clk_sel       1        1        0
33000000          0     0  50000
                            axi_clk_dis       1        1        0
33000000          0     0  50000
                         periph_clk_sel       1        1        0
33000000          0     0  50000
                            periph_clk_dis       1        1        0
 33000000          0     0  50000
...


case #4: set cpu_scale_div to cpu_in_sel/4 and use cpu_scale_div as
parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#md.l 0xC110415C 1
c110415c: 800016a2    ....
m8b_m201_1G#mw.l 0xC110415C 0x801016A2 1
m8b_m201_1G#mw.l 0xC110419C 0xbd 1

[    0.001317] smp_twd: clock not found -2
[    0.002636] Calibrating local timer... 49.42MHz.

# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_div            1        1        0   198000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
198000000          0     0  50000
                   cpu_clk            4        4        0   198000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
49500000          0     0  50000
                         axi_clk_sel       1        1        0
49500000          0     0  50000
                            axi_clk_dis       1        1        0
49500000          0     0  50000
                         periph_clk_sel       1        1        0
49500000          0     0  50000
                            periph_clk_dis       1        1        0
 49500000          0     0  50000
...


case #5: set cpu_scale_div to cpu_in_sel/12 and use cpu_scale_div as
parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#md.l 0xC110415C 1
c110415c: 800016a2    ....
m8b_m201_1G#mw.l 0xC110415C 0x805016A2 1
m8b_m201_1G#mw.l 0xC110419C 0xbd 1

[    0.001317] smp_twd: clock not found -2
[    0.007728] Calibrating local timer... 16.44MHz.


# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_div            1        1        0    66000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
66000000          0     0  50000
                   cpu_clk            4        4        0    66000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
16500000          0     0  50000
                         axi_clk_sel       1        1        0
16500000          0     0  50000
                            axi_clk_dis       1        1        0
16500000          0     0  50000
                         periph_clk_sel       1        1        0
16500000          0     0  50000
                            periph_clk_dis       1        1        0
 16500000          0     0  50000
...


case #6: use cpu_div2 as parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#mw.l 0xC110419C 0x34 1
m8b_m201_1G#mw.l 0xC110419C 0xb5 1

[    0.000534] smp_twd: clock not found -2
[    0.001487] Calibrating local timer... 98.91MHz.


# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
...
             cpu_div2                 1        1        0   396000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
396000000          0     0  50000
                   cpu_clk            4        4        0   396000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
99000000          0     0  50000
                         axi_clk_sel       1        1        0
99000000          0     0  50000
                            axi_clk_dis       1        1        0
99000000          0     0  50000
                         periph_clk_sel       1        1        0
99000000          0     0  50000
                            periph_clk_dis       1        1        0
 99000000          0     0  50000
...


case #7: use cpu_div3 as parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#mw.l 0xC110419C 0x38 1
m8b_m201_1G#mw.l 0xC110419C 0xb9 1

test skipped, the system is not stable with this clock as parent
