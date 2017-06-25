From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 25 Jun 2017 17:29:11 +0200
Subject: [PATCH] ARM: dts: exynos: Exynos5422 Odroid-XU* incomplete
 thermal-zones definition
In-Reply-To: <CANAwSgQV6rtbx=LqWxRS+_sRctWiU1L=np7cZU8hTYg_V8Fbnw@mail.gmail.com>
References: <20170623210913.ugutgop7ratwolfy@inc028000032.lancs.ac.uk>
 <CANAwSgSN5zi72m1td-NAaCPGLUZybSdefrKAo2t9v-gOXn3tGA@mail.gmail.com>
 <20170625133134.g4iinztozsp4p2aa@kozik-lap>
 <CANAwSgQV6rtbx=LqWxRS+_sRctWiU1L=np7cZU8hTYg_V8Fbnw@mail.gmail.com>
Message-ID: <20170625152911.kfq7vnxyhcqvfxpu@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 25, 2017 at 08:48:13PM +0530, Anand Moon wrote:
> Hi Krzystof,
> >> 2: We should also increase the tips from 4 to 8 to support different
> >> cluster of cpu's.
> >
> > There are 4 CPU thermal zones on Exynos5422. What do you want to expand?
> 
> What I meant was to support more trip point to address below.
> [    2.776320] exynos-tmu 100a0000.tmu: More trip points than
> supported by this TMU.
> [    2.782370] exynos-tmu 100a0000.tmu: 2 trip points should be
> configured in polling mode.
> 

I do not understand what you want to achieve. I added 2 trip points in
polling mode for the CPU cooling mode. Just describe the problem and
send the patch - it is the best way to explain one's thought...

> >> 3: To avoid duplication of cooling-maps we can make tmu sensor work
> >> differently for cluster of cpu's
> >>       tmu_cpu0: handle pwm-fan control.
> >>       tmu_cpu1: handle cpu[0-3] cpufreq mapping.
> >>       tmu_cpu2: handle cpu[4-7] cpufreq mapping.
> >
> > I miss the point behind this. Why fan should work only when CPU4
> > (tmu_cpu0) is heated and not CPU5-7 (rest of cpu tmu's)?
> 
> Ok fan should work on all the thermal zone. To avoid thermal shutdown.
> 
> But I want to avoid scaling down of all the cores of cpu to low freq
> as cooling-maps cross the alert temperature. For below example.
> ----
>  map3 {
>               trip = <&cpu1_alert3>;
>               cooling-device = <&cpu0 0 2>;
>  };
>  map4 {
>               trip = <&cpu1_alert3>;
>               cooling-device = <&cpu4 0 2>;
>  };
> 
>  map5 {
>               trip = <&cpu1_alert4>;
>               cooling-device = <&cpu0 3 7>;
>  };
>  map6 {
>              trip = <&cpu1_alert4>;
>              cooling-device = <&cpu4 3 12>;
>  };
> 
> What I want to configure thermal zone as.
> 
> cpu0_thermal: cpu0-thermal {
>      configure cluster of cpu[0-3]
>      {
>         tips
>      }
>      cooling map
>      {
>          device handle cpu[0-3] with frequency scaling at particular
> alert temperature.
>      }
> }

cpu0_thermal is attached to tmu_cpu0 which is the temperature of CPU4
(first big core). I do not see reason behind connecting thermal zone
(thus temperature) of CPU4 with frequency of LITTLE cluster (CPU0-3). In
case of busy CPU4, you will scale down CPU0-3. Does not make sense.

> cpu1_thermal: cpu1-thermal {
>      configure cluster of cpu[4-7]
>      {
>         tips
>      }
>      cooling map
>      {
>          device handle cpu[4-7] with frequency scaling at particular
> alert temperature.
>      }
> }
> 
> We can chose to configure rest of the thermal-zone on this approach.
> Please share your thoughts.

I am sorry, I do not understand the idea, the problem nor the solution.

Best regards,
Krzysztof
