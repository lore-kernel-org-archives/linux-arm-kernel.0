From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Thu, 24 Nov 2016 17:14:56 +0300
Subject: [PATCH 7/9] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <4357439.aV0xjsImc7@diego>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
 <1800621.EhepfMxccR@diego> <0E972AC9-1132-4D0B-BF25-918BC1AA1A49@gmail.com>
 <4357439.aV0xjsImc7@diego>
Message-ID: <95FE175F-B7B4-4271-99FE-69516140C56A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 24 ????. 2016 ?., ? 16:21, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> what I actually meant was that the driver could also recognize the rk3188-
> timer compatible as "we need a clocksource" and it shouldn't matter which 
> timer actually gets used for this.

One rockchip timer cannot be used as clockevent and clocksource at the same time.

In case of clockevent we want interrupts from it at specified times. So we load one
value into timer counter and it generates an interrupt.

In case of clocksource we load max value into timer counter, run timer and read current
value on demand.

rockchip_timer driver currently implement clockevent. So, if I create only one timer
in the device tree, it should be clockevent timer. As that behavior already expected
from driver by people used it.

I may suggest such solution here: if I want clocksource, I have to declare two timer
in device tree. First probed timer would be clockevent and second one would be
clocksource. All other timers will be ignored. Is that solution good?

If I want one timer and want it be clocksource not clockevent how that situation should
be configured? Device tree not good for this. Kconfig not good. Pass that configuration
on kernel command line?

> Only devicetree people can really tell you if that is ok :-) .
> 
> The devicetree is supposed to be a hardware-description and implementation-
> independent, so rockchip,clocksource sounds pretty much like linux-specific 
> configuration things leaking into the devicetree.


You are right. They don?t allow pass linux configuration using device tree. 

Regards,
Alexander.
