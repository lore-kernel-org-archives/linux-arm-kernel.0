From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Oct 2016 19:25:22 +0530
Subject: [PATCH 2/3] arm64: dts: uniphier: add CPU clock and OPP table
 for LD11 SoC
In-Reply-To: <CAK7LNATc2XxAZf-rvMkRjGn3q_18yB=9aycAE1j9+n0==xzaHQ@mail.gmail.com>
References: <1476629958-25368-1-git-send-email-yamada.masahiro@socionext.com>
 <1476629958-25368-3-git-send-email-yamada.masahiro@socionext.com>
 <20161018112548.GA11471@vireshk-i7>
 <CAK7LNATc2XxAZf-rvMkRjGn3q_18yB=9aycAE1j9+n0==xzaHQ@mail.gmail.com>
Message-ID: <20161019135522.GH11471@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-10-16, 17:33, Masahiro Yamada wrote:
> Hi Viresh,
> 
> 
> 2016-10-18 20:25 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> > On 16-10-16, 23:59, Masahiro Yamada wrote:
> >> +     cluster0_opp: opp_table {
> >> +             compatible = "operating-points-v2";
> >> +             opp-shared;
> >> +
> >> +             opp at 245000000 {
> >> +                     opp-hz = /bits/ 64 <245000000>;
> >> +                     clock-latency-ns = <300>;
> >> +             };
> >> +             opp at 250000000 {
> >> +                     opp-hz = /bits/ 64 <250000000>;
> >> +                     clock-latency-ns = <300>;
> >> +             };
> >> +             opp at 490000000 {
> >> +                     opp-hz = /bits/ 64 <490000000>;
> >> +                     clock-latency-ns = <300>;
> >> +             };
> >> +             opp at 500000000 {
> >> +                     opp-hz = /bits/ 64 <500000000>;
> >> +                     clock-latency-ns = <300>;
> >> +             };
> >> +             opp at 653333333 {
> >
> > Why isn't ^^ matching with below values ? Same in next patch as well.
> 
> 
> 
> When I try to update /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq,
> it did not work as I had expected.
> 
> 
> scaling_max_freq is specified by kHz unit,
> on the other hand, clock frequency in the clk driver is specified by Hz.
> 
> 
> 
> If the operating point is 653333kHz, the cpufreq requests
> the clk driver to set 653333000, but it is lower than
> the exact clock, 653333333.
> So, the next lower frequency, 500000000 is selected.
> As a result, the operating point 653333kHz is never enabled.
> 
> 
> So, the operating point must be equal or a little bit bigger.
> 
> 
> Do you know a better way to solve this distortion?

I am not sure about how to fix that problem but there is no reason to
have the exact frequency in opp@*** name. Just use what you have used
in opp-hz line and you will have the exact same behavior.

Right now, its a bit confusing if we read the DT.

-- 
viresh
