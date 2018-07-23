From: realmz6@gmail.com (Steven Miao)
Date: Mon, 23 Jul 2018 14:51:31 +0800
Subject: [Eas-dev] Computing the dynamic-power-coefficient on Exynos5422
In-Reply-To: <8966420ddb4d4f40bbbc44b58da2881b@MSX-L106.msx.ad.zih.tu-dresden.de>
References: <8966420ddb4d4f40bbbc44b58da2881b@MSX-L106.msx.ad.zih.tu-dresden.de>
Message-ID: <CAMk6uBkjKpPvbqiL552-vrfzgecb4L6Cq+AyKhTm3XJ0Z=_y5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  Oliver,

Generally these dynamic co-efficiency and static leakage power comes
from hardware design team by running power estimation tool, however
you can tun these co-efficiency and parameters for better performance.

On Fri, Jul 20, 2018 at 10:16 PM Oliver Effland
<s5770874@msx.tu-dresden.de> wrote:
>
> Hello everyone,
>
> I hope this is the right place to ask, otherwise please just point me in the right direction.
>
> I'm currently testing the EAS patches [v4] on an ODROID-XU3 board, which has an Exynos5422 SoC. However, the corresponding DT is missing the "dynamic-power-coefficient" that is needed for an appropriate EM.
> So I'm trying to compute the dynamic-power-coefficient according to the formula:
>
> Pdyn = dynamic-power-coefficient * V^2 * f
>
> The frequency f is given by the DT.The actual Voltage and Power are determined by means of the on-chip sensors (returns the values for the specific cluster). When using the Voltage given in the DT, the differences for the d-p-coefficient are negligible.
>
> So I'm calculating the d-p-coefficient (mW/MHz/uV^2) by reading out the following SoC sensor values.
How did you get A7 or A15 power? Get Soc power or there's separate
sensor for A7/A15?
If you want to create cpu busy power model manually, you can:
1 leave 1 A7 + 1 A15 core online, keep other cores offline, disable
thermal zone, disable idle state for all cores
2 set A7 frequency to 200Mhz, move all the task to A15, run cpu
intensive task on A7(dhrystone, sysbench cpu test), read sensor to get
1 A7 power P1(read from A7 cluster sensor)
3 online 2 A7 core, run dhrystone on each core, and get power P2

we can get 1 A7 core power at 200Mhz ~= P2 - P1 (A7 power X 2 + static
power - A7 power X 1 - static power)

>
> For the little cluster (A7):
> frequency(MHz)  Voltage(V)  Power(mW)   Dynamic-power-coefficient
>  200            0.9175       49.470     ~2.938*10^-13
>  400            0.9165       91.892     ~2.736*10^-13
>  600            0.9638      149.454     ~2.682*10^-13
>  800            1.0263      223.453     ~2.652*10^-13
> 1000            1.1000      327.707     ~2.708*10^-13
> 1200            1.1725      445.899     ~2.703*10^-13
> 1400            1.2713      627.010     ~2.771*10^-13
>
> For the big cluster (A15):
> frequency(MHz)  Voltage(V)  Power(mW)   Dynamic-power-coefficient
>  200            0.9162       159.676    ~9.510*10^-13
>  500            0.9138       325.480    ~7.797*10^-13
>  800            0.9288       511.360    ~7.410*10^-13
> 1100            1.0063       828.020    ~7.434*10^-13
> 1400            1.0713      1209.774    ~7.530*10^-13
> 1700            1.1750      1835.784    ~7.822*10^-13
> 2000            1.2700      2661.849    ~8.252*10^-13
>
>
> But those values are way off for the DT, unless I multiply the d-p-coefficient with 10^15.
>
> Assuming the Power value needs to be subtracted by a static component (power usage when idle), the results change as follows:
>
> For the little cluster (A7):
> frequency(MHz)  Voltage(V)  P-dyn(mW)   Dynamic-power-coefficient
>  200            0.9175      36,381      ~2,160*10^-13
>  400            0.9165      73,438      ~2,186*10^-13
>  600            0.9638      122,470     ~2,197*10^-13
>  800            1.0263      184,135     ~2,185*10^-13
> 1000            1.1000      270,425     ~2,234*10^-13
> 1200            1.1725      367,121     ~2,225*10^-13
> 1400            1.2713      513,989     ~2,271*10^-13
>
> For the big cluster (A15):
> frequency(MHz)  Voltage(V)  P-dyn(mW)   Dynamic-power-coefficient
>  200            0.9162      99,834      ~5,945*10^-13
>  500            0.9138      244,651     ~5,860*10^-13
>  800            0.9288      401,986     ~5,825*10^-13
> 1100            1.0063      664,565     ~5,966*10^-13
> 1400            1.0713      985,268     ~6,132*10^-13
> 1700            1.1750      1494,173    ~6,366*10^-13
> 2000            1.2700      2086,273    ~6,467*10^-13
>
>
> While looking for examples in the kernel that calculate the dynamic-power-coefficient, I found this patch [1] by Caesar Wang that introduced this value for the rk3399 big cluster.
> Unfortunately, I'm unable to reproduce the same results for the coefficient with the given values. My results are also with a 10^-13 factor and even when I scale them with 10^15, my results have a certain margin of error:
>
> > frequency(MHz)  Voltage(V)  Current(mA) Dynamic-power-coefficient     (My) d-p-coefficient
> > 24              0.8         15
> > 48              0.8         23          ~417                          ~598
> > 96              0.8         40          ~443                          ~520
> > 216             0.8         82          ~438                          ~474
> > 312             0.8         115         ~430                          ~460
> > 408             0.8         150         ~455                          ~459
dynamic-power-coefficient ~= 400 - 500 is reasonable for big core
dynamic-power-coefficient  ~= 100 is reasonable for LITTLE core.
For IPA it can work effectively with a poor power model(not so
accurate), for EAS it just need power model of LITTLE core and big
core is proportional.
>
>
> Is this the right approach, or am I missing something?
> Hope someone can help me out.
>
> Thanks in advance,
> Oliver Effland
>
> [1] https://patchwork.kernel.org/patch/9861505/
>
> _______________________________________________
> eas-dev mailing list
> eas-dev at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/eas-dev

-Steven
