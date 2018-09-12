From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 12 Sep 2018 16:58:29 +0200
Subject: unexpected side effect of "gpiolib: override irq_enable/disable"
Message-ID: <20180912145829.hzklqndjasac2ap4@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Using next-20180912, my kernel hangs during the boot. Git bisect tell me
that the cause of my issue is the commit "gpiolib: override
irq_enable/disable"

I dug further and this patch can have some side effects. When booting, I
have an infinite loop when trying to enable a gpio irq. I don't know if
the pinctrl-at91 driver is the only one concerned or not.

The pattern leading to this issue is quite simple: we have several gpio
controllers sharing the same irq_chip structure. Installing the
irq_enable/irq_disable hook works well the first time. The second time,
since the irq_enable has been altered to use gpiochip_irq_enable,
this latest function will call itself again and again by calling
irq_enable.

I think it should be better to have one irq_chip structure per gpio
controller. I am going to do a patch for pinctrl-at91. Excepting if you
think it has to be solved in a different way.


Ludovic
