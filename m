From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 04 Jan 2016 21:39:59 +0100
Subject: [linux-sunxi] Re: [PATCH v2 1/3] reset: Add shared
 reset_control_[de]assert variants
In-Reply-To: <5675378F.5010904@redhat.com>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <20151214093607.GF19456@lukather> <1450086655.3407.23.camel@pengutronix.de>
 <20151216102934.GR19456@lukather> <1450264908.3421.36.camel@pengutronix.de>
 <20151218110810.GK30359@lukather> <5675378F.5010904@redhat.com>
Message-ID: <1451939999.3884.89.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 19.12.2015, 11:55 +0100 schrieb Hans de Goede:
> On 18-12-15 12:08, Maxime Ripard wrote:
[...]
> > I guess we could also have something like this:
> >
> >    * The driver gets the reference to the reset line using
> >      reset_control_get or its shared variant.
> >
> >      - If you call reset_control_get on a free line, it succeeds, and
> >        marks the line in exclusive use.
> >      - If you call reset_control_get on a busy line, it fails with
> >        EBUSY
> >
> >      - If you call the shared variant on a free line, it succeeds
> >      - If you call the shared variant on a busy exclusive line, it
> >        fails with EBUSY
> >      - If you call the shared variant on a busy !exclusive line, it
> >        succeeds.
>>
> >    * The customer driver can then call reset_control_assert / deassert:
> >
> >      - If the reset line is in exclusive use, the assertion happens
> >        right away, it succeeds and returns 0.
> >
> >      - If the reset line is in a !exclusive use, but with a single
> >        user, the assertion happens right away, it succeeds and returns
> >        0.
>
> Ack for all of the above, this is what I had in mind at first, but I started
> with a more lightweight version as I'm lazy :)  If Philipp likes this
> suggestion I can rework my patch-set into this.

Seconded, this all sounds good to me.

> >      - If the reset line is in a !exclusive use with more than 1 user,
> >        the refcount is modified and an error is returned to notify that
> >        it didn't happen.
>
> Also ack, except for returning the error, if a driver has used
> reset_control_get_shared, it should simply be aware that doing an assert
> might not necessarily actually assert the line, just like doing a clk-disable
> does not really necessary disable the clock, etc. If a driver is not prepared
> to deal with this, it should simply not use reset_control_get_shared.
>
> I see returning an error if the assert did not happen due to other users /
> deassert_count != 0 as inconsistent compared to how clks, regulators and phys
> handle this, these all simply return success in this case.

I wouldn't want drivers to have to differentiate between relevant and
irrelevant error codes, so in the clock-like refcounting use case
reset_assert should not return an error if it just correctly decremented
the refcount. I'd still prefer to have separate API for the counted
must_deassert/may_assert vs the exclusive must_assert/must_deassert use
cases, but I just can't think of a good name.

regards
Philipp
