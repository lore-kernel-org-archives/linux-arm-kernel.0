From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Oct 2011 08:54:16 +0200
Subject: Warning at kernel/mutex.c
In-Reply-To: <20111019064603.GP18141@pengutronix.de>
References: <CAOMZO5AR4iiktjmjzUU3AbQmYVk4wE28+KrZckt=VXLBJzXdBA@mail.gmail.com>
	<20111018173744.GQ21648@n2100.arm.linux.org.uk>
	<CAOMZO5BKTzeV0f0=frQT-4uHESh2-cEQtc2UzniFT6dVSi_0EQ@mail.gmail.com>
	<20111018184008.GI21504@pengutronix.de>
	<CAOMZO5CayjCM7FkdfHxbnyhC9d+7QTODqmNr7_xFPwkLRo8rmw@mail.gmail.com>
	<20111019064603.GP18141@pengutronix.de>
Message-ID: <20111019065416.GL21504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2011 at 08:46:03AM +0200, Sascha Hauer wrote:
> On Tue, Oct 18, 2011 at 04:45:51PM -0200, Fabio Estevam wrote:
> > 2011/10/18 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > 
> > >> ?static LIST_HEAD(clocks);
> > >> ?static DEFINE_MUTEX(clocks_mutex);
> > >> +static DEFINE_SPINLOCK(clock_lock);
> > > If clocks_mutex is unused now, please remove it. If it's not unused you
> > > probably introduced a problem with your patch.
> > 
> > clocks_mutex is still used in clk_set_rate and clk_set_parent.
> > 
> > Should it be converted to spinlocks too?
> >
> 
> The mutex currently used protects two things: The clock tree and the
> clock registers. If we use a mutex for the parent/rate functions and
> a spinlock for enable/disable we must make sure that both function sets
> do not access the same registers.
... and that no strage things happen when there we're in the middle of a
parent/rate change and a clock is enabled or disabled.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
