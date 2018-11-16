From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 16 Nov 2018 11:45:03 +0100
Subject: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
In-Reply-To: <20181116100114.GB28631@ulmo>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
 <20181116100114.GB28631@ulmo>
Message-ID: <20181116104503.he6rykrsqt4whacs@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

On Fri, Nov 16, 2018 at 11:01:14AM +0100, Thierry Reding wrote:
> On Fri, Nov 16, 2018 at 11:22:49AM +0200, Vladimir Zapolskiy wrote:
> > On 11/16/2018 08:52 AM, Uwe Kleine-K?nig wrote:
> > > Regarding the .request case: The consumer might be interested in taking
> > > over the configured state from the boot loader. So the initially
> > > configured state should be retained.
> > > 
> > > For the free case the PWM consumer is responsible to disable the PWM
> > > before calling pwm_release and there are three subcases to consider:
> > > 
> > 
> > the changes are fine per se, but please split them into two.
> > 
> > Probably pwm_disable() misusage began spreading from commit 54b2a999a1675.
> 
> It's not really misusage to call pwm_disable(). It's basically just a
> shortcut for ->disable() or the atomic equivalent for it.

I'd say that pwm_disable() is not a shortcut but the long way round to
.disable() at best.

And that calling pwm_disable() from the low level driver doesn't result
in problems is just luck because the pwm framework is such a thin
wrapper. If it would do locking, .free might already hold the lock and
pwm_disable might try to grab it again. If it would do more checking
that only a caller of pwm_get calls pwm_disable, the check would trigger
because the consumer already called pwm_put and the lowlevel driver
didn't use pwm_get.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
