From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 15:28:20 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201152203.GE1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
	<20110201140024.GZ1147@pengutronix.de>
	<20110201151418.GN31216@n2100.arm.linux.org.uk>
	<20110201152203.GE1147@pengutronix.de>
Message-ID: <20110201152820.GQ31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 04:22:03PM +0100, Uwe Kleine-K?nig wrote:
> Full ack.  (I wonder if you misunderstood me or wanted to put my
> statement into more words.  Jassi didn't like that a clk_enable without
> a previous clk_prepare worked on some platforms and on others it
> doesn't.  With BUG_ON(clk->ops->prepare && !clk->prepare_count) in
> clk_enable we have exactly this situation.)

Even with a NULL clk->ops->prepare function, we still want drivers to
have called clk_prepare().  So we can do something like:

	if (WARN_ON(clk->prepare_count == 0))
		return -EINVAL;

in clk_enable() should be sufficient and noisy enough not to be missed.

I'd avoid BUG_ON() here as that will take the system down, which may
increase the chances of getting useful bug reports.
