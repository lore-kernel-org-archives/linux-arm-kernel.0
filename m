From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 27 Oct 2012 10:59:04 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <201210262217.46393.michael@walle.cc>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210262006.15968.michael@walle.cc>
 <20121026204505.762fbfca@skate>
 <201210262217.46393.michael@walle.cc>
Message-ID: <20121027085904.GC15143@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 10:17:46PM +0200, Michael Walle wrote:
> Hi Thomas.
> 
> Am Freitag 26 Oktober 2012, 20:45:05 schrieb Thomas Petazzoni:
> > Ah, this is interesting. It is not entirely surprising, since the gpio
> > driver is new. Even though it re-uses most of the previous gpio driver,
> > it is by far not impossible that there will be a few regressions.
> > 
> > Could you add a few debug prints to see if you're looping *inside* the
> > function (which I find pretty unlikely), or if the function gets called
> > over and over again? 
> 
> ah sorry, my bad. of course the handler is called forever:
> 
> mvebu_gpio_to_irq pin=8
> mvebu_gpio_irq_set_type pin=8
> mvebu_gpio_edge_irq_unmask
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=100
> mvebu_gpio_level_irq_mask irq=100
> mvebu_gpio_irq_handler irq=101
> mvebu_gpio_level_irq_mask irq=101
> mvebu_gpio_irq_handler irq=102
> mvebu_gpio_level_irq_mask irq=102
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=112
> mvebu_gpio_level_irq_mask irq=112
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=103
> mvebu_gpio_level_irq_mask irq=103
> mvebu_gpio_irq_handler irq=103

That makes me think edge vs level triggering.

For gpio-keys you want edge triggered interrupts, but if the
controller is setup for level, you would see this.

Try adding some debug into the function mvebu_gpio_irq_set_type()

    Andrew
