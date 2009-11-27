From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 27 Nov 2009 23:18:00 +0100 (CET)
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED registered
	with setup_irq
In-Reply-To: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov 2009, Uwe Kleine-K?nig wrote:

> IRQF_DISABLED is not guaranteed on shared irqs.  There is already a
> warning in place for irqs registered with request_irq (introduced in
> 470c66239ef03).  Move it to __setup_irq, this way it triggers for both
> request_irq and setup_irq.
> 
> One irq that is now warned about is the timer tick on at91 (ARCH=arm).

And how does that help ? The interrupt is shared between the timer and
the debug port. There is nothing you can do about that.

The interupt handlers are called in order of setup. The AT91 timer
irq is set up first and if that's not the case then it needs to be
fixed and the only way to catch it is in the affected interrupt
handler.

Applying your patch does not change the hardware and will just result
in useless, annoying and confusing dmesg warnings.

> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Remy Bohmer <linux@bohmer.net>,
> Cc: Hugh Dickins <hugh.dickins@tiscali.co.uk>,
> Cc: Andrea Gallo <andrea.gallo@stericsson.com>,

Nice that you added me (and others) to that long list, but ...

> Cc: Thomas Gleixner <tglx@linutronix.de>,
------------------------------------------^

Thanks,

	tglx
