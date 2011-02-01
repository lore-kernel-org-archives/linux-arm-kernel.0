From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Feb 2011 15:00:24 +0100
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
Message-ID: <20110201140024.GZ1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 10:05:56PM +0900, Jassi Brar wrote:
> 2011/2/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> 
> .....
> 
> > Do you plan to handle the case that clk_enable is called while prepare
> > isn't completed (considering the special case "not called at all")?
> > Maybe BUG_ON(clk->ops->prepare && !clk->prepare_count)?
> Sounds better than the second option.
> 
> > Alternatively don't force the sleep in clk_prepare (e.g. by protecting
> > prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
> > before calling clk->ops->enable?
> That might result in a driver working on some platforms(those have
> atomic clk_prepare)
> and not on others(those have sleeping).
The first option has the same result.  E.g. on some platforms
clk->ops->prepare might be NULL, on others it's not.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
