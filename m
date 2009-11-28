From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 28 Nov 2009 21:03:44 +0100
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
Message-ID: <20091128200344.GA1272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 11:18:00PM +0100, Thomas Gleixner wrote:
> On Fri, 27 Nov 2009, Uwe Kleine-K?nig wrote:
> 
> > IRQF_DISABLED is not guaranteed on shared irqs.  There is already a
> > warning in place for irqs registered with request_irq (introduced in
> > 470c66239ef03).  Move it to __setup_irq, this way it triggers for both
> > request_irq and setup_irq.
> > 
> > One irq that is now warned about is the timer tick on at91 (ARCH=arm).
> 
> And how does that help ? The interrupt is shared between the timer and
> the debug port. There is nothing you can do about that.
> 
> The interupt handlers are called in order of setup. The AT91 timer
> irq is set up first and if that's not the case then it needs to be
> fixed and the only way to catch it is in the affected interrupt
> handler.
Russell already suggests to save (and restore) irqs in the handler
before (and after resp.) calling the clockevent functions.

Should it use the raw_ variants?
 
> Applying your patch does not change the hardware and will just result
> in useless, annoying and confusing dmesg warnings.
My patch wasn't mainly to help in the at91 case.  I just thought that a
warning that is triggered with request_irq and request_threaded_irq
shouldn't be skipped when using setup_irq.

Maybe the warning should only be printed if there's a mismatch between
different actions of the same irq regarding IRQF_DISABLED?!

I will prepare a patch for both (i.e. fixing the at91 ISRs and the
warning about IRQF_DISABLED | IRQF_SHARED) but probably only on Monday.
 
Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
