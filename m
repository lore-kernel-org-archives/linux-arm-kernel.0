From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Apr 2011 09:39:10 +0200
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <4DAF5403.8090802@codeaurora.org>
References: <1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110418094909.GE31131@pengutronix.de>
	<20110418100716.GJ14770@pengutronix.de>
	<4DACF761.3050503@codeaurora.org>
	<20110419073249.GK31131@pengutronix.de>
	<0943efffac47bface3dff8ca4d700361.squirrel@www.codeaurora.org>
	<20110419093126.GA14770@pengutronix.de>
	<2b16ee39-08ba-4482-a9fc-6d1393ac1229@email.android.com>
	<20110420063643.GD15233@pengutronix.de>
	<4DAF5403.8090802@codeaurora.org>
Message-ID: <20110421073910.GH31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 02:45:39PM -0700, Saravana Kannan wrote:
> On 04/19/2011 11:36 PM, Sascha Hauer wrote:
> >On Tue, Apr 19, 2011 at 03:28:50PM -0700, Saravana Kannan wrote:
> >>Sascha Hauer<s.hauer@pengutronix.de>  wrote:
> >>
> >>>>>>
> >>>>>>We should really have something like:
> >>>>>>clk_set_rate_range(min, ideal, max)
> >>>>>(Note this is orthogonal to the question if set_rate may barf on
> >>>values
> >>>>>other than the return values of round_rate.)
> >>>>>
> >>>>>clk_set_rate_range can even be implemented with clk_round_rate that
> >>>is
> >>>>>just required to fulfill:
> >>>>
> >>>>I think it's more important that we try to find a new API that's
> >>>better
> >>>>than clk_round_rate(). We can worry about the specifics of the
> >>>>implementation later.
> >>>
> >>>You found it and Uwe found a way to implement this ontop of the old
> >>>API,
> >>>that's a comfortable situation, isn't it?
> >>
> >>Well, do we all agree to this new API? I have no problem with Uwe's
> >>helper fn or his suggestion, if we all agree on the final API. I just
> >>didn't want him wasting his time when the API is not finalized.
> >
> >As Uwes suggestion does not change the internal clock API it's
> >relatively simple to try out. With this we moved to the
> >add-a-helper-function class of patches and are not in the
> >change-internal-and-external-API-with-hundreds-of-users
> >class anymore.
> 
> If clk_set_rate_range() is not made an external API, then it's
> pointless to even add it.
Correct, if it's there every driver should be able to use it.
 
> Also, you can make it an internal API (to be implemented by clock
> drivers) and still not need "hundreds of users to change". The
> generic code will use this helper function if the set_rate_range()
> API is not implemented by a specific clock/clock driver. If it's
> implemented by the specific clock, then that one will be used.
> That's not rocket science.
It's discussable if it's worth to add it to the internal API or if my
suggestion works for everybody. I think the best path to choose here is:
When this functionallity is needed add a global and generic function
(like my suggestion). If this proves to behave bad for a certain clk
a mechanism to override it per clk can still be added later.

> Let's stop discussion about whether Uwe's change is useful or not. I
> don't care. If you think it's great, then good for you both.
Right, it only makes sense to think about adding such a function when
the first user pops up.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
