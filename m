From: mwelling@ieee.org (Michael Welling)
Date: Thu, 30 Apr 2015 14:33:17 -0500
Subject: [PATCH 0/4] clk: si5351: Some fixes
In-Reply-To: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20150430193317.GC22000@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 07:45:50PM +0200, Sebastian Hesselbarth wrote:
> For Si5351 clock driver, Michael Welling and Jean-Francois Moine reported
> issues with recent v4.x kernels due to broken/missing/wrong parent clock
> claming. This patch set now deals with the issues reported.
> 
> Patch 1 amends the binding documentation mention clock-names property
> for the "xtal" and "clkin" parent clock inputs of Si5351 variants.
> 
> Patch 2 adds the clock-names property for the SolidRun CuBox using Si5351
> with a fixed oscillator connected to "xtal" input.
> 
> Patch 3 reworks the way we claim parent clocks by using devm_clk_get()
> for both DT and platform_data based registration. Also, properly check
> for errors returned by devm_clk_get() and prepare/enable the parent clocks.
> 
> Patch 4 introduces a function to reset PLLs on rate change. This should
> improve generated clock output stability. I currently have no scope at hand
> to actually test that properly, so there may be more issues remaining.
> 
> @Michael, Jean-Francois: Please test and report if there are still
> issues remaining.
>

Okay, the results are in and they are mixed. Firstly the clocks register
unlike before. This is a positive step that was certianly expected.

Second the reported and measured clock frequencies do not match the
device tree entries.

Measured frequencies:
clk0 12.5Mhz
clk1 5.357Mhz
clk2 0 Hz

Reported frequencies:
root at som3517-som200:~# head -n 15 /sys/kernel/debug/clk/clk_summary 
   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 ref27                                    1            1    27000000          0 0  
    xtal                                  0            0    27000000          0 0  
       pllb                               0            0   599999994          0 0  
          ms2                             0            0    12288000          0 0  
             clk2                         0            0    12288000          0 0  
          ms0                             0            0    12499999          0 0  
             clk0                         0            0    12499999          0 0  
       plla                               0            0   599999994          0 0  
          ms1                             0            0     5357142          0 0  
             clk1                         0            0     5357142          0 0  
 tclkin_ck                                0            0    12000000          0 0  
 virt_26000000_ck                         1            1    26000000          0 0  
    sys_clkin_ck                         11           23    26000000          0 0 

Device tree entry:
        si5351: clock-generator {
                #address-cells = <1>;
                #size-cells = <0>;
                #clock-cells = <1>;
                compatible = "silabs,si5351a-msop";
                reg = <0x60>;
                status = "okay";

                /* connect xtal input to 27MHz reference */
                clocks = <&ref27>;
                clock-names = "xtal";

                /* connect xtal input as source of pll0 and pll1 */
                silabs,pll-source = <0 0>, <1 0>;

                clkout0: clkout0 {
                        reg = <0>;
                        silabs,drive-strength = <8>;
                        silabs,multisynth-source = <1>;
                        silabs,clock-source = <0>;
                        silabs,pll-master;
                        clock-frequency = <18432000>;
                 };

                clkout1: clkout1 {
                        reg = <1>;
                        silabs,drive-strength = <8>;
                        silabs,multisynth-source = <0>;
                        silabs,clock-source = <0>;
                        silabs,pll-master;
                        clock-frequency = <8000000>;
                };

                clkout2: clkout2 {
                        reg = <2>;
                        silabs,drive-strength = <8>;
                        silabs,multisynth-source = <1>;
                        silabs,clock-source = <0>;
                        clock-frequency = <12288000>;
                };
        };

Lastly if #define DEBUG is added the behavior is different.

Debugging output:
[    2.970753] si5351 0-0060: si5351_clkout_round_rate - clk0: rdiv = 1, parent_rate = 18432000, rate = 18432000
[    2.981207] si5351 0-0060: si5351_msynth_round_rate - ms0: a = 48, b = 0, c = 1, divby4 = 0, parent_rate = 884736000, rate = 18432000
[    2.993777] si5351 0-0060: si5351_pll_round_rate - pllb: a = 32, b = 96, c = 125, parent_rate = 27000000, rate = 884736000
[    3.005362] si5351 0-0060: si5351_msynth_recalc_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, m = 6144, parent_rate = 884736000, rate = 18432000
[    3.026281] si5351 0-0060: si5351_pll_set_rate - pllb: p1 = 3682, p2 = 38, p3 = 125, parent_rate = 27000000, rate = 884736000
[    3.038151] si5351 0-0060: si5351_pll_recalc_rate - pllb: p1 = 3682, p2 = 38, p3 = 125, parent_rate = 27000000, rate = 884736000
[    3.053933] si5351 0-0060: si5351_msynth_set_rate - ms2: p1 = 0, p2 = 0, p3 = 0, divby4 = 1, parent_rate = 884736000, rate = 884736000
[    3.068067] si5351 0-0060: si5351_msynth_set_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, divby4 = 0, parent_rate = 884736000, rate = 18432000
[    3.080913] si5351 0-0060: si5351_msynth_recalc_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, m = 6144, parent_rate = 884736000, rate = 18432000
[    3.093843] si5351 0-0060: si5351_clkout_set_rate - clk0: rdiv = 1, parent_rate = 18432000, rate = 18432000
[    3.104184] si5351 0-0060: si5351_clkout_round_rate - clk1: rdiv = 1, parent_rate = 8000000, rate = 8000000
[    3.114408] si5351 0-0060: si5351_msynth_round_rate - ms1: a = 112, b = 0, c = 1, divby4 = 0, parent_rate = 896000000, rate = 8000000
[    3.126973] si5351 0-0060: si5351_pll_round_rate - plla: a = 33, b = 37037, c = 200000, parent_rate = 27000000, rate = 895999995
[    3.139085] si5351 0-0060: si5351_msynth_recalc_rate - ms1: p1 = 13824, p2 = 0, p3 = 1, m = 14336, parent_rate = 895999995, rate = 7999999
[    3.155510] si5351 0-0060: si5351_pll_set_rate - plla: p1 = 3735, p2 = 140736, p3 = 200000, parent_rate = 27000000, rate = 895999995
[    3.167993] si5351 0-0060: si5351_pll_recalc_rate - plla: p1 = 3735, p2 = 140736, p3 = 200000, parent_rate = 27000000, rate = 895999995
[    3.182186] si5351 0-0060: si5351_msynth_set_rate - ms1: p1 = 13824, p2 = 0, p3 = 1, divby4 = 0, parent_rate = 895999995, rate = 8000000
[    3.195028] si5351 0-0060: si5351_msynth_recalc_rate - ms1: p1 = 13824, p2 = 0, p3 = 1, m = 14336, parent_rate = 895999995, rate = 7999999
[    3.208046] si5351 0-0060: si5351_clkout_set_rate - clk1: rdiv = 1, parent_rate = 7999999, rate = 8000000
[    3.218150] si5351 0-0060: si5351_clkout_round_rate - clk2: rdiv = 1, parent_rate = 12288000, rate = 12288000
[    3.228544] si5351 0-0060: si5351_msynth_round_rate - ms2: a = 72, b = 0, c = 1, divby4 = 0, parent_rate = 884736000, rate = 12288000
[    3.242565] si5351 0-0060: si5351_msynth_set_rate - ms2: p1 = 8704, p2 = 0, p3 = 1, divby4 = 0, parent_rate = 884736000, rate = 12288000
[    3.255416] si5351 0-0060: si5351_msynth_recalc_rate - ms2: p1 = 8704, p2 = 0, p3 = 1, m = 9216, parent_rate = 884736000, rate = 12288000
[    3.268345] si5351 0-0060: si5351_clkout_set_rate - clk2: rdiv = 1, parent_rate = 12288000, rate = 12288000


Measured frequencies:
clk0 18.432Mhz
clk1 8Mhz
clk2 0Hz

Reported frequencies:
root at som3517-som200:~# head -n 15 /sys/kernel/debug/clk/clk_summary
   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 ref27                                    1            1    27000000          0 0  
    xtal                                  0            0    27000000          0 0  
       pllb                               0            0   884736000          0 0  
          ms2                             0            0    12288000          0 0  
             clk2                         0            0    12288000          0 0  
          ms0                             0            0    18432000          0 0  
             clk0                         0            0    18432000          0 0  
       plla                               0            0   895999995          0 0  
          ms1                             0            0     7999999          0 0  
             clk1                         0            0     7999999          0 0  
 tclkin_ck                                0            0    12000000          0 0  
 virt_26000000_ck                         1            1    26000000          0 0  
    sys_clkin_ck                         11           23    26000000          0 0

It should be noted that if I program the device's register map in the
bootloader the device keeps the correct frequency outputs.

So the patch series appears to fix the registration issue but there is still
more work to be done.

Still not sure how to explain the difference when DEBUG is defined.
I will dig into the datasheet and see what I can find.

> Sebastian
> 
> Sebastian Hesselbarth (4):
>   clk: si5351: Mention clock-names in the binding documentation
>   ARM: dove: Add clock-names to CuBox Si5351 clk generator
>   clk: si5351: Do not pass struct clk in platform_data
>   clk: si5351: Reset PLL after rate change
> 
>  .../devicetree/bindings/clock/silabs,si5351.txt    |  4 +-
>  arch/arm/boot/dts/dove-cubox.dts                   |  1 +
>  drivers/clk/clk-si5351.c                           | 87 +++++++++++++++++-----
>  include/linux/platform_data/si5351.h               |  4 -
>  4 files changed, 73 insertions(+), 23 deletions(-)
> 
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> Cc: Michael Welling <mwelling@ieee.org>
> Cc: Russell King <rmk+linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> -- 
> 2.1.0
> 
