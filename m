From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 19 Sep 2013 12:15:10 +0200 (CEST)
Subject: [PATCH] clockevents: Sanitize ticks to nsec conversion
In-Reply-To: <20130919100239.GS24802@pengutronix.de>
References: <1379077365-18458-1-git-send-email-mkl@pengutronix.de>
 <20130917095600.GJ26819@ludovic.desroches@atmel.com>
 <20130917100417.GQ12758@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1309171210450.4089@ionos.tec.linutronix.de>
 <20130917130153.GL26819@ludovic.desroches@atmel.com>
 <alpine.DEB.2.02.1309172228400.4089@ionos.tec.linutronix.de>
 <20130918085627.GN24802@pengutronix.de>
 <alpine.DEB.2.02.1309181058470.4089@ionos.tec.linutronix.de>
 <20130918150958.GO24802@pengutronix.de>
 <alpine.DEB.2.02.1309182201000.4089@ionos.tec.linutronix.de>
 <20130919100239.GS24802@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1309191207460.4089@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Sep 2013, Uwe Kleine-K?nig wrote:
> On Thu, Sep 19, 2013 at 12:01:25AM +0200, Thomas Gleixner wrote:
> > Versus the 64bit overflow check, we need to be even more careful. We
> > need to check for overflowing (1 << 63) - 1 (i.e. the max positive
> > value which fits into a s64). See clockevents_program_event().
> 
> That is because you interpret times < 0 as in the past, right? But note
> that the interim result we're talking about here is still to be divided
> by evt->mult. So assuming mult > 1, that check is too strict unless you
> move it below the do_div in clockevent_delta2ns. For sure it makes sense
> to use the same value for a and b in the handling:

No, it's not too strict.

    nsec = (latch << shift) / mult;

Now the backwards conversion does:

    latch = (nsec * mult) >> shift;
 
So we want nsec * mult to be in the positive range of s64. Which
means, that latch << shift must be in that range as well.

Thanks,

	tglx
