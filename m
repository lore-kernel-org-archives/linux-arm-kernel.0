From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Apr 2015 22:44:07 +0200
Subject: [PATCH 0/4] clk: si5351: Some fixes
In-Reply-To: <20150430193317.GC22000@deathray>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150430193317.GC22000@deathray>
Message-ID: <55429417.4070103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.04.2015 21:33, Michael Welling wrote:
> On Thu, Apr 30, 2015 at 07:45:50PM +0200, Sebastian Hesselbarth wrote:
>> For Si5351 clock driver, Michael Welling and Jean-Francois Moine reported
>> issues with recent v4.x kernels due to broken/missing/wrong parent clock
>> claming. This patch set now deals with the issues reported.

I should have been more precise above,
e.g. s/deals with/deals with some/

[...]
>
> Okay, the results are in and they are mixed. Firstly the clocks register
> unlike before. This is a positive step that was certianly expected.

Yes, claiming parent clocks is the main fix.

The pll reset patch should improve stability but datasheet isn't very
clear about when to reset pll nor how long it may take at max. Even the
Loss-of-Lock check isn't documented but seems to make sense.

> Second the reported and measured clock frequencies do not match the
> device tree entries.

But generated frequencies do always match reported frequencies.

I striped down your reports the the very essential lines.

> Measured frequencies:
> clk0 12.5Mhz
> clk1 5.357Mhz
> clk2 0 Hz
>
> Reported frequencies:
> root at som3517-som200:~# head -n 15 /sys/kernel/debug/clk/clk_summary
>     clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>               clk2                         0            0    12288000          0 0
>               clk0                         0            0    12499999          0 0
>               clk1                         0            0     5357142          0 0

What I noticed about your clk2 that you always measure as 0 Hz is
that none of your clocks is prepared/enabled.

Currently, the si5351 driver only ensures the output is enabled
when si5351_clkout_prepare() is called.

As long as you do not have a clk consumer that properly prepare/enables
the clock output, it may remain disabled.

We should probably have additional DT properties and corresponding
pdata to force clkoutN always on.

> Device tree entry:
>          si5351: clock-generator {
>                  /* connect xtal input to 27MHz reference */
>                  clocks = <&ref27>;
>                  clock-names = "xtal";
>
>                  clkout0: clkout0 {
>                          reg = <0>;
>                          clock-frequency = <18432000>;
>                  };
>
>                  clkout1: clkout1 {
>                          reg = <1>;
>                          clock-frequency = <8000000>;
>                  };
>
>                  clkout2: clkout2 {
>                          reg = <2>;
>                          clock-frequency = <12288000>;
>                  };
>          };
>
> Lastly if #define DEBUG is added the behavior is different.

Ok, I didn't dig into this. I think I'll rebuild your DT setup above
and see if I can reproduce it. It will be different with respect to
XTAL frequency, which is 25MHz on CuBox.

> Debugging output:
> [    2.970753] si5351 0-0060: si5351_clkout_round_rate - clk0: rdiv = 1, parent_rate = 18432000, rate = 18432000
> [    2.981207] si5351 0-0060: si5351_msynth_round_rate - ms0: a = 48, b = 0, c = 1, divby4 = 0, parent_rate = 884736000, rate = 18432000
> [    2.993777] si5351 0-0060: si5351_pll_round_rate - pllb: a = 32, b = 96, c = 125, parent_rate = 27000000, rate = 884736000
> [    3.005362] si5351 0-0060: si5351_msynth_recalc_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, m = 6144, parent_rate = 884736000, rate = 18432000
> [    3.026281] si5351 0-0060: si5351_pll_set_rate - pllb: p1 = 3682, p2 = 38, p3 = 125, parent_rate = 27000000, rate = 884736000
> [    3.038151] si5351 0-0060: si5351_pll_recalc_rate - pllb: p1 = 3682, p2 = 38, p3 = 125, parent_rate = 27000000, rate = 884736000
> [    3.053933] si5351 0-0060: si5351_msynth_set_rate - ms2: p1 = 0, p2 = 0, p3 = 0, divby4 = 1, parent_rate = 884736000, rate = 884736000

Above ms2 .set_rate() doesn't look good. It is called because ms2 is
child of pllb but the .params have not been setup. Usually this is
done in si5351_msynth_recalc_rate() but it has not been called yet.

I will probably initialize .params with current register contents
on probe().

> [    3.068067] si5351 0-0060: si5351_msynth_set_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, divby4 = 0, parent_rate = 884736000, rate = 18432000
> [    3.080913] si5351 0-0060: si5351_msynth_recalc_rate - ms0: p1 = 5632, p2 = 0, p3 = 1, m = 6144, parent_rate = 884736000, rate = 18432000
> [    3.093843] si5351 0-0060: si5351_clkout_set_rate - clk0: rdiv = 1, parent_rate = 18432000, rate = 18432000

> [    3.104184] si5351 0-0060: si5351_clkout_round_rate - clk1: rdiv = 1, parent_rate = 8000000, rate = 8000000
> [    3.114408] si5351 0-0060: si5351_msynth_round_rate - ms1: a = 112, b = 0, c = 1, divby4 = 0, parent_rate = 896000000, rate = 8000000
> [    3.126973] si5351 0-0060: si5351_pll_round_rate - plla: a = 33, b = 37037, c = 200000, parent_rate = 27000000, rate = 895999995
> [    3.139085] si5351 0-0060: si5351_msynth_recalc_rate - ms1: p1 = 13824, p2 = 0, p3 = 1, m = 14336, parent_rate = 895999995, rate = 7999999
> [    3.155510] si5351 0-0060: si5351_pll_set_rate - plla: p1 = 3735, p2 = 140736, p3 = 200000, parent_rate = 27000000, rate = 895999995
> [    3.167993] si5351 0-0060: si5351_pll_recalc_rate - plla: p1 = 3735, p2 = 140736, p3 = 200000, parent_rate = 27000000, rate = 895999995
> [    3.182186] si5351 0-0060: si5351_msynth_set_rate - ms1: p1 = 13824, p2 = 0, p3 = 1, divby4 = 0, parent_rate = 895999995, rate = 8000000
> [    3.195028] si5351 0-0060: si5351_msynth_recalc_rate - ms1: p1 = 13824, p2 = 0, p3 = 1, m = 14336, parent_rate = 895999995, rate = 7999999
> [    3.208046] si5351 0-0060: si5351_clkout_set_rate - clk1: rdiv = 1, parent_rate = 7999999, rate = 8000000

> [    3.218150] si5351 0-0060: si5351_clkout_round_rate - clk2: rdiv = 1, parent_rate = 12288000, rate = 12288000
> [    3.228544] si5351 0-0060: si5351_msynth_round_rate - ms2: a = 72, b = 0, c = 1, divby4 = 0, parent_rate = 884736000, rate = 12288000
> [    3.242565] si5351 0-0060: si5351_msynth_set_rate - ms2: p1 = 8704, p2 = 0, p3 = 1, divby4 = 0, parent_rate = 884736000, rate = 12288000
> [    3.255416] si5351 0-0060: si5351_msynth_recalc_rate - ms2: p1 = 8704, p2 = 0, p3 = 1, m = 9216, parent_rate = 884736000, rate = 12288000
> [    3.268345] si5351 0-0060: si5351_clkout_set_rate - clk2: rdiv = 1, parent_rate = 12288000, rate = 12288000

> Measured frequencies:
> clk0 18.432Mhz
> clk1 8Mhz
> clk2 0Hz
>
> Reported frequencies:
> root at som3517-som200:~# head -n 15 /sys/kernel/debug/clk/clk_summary
>     clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>               clk2                         0            0    12288000          0 0
>               clk0                         0            0    18432000          0 0
>               clk1                         0            0     7999999          0 0

Here again, reported frequencies and measured frequencies look quite
good. Why the requested frequencies differ when enabling DEBUG, I'll
have to have a closer look.

> It should be noted that if I program the device's register map in the
> bootloader the device keeps the correct frequency outputs.

"keeps"? You mean "generates", don't you?

> So the patch series appears to fix the registration issue but there is still
> more work to be done.

Yep. And your testing on a different setup definitely helps.

> Still not sure how to explain the difference when DEBUG is defined.
> I will dig into the datasheet and see what I can find.

Me neither.

Sebastian
