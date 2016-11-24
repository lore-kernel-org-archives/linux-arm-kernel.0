From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Nov 2016 13:17:05 +0100
Subject: [PATCH 7/9] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <FFD6E644-F68B-4880-BC76-88F6063D070E@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
 <1479922177-20136-7-git-send-email-al.kochet@gmail.com>
 <FFD6E644-F68B-4880-BC76-88F6063D070E@gmail.com>
Message-ID: <1800621.EhepfMxccR@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. November 2016, 12:36:20 schrieb Alexander Kochetkov:
> > In order to use the patch you have to setup the timer using
> > 'rockchip,clocksource' device tree property
> 
> Just came in mind, that it is better to replace 'rockchip,clocksource'
> device tree property with KConfig option in order to enable clocksource on
> dedicated timer?
> 
> Someting like:
> [ ] enable clocksource
>    clocksource timer name:

That would mean recompiling the kernel for a maybe board-specific setting and 
is definitly not how things are handled these days :-) .
I.e. the overall goal is to have one kernel image that can actually run on 
multiple arm architectures (rockchip, imx, etc) and only gets configured by the 
devicetree.

In your dts-patch you reuse the rk3288-timer compatible value, which is also 
non-ideal.

What you may want to do is introduce a rockchip,rk3188-timer compatible and 
then make the timer-driver act accordingly, as you then know you are on a 
rk3188-board ... see drivers attaching specific structs to the of_device_id 
entries. From the documentation it also shouldn't really matter which timer 
you use as clocksource, as on the rk3188 it seems all of them act the same way 
(except timer3 being always on).

When touching devicetree-properties, please also adapt the binding document
	Documentation/devicetree/bindings/timer,rockchip,rk-timer.txt
in this case and also include the devicetree maintainers.


Heiko
