From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 25 Jun 2017 15:31:34 +0200
Subject: [PATCH] ARM: dts: exynos: Exynos5422 Odroid-XU* incomplete
 thermal-zones definition
In-Reply-To: <CANAwSgSN5zi72m1td-NAaCPGLUZybSdefrKAo2t9v-gOXn3tGA@mail.gmail.com>
References: <20170623210913.ugutgop7ratwolfy@inc028000032.lancs.ac.uk>
 <CANAwSgSN5zi72m1td-NAaCPGLUZybSdefrKAo2t9v-gOXn3tGA@mail.gmail.com>
Message-ID: <20170625133134.g4iinztozsp4p2aa@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 25, 2017 at 06:53:24PM +0530, Anand Moon wrote:
> Hi Willy,
> 
> On 24 June 2017 at 02:39, Willy Wolff <willy.mh.wolff@gmail.com> wrote:
> > Odroid XU*-familly boards has thermal sensors per A15 cores, but the actual
> >  thermal-zones define only cooling-maps action for cpu0.
> >
> > If the application is running on all cores but core4 (first core of the A15
> >  cluster), the CPU can reach high temperature without any proper cooling
> >  action.
> >
> > As already discus in prior mail, and on IRC, it's a quit big code
> > duplication, but I don't found the write way to express that in a better
> >  way.
> >
> > The situation for this board is that we have multiple sensors, but
> >  matching cooling devices for these sensors act for the same physical
> >  device (FAN and A15 cluster, as each core of the cluster share the same
> >  frequency).
> > In fact, of-thermal.c:473:thermal_zone_of_sensor_register() can't use
> > multiple sensors for one single thermal zone.
> > This patch follow the path taken in arch/arm/boot/dts/qcom-apq8084.dtsi:97
> >
> > I'm interested to extending the thermal driver, but it will takes time.
> >  So this is a workaround before refactoring the driver.
> > If somebody knows how to write it better, any advice and suggestions
> > are more than welcome.
> >
> > Also, the comment for cpu_alert4 in cooling-maps definition is not
> > accurate, 11 steps for A15 correspond to 700MHz, not 600MHz.
> >
> 
> [snip]
> 
> Few point to from my side.
> 
> 1: We should also increase the trip points temperature so that it can
> throttle at high temperature.

It is not related to this problem. If you wish to address different
problem related to non-optimal choice of temperature, then please send a
separate patch explaining chosen values.

> 2: We should also increase the tips from 4 to 8 to support different
> cluster of cpu's.

There are 4 CPU thermal zones on Exynos5422. What do you want to expand?

> 3: To avoid duplication of cooling-maps we can make tmu sensor work
> differently for cluster of cpu's
>       tmu_cpu0: handle pwm-fan control.
>       tmu_cpu1: handle cpu[0-3] cpufreq mapping.
>       tmu_cpu2: handle cpu[4-7] cpufreq mapping.

I miss the point behind this. Why fan should work only when CPU4
(tmu_cpu0) is heated and not CPU5-7 (rest of cpu tmu's)?

Best regards,
Krzysztof


>       tmu_gpu: handle gpu (mali) cpu throttle.
> 
> Please share your thought on this new approach.
> 
> I generally test using linaro's pm-qa and most of the time the test case fails
>       # git clone git://git.linaro.org/tools/pm-qa.git
>       # make -C thermal check
> 
> -Best Regards
> -Anand Moon
