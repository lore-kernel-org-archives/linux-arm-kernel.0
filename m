From: michael@walle.cc (Michael Walle)
Date: Fri, 26 Oct 2012 22:17:46 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121026204505.762fbfca@skate>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210262006.15968.michael@walle.cc> <20121026204505.762fbfca@skate>
Message-ID: <201210262217.46393.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas.

Am Freitag 26 Oktober 2012, 20:45:05 schrieb Thomas Petazzoni:
> Ah, this is interesting. It is not entirely surprising, since the gpio
> driver is new. Even though it re-uses most of the previous gpio driver,
> it is by far not impossible that there will be a few regressions.
> 
> Could you add a few debug prints to see if you're looping *inside* the
> function (which I find pretty unlikely), or if the function gets called
> over and over again? 

ah sorry, my bad. of course the handler is called forever:

mvebu_gpio_to_irq pin=8
mvebu_gpio_irq_set_type pin=8
mvebu_gpio_edge_irq_unmask
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=100
mvebu_gpio_level_irq_mask irq=100
mvebu_gpio_irq_handler irq=101
mvebu_gpio_level_irq_mask irq=101
mvebu_gpio_irq_handler irq=102
mvebu_gpio_level_irq_mask irq=102
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=112
mvebu_gpio_level_irq_mask irq=112
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=103
mvebu_gpio_level_irq_mask irq=103
mvebu_gpio_irq_handler irq=103
[..]

> Could it be that the hang occurs during the
> initialization of the gpio-leds or gpio-keys drivers?

yeah, if i disable gpio-leds, gpio-keys and gpio-fan the hang will disappear. 
But once i enable one of it the board hangs again.


> Also, even though I'm pretty sure it isn't going to fix your problem,
> note the following mvebu-gpio fix:
> 
>   http://article.gmane.org/gmane.linux.ports.arm.kernel/195018

thats already in andrew's tree.

-- 
michael
