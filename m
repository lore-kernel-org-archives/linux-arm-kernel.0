From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 06 Jul 2016 09:54:03 +0200
Subject: [PATCH] gpio: document how to order GPIO controllers
In-Reply-To: <20160705180447.GP16643@pengutronix.de>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160705140546.GA10601@rob-hp-laptop>
 <20160705180447.GP16643@pengutronix.de>
Message-ID: <7356797.MVQep4sf2D@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2016 20:04:47, Uwe Kleine-K?nig wrote:
> That is we have:
> 
> 	Hardware name | software gpiochip
> 	    GPIO4     |      gpiochip0
> 	    GPIO3     |      gpiochip1
> 	    GPIO1     |      gpiochip2
> 	    GPIO2     |	     gpiochip3
> 
> I bet that's the probe order because when sorted by address (and so
> by order in the device tree) we have exactly this ordering. (Compare
> with $(grep gpio@ arch/arm/boot/dts/imx25.dtsi).)

This is rather straight forward and rather simple for controller internal GPIO 
controllers but when using GPIO expanders both on SPI and I2C thing will get 
much more volatile especially on SMP systems. What would be the correct 
"order" here? Unless they are cascaded they are independent and there is no 
such thing as an order. Probe order _is_ unpredictable so they will vary on 
different boots. Having 4 internal GPIO controllers which creates 4 gpiochips 
with more or less fixed names is rather a special case. Dunno if they might 
change on a SMP system. Can a driver probe be called multiple times 
simultaneously? Well, when drivers are used as modules I think things are even 
more unpredictable.

> For a new interface this is OK, still I predict users will complain if
> the numbers used don't match naturally the hardware names. And IMHO they
> are right.

Given the fact that hardware names and gpiochip number relation is not fixed 
IMHO the simplest way to identify them is using the DT label. You need them 
anyway to identify them in DT itself at other places why not using this on 
Linux userspace too? So gpiochip[0-9]* should still be created but using udev 
you can create appropriate symlinks with more recognizable names.

Best regards,
Alexander
