From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 08:40:09 +0100
Subject: Locking in the clk API
In-Reply-To: <4D2D1F0D.5040208@codeaurora.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<201101111830.18597.jeremy.kerr@canonical.com>
	<20110111121816.GB774@linux-sh.org>
	<201101112235.43061.jeremy.kerr@canonical.com>
	<4D2D1F0D.5040208@codeaurora.org>
Message-ID: <20110112074009.GX24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravana,

On Tue, Jan 11, 2011 at 07:25:01PM -0800, Saravana Kannan wrote:
> On 01/11/2011 06:35 AM, Jeremy Kerr wrote:
> >Hi Paul,
> >
> >>Again, you are approaching it from the angle that an atomic clock is a
> >>special requirement rather than the default behaviour.
> >
> >I'm not considering it a special requirement, but it's still a requirement
> >(that the called function does not sleep).
> >
> >The problem with the inverse logic (clk_enable/clk_enable_sleepable) is that
> >now you've made the caller need to know what kind of clock it has, or might
> >have one day.
> 
> I think it's just a matter of how you interpret the name of the API
> in English. It doesn't make the decision making of the developer any
> easier.
> 
> Just having a _atomic suffix doesn't mean the driver developer
> doesn't need to know what type of clock it is. They are still making
> the assumption that the enable/disable for that clock can be done
> atomically -- namely an "atomic clock".
But there is a difference to 'one function to rule both sleepable and
atomic clocks'.  When calling _atomic on a sleepable clock you get
-ESOMETHING back (and the clock stays off).  With a generic clk_enable
you get an oops and so cannot handle the error.

> Similarly, when a driver developer calls the _sleepable APIs in
> their code, for all practical purposes, they are making an
> assumption that the enable/disable for that clock *needs to* (not
> may) sleep.
IMHO this is not right.  If the driver developer doesn't care if the
clock sleeps or not (which is the norm I think) he calls the _sleepable
function and if the clock happen to be an atomic one it doesn't hurt
him.

And looking at the usage of the sleeping functions in the gpio API, I'd
bet that at least 50% of the calls to gpio_set_value can/should be
gpio_set_value_cansleep.  That's because driver developers don't care or
are not aware of the issue.  If it would be gpio_set_value
vs.gpio_set_value_atomic most developers would use the sleeping variant
and the few that should use the _atomic function would notice that when
seeing the corresponding oops.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
