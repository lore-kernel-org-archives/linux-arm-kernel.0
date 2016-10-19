From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Oct 2016 17:33:00 +0900
Subject: [PATCH 2/3] arm64: dts: uniphier: add CPU clock and OPP table for
 LD11 SoC
In-Reply-To: <20161018112548.GA11471@vireshk-i7>
References: <1476629958-25368-1-git-send-email-yamada.masahiro@socionext.com>
 <1476629958-25368-3-git-send-email-yamada.masahiro@socionext.com>
 <20161018112548.GA11471@vireshk-i7>
Message-ID: <CAK7LNATc2XxAZf-rvMkRjGn3q_18yB=9aycAE1j9+n0==xzaHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,


2016-10-18 20:25 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 16-10-16, 23:59, Masahiro Yamada wrote:
>> +     cluster0_opp: opp_table {
>> +             compatible = "operating-points-v2";
>> +             opp-shared;
>> +
>> +             opp at 245000000 {
>> +                     opp-hz = /bits/ 64 <245000000>;
>> +                     clock-latency-ns = <300>;
>> +             };
>> +             opp at 250000000 {
>> +                     opp-hz = /bits/ 64 <250000000>;
>> +                     clock-latency-ns = <300>;
>> +             };
>> +             opp at 490000000 {
>> +                     opp-hz = /bits/ 64 <490000000>;
>> +                     clock-latency-ns = <300>;
>> +             };
>> +             opp at 500000000 {
>> +                     opp-hz = /bits/ 64 <500000000>;
>> +                     clock-latency-ns = <300>;
>> +             };
>> +             opp at 653333333 {
>
> Why isn't ^^ matching with below values ? Same in next patch as well.



When I try to update /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq,
it did not work as I had expected.


scaling_max_freq is specified by kHz unit,
on the other hand, clock frequency in the clk driver is specified by Hz.



If the operating point is 653333kHz, the cpufreq requests
the clk driver to set 653333000, but it is lower than
the exact clock, 653333333.
So, the next lower frequency, 500000000 is selected.
As a result, the operating point 653333kHz is never enabled.


So, the operating point must be equal or a little bit bigger.


Do you know a better way to solve this distortion?


-- 
Best Regards
Masahiro Yamada
