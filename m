From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 01 Dec 2015 16:47:36 +0100
Subject: [PATCH v3 2/5] dt-bindings: soc: add document for rockchip reboot
 notifier driver
In-Reply-To: <CANbgqARCYP0rfTPSJLNEnCdrb1+mCYYznnRVH6o8Bj5sWt9fDw@mail.gmail.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <CANbgqARHxXorh8Svuw7tHMT60=j35BEqhMnuCOB6u6-d0NPxEQ@mail.gmail.com>
 <CANbgqARCYP0rfTPSJLNEnCdrb1+mCYYznnRVH6o8Bj5sWt9fDw@mail.gmail.com>
Message-ID: <10512572.1QQvFtIA3T@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Dienstag, 1. Dezember 2015, 23:10:15 schrieb Andy Yan:
> 2015-11-23 21:15 GMT+08:00 Andy Yan <andyshrk@gmail.com>:
> > 2015-11-20 9:58 GMT+08:00 Rob Herring <robh@kernel.org>:
> >> On Thu, Nov 19, 2015 at 7:16 PM, Andy Yan <andy.yan@rock-chips.com>
> >> 
> >> wrote:
> >> > On 2015?11?19? 12:35, Heiko Stuebner wrote:
> >> >> Am Donnerstag, 19. November 2015, 09:17:37 schrieb Andy Yan:
> >> >>> On 2015?11?19? 06:59, Rob Herring wrote:
> >> >>>> On Wed, Nov 18, 2015 at 05:53:30PM +0800, Andy Yan wrote:
> >> >>>>> Add devicetree binding document for rockchip reboot nofifier driver
> >> >>>> 
> >> >>>> Just reading the subject this is way too specific to the Linux
> >> >>>> driver
> >> >>>> needs rather than a h/w description. Please don't create fake DT
> >> 
> >> nodes
> >> 
> >> >>>> just to bind to drivers. Whatever &pmu is is probably what should
> >> 
> >> have
> >> 
> >> >>>> the DT node. Let the driver for it create child devices if you need
> >> >>>> that.
> >> >>>> 
> >> >>>       This is note a fake DT nodes, we really need it to tell the
> >> 
> >> driver
> >> 
> >> >>>        which register to use to store the reboot mode. Because
> >> 
> >> rockchip
> >> 
> >> >>>        use different register file to store the reboot mode on
> >> 
> >> different
> >> 
> >> >>>        platform, on rk3066,rk3188, rk3288,it use  one of the PMU
> >> >>> 
> >> >>> register, on
> >> >>> 
> >> >>>        the incoming RK3036, it use one of the GRF register, and it
> >> >>>        use
> >> >>> 
> >> >>> one  of
> >> >>> 
> >> >>>        the PMUGRF register for arm64 platform rk3368. On the other
> >> 
> >> hand,
> >> 
> >> >>> the
> >> >>> 
> >> >>>        PMU/GRF/PMUGRF register file are mapped as "syscon", then
> >> >>> 
> >> >>> referenced
> >> >>> 
> >> >>>        by other DT nodes by phandle. So maybe let it as a separate DT
> >> >>> 
> >> >>> node here
> >> >>> 
> >> >>>        is better.
> >> >> 
> >> >> or alternatively we could do something similar to what the bl-switcher
> >> >> cupfreq-driver does. Take a look at
> >> >> 
> >> >> drivers/cpufreq/arm_big_little.c
> >> >> drivers/clk/clk-mb86s7x.c
> >> >> 
> >> >> We already have the core restart-handler code in the clock-tree, so
> >> 
> >> could
> >> 
> >> >> maybe simply do the
> >> >> 
> >> >>         platform_device_register_simple("rockchip-reboot", -1, NULL,
> >> 
> >> 0);
> >> 
> >> >> in that common code?
> >> >> 
> >> >> Though I'm not yet sure how to get the platform-data. I guess one
> >> 
> >> option
> >> 
> >> >> would
> >> >> be to do things like the 3288 suspend code does
> >> >> (arch/arm/mach-rockchip/pm.c
> >> >> at the bottom), by having the per-soc-data in the driver and then
> >> 
> >> matching
> >> 
> >> >> against the pmu. Because the pmu is not part of the clock controller
> >> >> binding
> >> >> (and probably also shouldn't be).
> >> >> 
> >> >    Thanks for your suggestion.
> >> >    
> >> >     I have read the code you list above, if we implement the reboot
> >> 
> >> notifier
> >> 
> >> >     driver like this, the driver need to add much more code to find the
> >> > 
> >> > platform
> >> > 
> >> >     data(like arch/arm/mach-rockhcip/pm.c), what's more, if we have a
> >> 
> >> new
> >> 
> >> > soc
> >> > 
> >> >     in the future and the soc use a different register here, we need
> >> 
> >> modify
> >> 
> >> > the
> >> > 
> >> >     driver to add a new platform data again, this will bring additional
> >> > 
> >> > work.
> >> > 
> >> >     Use the DT node pass the register will make the driver code simple
> >> 
> >> and
> >> 
> >> > clear.
> >> > 
> >> >     Is there any hurt to put this information in the DT?
> >> 
> >> Add the data you need to the PMU node. Then the PMU driver can get it
> >> and pass to the child driver.
> >> 
> >> Rob
> >> --
> >> 
> >     Do you mean I should implement the DT node like this?
> >    
> >    diff --git a/arch/arm/boot/dts/rk3xxx.dtsi
> > 
> > b/arch/arm/boot/dts/rk3xxx.dtsi
> > index 7b14d7a..1735d09 100644
> > --- a/arch/arm/boot/dts/rk3xxx.dtsi
> > +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> > @@ -103,12 +103,6 @@
> > 
> >                 };
> >         
> >         };
> > 
> > -       reboot {
> > -               compatible = "rockchip,reboot";
> > -               rockchip,regmap = <&pmu>;
> > -               offset = <0x40>;
> > -       };
> > -
> > 
> >         xin24m: oscillator {
> >         
> >                 compatible = "fixed-clock";
> >                 clock-frequency = <24000000>;
> > 
> > @@ -249,7 +243,11 @@
> > 
> >         pmu: pmu at 20004000 {
> >         
> >                 compatible = "rockchip,rk3066-pmu", "syscon";
> > 
> > -               reg = <0x20004000 0x100>;
> > +              reg = <0x20004000 0x100>;
> > +              reboot {
> > +                       compatible = "rockchip,reboot";
> > +                       offset = <0x40>;
> > +               };
> > 
> >         };
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> > index cd02229..8a9837a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> > @@ -202,12 +202,6 @@
> > 
> >                 method = "smc";
> >         
> >         };
> > 
> > -       reboot {
> > -               compatible = "rockchip,reboot";
> > -               rockchip,regmap = <&pmugrf>;
> > -               offset = <0x200>;
> > -       };
> > -
> > 
> >         timer {
> >         
> >                 compatible = "arm,armv8-timer";
> >                 interrupts = <GIC_PPI 13
> > 
> > @@ -493,6 +487,10 @@
> > 
> >         pmugrf: syscon at ff738000 {
> >         
> >                 compatible = "rockchip,rk3368-pmugrf", "syscon";

    compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";


> >                 reg = <0x0 0xff738000 0x0 0x1000>;
> > 
> > +              reboot {
> > +                       compatible = "rockchip,reboot";
> > +                       offset = <0x200>;
> > +               };
> > 
> >         };
> 
>   Is there any further suggestion for this? If not, I will send the V4 with
> the DT node as a subnode in PMU or PMUGRF.

I guess Rob is the authority on this, but I'm not sure on the "devicetree 
describes hardware" level.

On the one hand it is not really a hardware-device, but on the other hand it 
is a firmware-interface (like psci etc, that's already in the devicetree 
elsewhere), so I'd guess it should be ok.


Heiko
