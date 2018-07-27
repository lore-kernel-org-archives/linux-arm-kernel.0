From: realmz6@gmail.com (Steven Miao)
Date: Fri, 27 Jul 2018 10:06:49 +0800
Subject: [Eas-dev] Computing the dynamic-power-coefficient on Exynos5422
In-Reply-To: <6eebf48cdf26496a9c53892549a99ed8@MSX-L106.msx.ad.zih.tu-dresden.de>
References: <6eebf48cdf26496a9c53892549a99ed8@MSX-L106.msx.ad.zih.tu-dresden.de>
Message-ID: <CAMk6uBmv0X2A69dJ8tqLLCLbsD1V4pzSkrxhdyThF_OV-6AM7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

On Thu, Jul 26, 2018 at 4:05 PM Oliver Effland
<s5770874@msx.tu-dresden.de> wrote:
>
> Hi,
>
> First of all: thanks for all the valuable input! @(Russell, Dietmar & Steven)
>
> On 07/23/2018 08:51 AM, Steven Miao wrote:
> > Hi  Oliver,
> >
> > Generally these dynamic co-efficiency and static leakage power comes
> > from hardware design team by running power estimation tool, however
> > you can tun these co-efficiency and parameters for better performance.
> >
> > How did you get A7 or A15 power? Get Soc power or there's separate
> > sensor for A7/A15?
> Yes indeed, there are 2 seperate sensors for the A7 and A15.
>
> > If you want to create cpu busy power model manually, you can:
> > 1 leave 1 A7 + 1 A15 core online, keep other cores offline, disable
> > thermal zone, disable idle state for all cores
> > 2 set A7 frequency to 200Mhz, move all the task to A15, run cpu
> > intensive task on A7(dhrystone, sysbench cpu test), read sensor to get
> > 1 A7 power P1(read from A7 cluster sensor)
> > 3 online 2 A7 core, run dhrystone on each core, and get power P2
> >
> > we can get 1 A7 core power at 200Mhz ~= P2 - P1 (A7 power X 2 + static
> > power - A7 power X 1 - static power
> I followed your manual steps (using a busy loop for 10s, instead of a benchmark) and corrected my calculations (with the static
> power in mind):
>
> A7:
> freq(MHz) voltage(mV) Power(mW) A7_Power(mW)  Stat_Power(mW) DPC
> 200       918.750     34.768    12.203        10.362         72.283955
> 400       920.000     60.805    21.25         18.305         62.765831
> 600       968.750     98.046    35.084        27.878         62.306652
> 800       1042.500    148.095   52.285        43.525         60.136063
> 1000      1116.250    212.214   76.112        59.99          61.084382
> 1200      1190.000    288.958   99.993        88.972         58.842948
> 1400      1288.750    411.936   144.807       122.322        62.276495
>
>                                                         mean: 62
>
> A15:
> freq(MHz) voltage(mV) Power(mW) A15_Power(mW) Stat_Power(mW) DPC
> 200       916250      122.584   31.139        60.306         185.458477
> 500       916250      225.101   68.774        87.553         163.842401
> 800       942500      349.158   112.432       124.294        158.211202
> 1100      1016250     540.78    169.556       201.668        149.251725
> 1400      1078750     779.19    258.214       262.762        158.493016
> 1700      1180000     1179.344  392.107       395.13         165.650083
> 2000      1320000     1969.764  648.768       672.228        186.170798
>
>                                                         mean: 164
>
> The ratio between A15 and A7 is now 164/62 = 2.645
>
> I hope the dynamic-power-coefficient's are more accurate now?
>
> > dynamic-power-coefficient ~= 400 - 500 is reasonable for big core
> > dynamic-power-coefficient  ~= 100 is reasonable for LITTLE core.
> > For IPA it can work effectively with a poor power model(not so
> > accurate), for EAS it just need power model of LITTLE core and big
> > core is proportional.
>
> I'm guessing my values differ from your suggested values, because it's 32bit ARM?
Yes, the ratio bit and LITTLE ~= 400/100 ~= 4.x is from A73 and A53 @
16nm process, it could vary from 32bit core or different process.
>
> Best regards,
> Oliver

Cheers,
Steven
