From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 09 Sep 2014 13:35:31 +0200
Subject: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
In-Reply-To: <1410229637.8085.158.camel@rzhang1-toshiba>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <5407BA10.2030402@rock-chips.com> <1410229637.8085.158.camel@rzhang1-toshiba>
Message-ID: <8397565.n78cHk4EtL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 9. September 2014, 10:27:17 schrieb Zhang Rui:
> On Thu, 2014-09-04 at 09:02 +0800, Caesar Wang wrote:
> > ? 2014?09?03? 16:07, Heiko St?bner ??:
> > > Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesar Wang:
> > >> This add the necessary binding documentation for the thermal
> > >> found on Rockchip SoCs
> > >> 
> > >> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> > >> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> > >> ---
> > >> 
> > >>   .../devicetree/bindings/thermal/rockchip-thermal.txt | 20
> > >> 
> > >> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> > >> 
> > >>   create mode 100644
> > >> 
> > >> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > >> 
> > >> diff --git
> > >> a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > >> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt new
> > >> file
> > >> mode 100644
> > >> index 0000000..1ed4d4c
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > >> @@ -0,0 +1,20 @@
> > >> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> > >> +
> > >> +Required properties:
> > >> +- compatible: "rockchip,rk3288-tsadc"
> > >> +- reg: physical base address of the controller and length of memory
> > >> mapped
> > >> +       region.
> > >> +- interrupts: The interrupt number to the cpu. The interrupt specifier
> > >> format +	      depends on the interrupt controller.
> > >> +- clocks: Must contain an entry for each entry in clock-names.
> > >> +- clock-names: Shall be "tsadc" for the converter-clock, and
> > >> "apb_pclk" for +	       the peripheral clock.
> > > 
> > > You're using the passive-temp, critical-temp and force-shut-temp
> > > properties in your driver without declaring them here.
> > 
> > frankly,the about are need be declared. but  there are 4 types[0] for
> > trip in thermal framework,
> > there is no force-shut for me. So I want to change it three additional
> > properties in [PATCH V4 4/4],
> > 
> > 
> > [0]
> > {
> > 
> >      THERMAL_TRIP_CRITICAL,
> >      THERMAL_TRIP_HOT,
> >      THERMAL_TRIP_PASSIVE,
> >      THERMAL_TRIP_ACTIVE,
> > 
> > }
> 
> this sounds reasonable to me.
> 
> > > But more importantly, please use the generic trip-points for this. I
> > > guess it shouldn't be a problem to introduce a "forced-shutdown"
> > > trippoint [0] for the additional trip-point you have - thermal
> > > maintainers, please shout if I'm wrong :-)
> 
> what is the difference between a critical trip point and a
> "forced-shutdown" trip point?
> Thermal core will do a shutdown in case the critical trip point is
> triggered.

The forced-shutdown is where the thermal controller is supposed to also do a 
shutdown in hardware. As you said the thermal core will also shutdown at the 
critical trip point, I guess we could map Caesar's value like

trip-point		tsadc
critical		forced-shutdown (the 120 degrees in patch 4)
hot			critical (the 100 degrees)
...


> 
> thanks,
> rui
> 
> > It's a good option.
> > I can send a patch,but I don't know whether the thermal maintainers will
> > accept it.
> > 
> > Maybe,they have a better way to suggest it.:-)
> > 
> > 
> > PS:I will sent a new patch If I still have no received their suggestions
> > in two days.
> > 
> > > Heiko
> > > 
> > > 
> > > [0] in a separate patch, changing
> > > - thermal_trip_type enum in include/linux/thermal.h
> > > - trip_types mapping in drivers/thermal/of-thermal.c
> > > - Documentation/devicetree/bindings/thermal/thermal.txt
> > > 
> > >> +
> > >> +Example:
> > >> +tsadc: tsadc at ff280000 {
> > >> +	compatible = "rockchip,rk3288-tsadc";
> > >> +	reg = <0xff280000 0x100>;
> > >> +	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > >> +	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> > >> +	clock-names = "tsadc", "apb_pclk";
> > >> +};
