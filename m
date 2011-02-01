From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 15:14:18 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201140024.GZ1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
	<20110201140024.GZ1147@pengutronix.de>
Message-ID: <20110201151418.GN31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 03:00:24PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Feb 01, 2011 at 10:05:56PM +0900, Jassi Brar wrote:
> > 2011/2/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > 
> > .....
> > 
> > > Do you plan to handle the case that clk_enable is called while prepare
> > > isn't completed (considering the special case "not called at all")?
> > > Maybe BUG_ON(clk->ops->prepare && !clk->prepare_count)?
> > Sounds better than the second option.
> > 
> > > Alternatively don't force the sleep in clk_prepare (e.g. by protecting
> > > prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
> > > before calling clk->ops->enable?
> > That might result in a driver working on some platforms(those have
> > atomic clk_prepare)
> > and not on others(those have sleeping).
> The first option has the same result.  E.g. on some platforms
> clk->ops->prepare might be NULL, on others it's not.

If clk->ops->prepare is NULL, then clk_prepare() better return success
as it should mean "no preparation necessary", not "someone didn't
implement it so its an error".

Calling clk->ops->enable() with a spinlock held will ensure that no one
tries to make that method sleep, so if people want sleeping stuff they
have to use the clk_prepare() stuff.  It's a self-enforcing API which
ensures that we don't get sleeping stuff inside clk_enable().

And with a check in clk_enable() for a preparation, it helps to ensure
that drivers do call clk_prepare() before clk_enable() - though it can't
guarantee it in every case.
