From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Nov 2016 14:21:48 +0100
Subject: [PATCH 7/9] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <0E972AC9-1132-4D0B-BF25-918BC1AA1A49@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
 <1800621.EhepfMxccR@diego> <0E972AC9-1132-4D0B-BF25-918BC1AA1A49@gmail.com>
Message-ID: <4357439.aV0xjsImc7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Am Donnerstag, 24. November 2016, 16:05:55 schrieb Alexander Kochetkov:
> Hello Heiko!
> 
> > 24 ????. 2016 ?., ? 15:17, Heiko St?bner <heiko@sntech.de> ???????(?):
> > 
> > In your dts-patch you reuse the rk3288-timer compatible value, which is
> > also non-ideal.
> 
> rockchip,rk-timer.txt states what I should use rockchip,rk3288-timer for
> rk3188 timers:
> 
> Required properties:
> - compatible: shall be one of:
>   "rockchip,rk3288-timer" - for rk3066, rk3036, rk3188, rk322x, rk3288,
> rk3368
> 
> Should I add "rockchip,rk3188-timer? (or better "rockchip,rk3036-timer?) ?
> Or may be second approach should be used?
>
> > What you may want to do is introduce a rockchip,rk3188-timer compatible
> > and
> > then make the timer-driver act accordingly, as you then know you are on a
> > rk3188-board ... see drivers attaching specific structs to the
> > of_device_id
> > entries. From the documentation
> 
> May be it is better to prepend compatible string with
> "rockchip,rk3188-timer? in the dts file only? elinux[1] recommend build
> compatible string from "exact device? string and ?other devices? that the
> device is compatible with.
> 
> As ?other devices? string defined already, I use it.
> 
> [1]
> http://elinux.org/Device_Tree_Usage#Understanding_the_compatible_Property
> 
> 	timer0: timer at 20038000 {
> 		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer?;
>                 ?
> 	};
> 
> Just found what rk3036 already declared such way:
> 
> rk3036.dtsi:	timer: timer at 20044000 {
> rk3036.dtsi:		compatible = "rockchip,rk3036-timer", "rockchip,rk3288-
timer?;

correct, use both but also update the binding, like 
mmc/rockchip-dw-mshc.txt does.


> > it also shouldn't really matter which timer
> > you use as clocksource, as on the rk3188 it seems all of them act the same
> > way (except timer3 being always on).
> 
> You are right.
> 
> I sent dts file with general timer settings, without clockevent enabled, so
> one could pick up timer and setup it in the board dts (radxarock, for
> example) like:
> 
> &timer0 {
>     rockchip,clocksource;
>     status = ?okay?;
> };

what I actually meant was that the driver could also recognize the rk3188-
timer compatible as "we need a clocksource" and it shouldn't matter which 
timer actually gets used for this.


> > When touching devicetree-properties, please also adapt the binding
> > document
> > 
> > 	Documentation/devicetree/bindings/timer,rockchip,rk-timer.txt
> > 
> > in this case and also include the devicetree maintainers.
> 
> If the patch[2] ok, I'll resend it and include devicetree maintainers.
> 
> [2]
> http://lists.infradead.org/pipermail/linux-rockchip/2016-November/013148.ht
> ml

Only devicetree people can really tell you if that is ok :-) .

The devicetree is supposed to be a hardware-description and implementation-
independent, so rockchip,clocksource sounds pretty much like linux-specific 
configuration things leaking into the devicetree.


Heiko
