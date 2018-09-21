From: willy.mh.wolff.ml@gmail.com (Willy Wolff)
Date: Fri, 21 Sep 2018 13:25:54 +0100
Subject: [PATCH] ARM: dts: exynos: ordering wrong order tmu_cpu on
 Odroid-XU3/4 thermal-zones definition
In-Reply-To: <CAJKOXPdDFm=7wNLt5Nzf-y8TS4u6gmo51Y70bFv_pKdFK42VDQ@mail.gmail.com>
References: <20180921113329.tha5tfrsvdf7dtws@inc028000032.lancs.ac.uk>
 <CAJKOXPdDFm=7wNLt5Nzf-y8TS4u6gmo51Y70bFv_pKdFK42VDQ@mail.gmail.com>
Message-ID: <CACfOrNdkG=MTy=+TF1x8y++goDAyfnjfReno6=vwpRMy4r-dWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Sep 2018 at 12:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, 21 Sep 2018 at 13:33, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
> >
> > This patch is to open a discussion about wrong order of tmu_cpu.
> >
> > It seems that tmu_cpu1 correspond to cpu3, and tmu_cpu3 match cpu1.
> > Note, cpu{0|3} in dtsi correspond to cpu{3|7} in linux and are the big
> > cores.
>
> Hi,
>
> I do not understand this sentence. In DTSI, the CPU0-3 are the A7,
> little cores. Defined by exynos5422-cpus.dtsi. What did you mean here?

Leave it, you clarify that is just indices.

> > By dependencis from exynos5422-odroidxu3-common.dtsi to
> > exynos5800.dtsi -> exynos5420.dtsi, I guess definitions of tmu_cpuX are
> > incorrect. However, changing the address, reg interrupts or clocks
> > would breack other boards depending on it. As I can't test other boards,
> > I've just overload the reference in the thermal-zones node.
>
> There are 8 CPUs (4 little and 4 big) but only 4 thermal zones for
> CPUs. The mapping of names of CPU nodes and TMU nodes in DTS is not
> direct. These are just indices ...

Maybe we could rename these nodes to support the real name while running?
But it's just a detail I guess.

>
> although more important is to map
> the cooling devices to proper TMU. This should be mentioned in DTS as
> this the real problem here.

The cooling devices mapping is correct, it's the reporting in
/sys/devices/virtual/thermal/thermal_zone$i/temp that are wrong.
Currently, there is no bad effect for cooling, as the attached cooling device
adapts the FAN and both frequencies of little and big cluster. Frequencies
of little cores and big cores are shared inside a cluster.
This patch is for coherency only.

>
> >
> > To reproduce the problem, I provide two scripts:
> > == script_stress:
> >
> > for i in 0 10 20 40 80; do
> >     echo $i
> >     taskset $i stress -t 10 -c 1
> > done;
> >
> > == script_read_temp:
> >
> > while true; do
> >     for i in 0 1 2 3 4; do
> >         echo $i
> >         cat /sys/devices/virtual/thermal/thermal_zone$i/temp
> >     done;
> >     sleep 1
> >     clear
> > done;
> >
> > Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
> > ---
> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > index 96e281c0a118..4512ffad2785 100644
> > --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > @@ -135,7 +135,8 @@
> >                         };
> >                 };
> >                 cpu1_thermal: cpu1-thermal {
> > -                       thermal-sensors = <&tmu_cpu1 0>;
> > +                       // thermal-sensors = <&tmu_cpu1 0>;
>
> Do not leave commented lines, there are not needed.
>
> Also your email does not match signed-off-by. You must have something
> wrong with either git setup or mailer (git commit --si will use the
> same address for From and SoB so I guess the mailer...).

Ok, my bad.

> Best regards,
> Krzysztof
