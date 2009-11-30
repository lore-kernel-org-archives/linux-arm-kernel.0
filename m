From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Nov 2009 15:01:00 +0000
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
	<20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
Message-ID: <20091130150100.GB7028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 02:47:02PM +0000, Alan Cox wrote:
> SHARED|DISABLED ought to WARN_ON() and if that doesn't motivate people
> then return -EINVAL.

That is an impossibility.  There is hardware out there (AT91) where
the timer interrupt is shared with other peripherals, and you end
up with a mixture of irqs-disabled and irqs-enabled handlers sharing
the same interrupt.

Luckily, the timer interrupt is the first to claim, and so is the first
to be run.  However, there was a problem reported a while back of the
clock event code being called on AT91 with IRQs enabled - unfortunately
the original reporters stopped responding so it was never worked out
what was going on.

My point is that if we outlaw irqs-disabled shared interrupts, it puts
Atmel AT91 support into immediate difficulties.
