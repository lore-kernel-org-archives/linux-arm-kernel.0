From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 4 Feb 2011 17:33:32 +0800
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201204330.GJ1147@pengutronix.de>
References: <20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<20110201155344.GF1147@pengutronix.de>
	<20110201170637.GR31216@n2100.arm.linux.org.uk>
	<20110201193201.GH1147@pengutronix.de>
	<20110201195604.GS31216@n2100.arm.linux.org.uk>
	<4D486B59.6010106@codeaurora.org>
	<20110201204330.GJ1147@pengutronix.de>
Message-ID: <20110204093332.GA2347@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 09:43:31PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Feb 01, 2011 at 12:21:45PM -0800, Saravana Kannan wrote:
> > If the driver is calling clk_prepare() right next to clk_enable()
> > knowing it's been already prepared and will hence be "atomic" (this
> > is actually not true), then by your description, it's pointless to
> > call clk_prepare().
> Well not completely, as it increases the reference count.  The advantage
> would be that clk_enable counts addionally as prepare, so it would be
> impossible to unprepare an enabled clock.  And the other way round an
> unprepared clock would never be enabled.
>  
> > If you want the driver to call clk_prepare() in atomic context
> > because it will be atomic in most cases -- well, that's wrong. It's
> > either atomic or is NOT atomic. There is no in between. If a call is
> > NOT atomic, it can't be called in atomic context. Long story short,
> > if you expect clk_prepare() to be atomic under any circumstance, it
> > beats the point of introducing clk_prepare().
> Well, with my suggestion it's atomic when certain precondions are given.
> IMHO that's better than "atomic in most cases" because the caller can
> assert that everything goes smooth.
> These preconditions are asserted when the driver writer is careful
> enough to stick to the API.
IMHO, clk_prepare is always called in non-atomic context, so it doesn't matter
whether it's really atomic or not. We don't have to make it as atomic as
possible.

Thanks
Richard
> 
> Either my idea is bad or I'm unable to sell it appropriately.  Be it as
> it is, I will stop to make a case for it.
> 
> Best regards and thanks for your try,
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
