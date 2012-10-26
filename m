From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Oct 2012 20:45:05 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <201210262006.15968.michael@walle.cc>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <77006526a6de40ddb455b25787b08342.squirrel@ssl.serverraum.org>
 <20121025094343.58015440@skate>
 <201210262006.15968.michael@walle.cc>
Message-ID: <20121026204505.762fbfca@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Michael Walle,

On Fri, 26 Oct 2012 20:06:15 +0200, Michael Walle wrote:

> Am Donnerstag 25 Oktober 2012, 09:43:43 schrieb Thomas Petazzoni:
> > Regardless of those GPIOs, did you solve the hang that happened even
> > when you removed the gpio_set_value() calls? Or is it still a
> > problem currently?
> 
> quick update, i found out, that my board loops in the mvebu interrupt
> handler mvebu_gpio_irq_handler(). maybe this is also the lockup Jamie
> Lentin sees.
> 
> are interrupts always enabled, now? is there a way to control them?
> maybe there is something missing in the dts, now.

Ah, this is interesting. It is not entirely surprising, since the gpio
driver is new. Even though it re-uses most of the previous gpio driver,
it is by far not impossible that there will be a few regressions.

Could you add a few debug prints to see if you're looping *inside* the
function (which I find pretty unlikely), or if the function gets called
over and over again? Could it be that the hang occurs during the
initialization of the gpio-leds or gpio-keys drivers?

Also, even though I'm pretty sure it isn't going to fix your problem,
note the following mvebu-gpio fix:

  http://article.gmane.org/gmane.linux.ports.arm.kernel/195018

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
