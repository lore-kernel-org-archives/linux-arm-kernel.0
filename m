From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Wed, 5 Jan 2011 21:24:25 +0200
Subject: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
In-Reply-To: <20110105181918.GB8717@n2100.arm.linux.org.uk>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
	<20110105181918.GB8717@n2100.arm.linux.org.uk>
Message-ID: <20110105192425.GA24729@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Wed, Jan 05, 2011 at 06:19:18PM +0000, Russell King wrote:
> On Wed, Jan 05, 2011 at 07:58:03PM +0200, Eduardo Valentin wrote:
> > Currently, if one calls disable_irq(gpio_irq), the irq
> > won't get disabled.
> > 
> > This is happening because the omap gpio code defines only
> > a .mask callback. And the default_disable function is just
> > a stub. The result is that, when someone calls disable_irq
> > for an irq in a gpio line, it will be kept enabled.
> > 
> > This patch solves this issue by setting the .disable
> > callback to point to the same .mask callback.
> 
> Amd this is a problem because?

errr.. because the interrupt is enabled when it was supposed to be disabled?

> 
> The way this works is that although it isn't disabled at that point,
> if it never triggers, then everything remains happy.  However, if it
> does trigger, the genirq code will then mask the interrupt and won't
> call the handler.

Right.. I didn't see from this point. I will check how that gets unmasked.
But even so, if I understood correctly what you described, it would still
open a time window which the system would see at least 1 interrupt during
the time it was not suppose to. And that can wakeup a system which  is in
deep sleep mode, either via dynamic idle or static suspend.

It is unlikely, I know. But it can still happen. And can be avoided.

Regards,

-- 
Eduardo Valentin
