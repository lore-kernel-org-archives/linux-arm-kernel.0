From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Dec 2015 10:12:19 +0100
Subject: [PATCH v2 1/3] reset: Add shared reset_control_[de]assert variants
In-Reply-To: <566B1424.2060700@redhat.com>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <1449853825.3419.50.camel@pengutronix.de> <566B1424.2060700@redhat.com>
Message-ID: <1450084339.3407.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Am Freitag, den 11.12.2015, 19:21 +0100 schrieb Hans de Goede:
[...]
> >> @@ -119,13 +134,55 @@ EXPORT_SYMBOL_GPL(reset_control_assert);
> >>   int reset_control_deassert(struct reset_control *rstc)
> >>   {
> >
> > Maybe WARN_ON(rstc->line->refcnt > 1) ?
> 
> I assume you mean deasser_cnt ? Seems reasonable with that change.

I meant refcnt. Currently drivers sharing reset lines (refcnt > 1)
and then using the non-shared reset control functions are bound to cause
unexpected behaviour. Now we can detect this for the first time.

> >>   	if (rstc->rcdev->ops->deassert)
> >> -		return rstc->rcdev->ops->deassert(rstc->rcdev, rstc->id);
> >> +		return rstc->rcdev->ops->deassert(rstc->rcdev, rstc->line->id);
> >>
> >>   	return -ENOTSUPP;
> >>   }
> >>   EXPORT_SYMBOL_GPL(reset_control_deassert);
> >>
> >>   /**
> >> + * reset_control_assert_shared - asserts a shared reset line
> >> + * @rstc: reset controller
> >> + *
> >> + * Assert a shared reset line, this functions decreases the deassert count
> >> + * of the line by one and asserts it if, and only if, the deassert count
> >> + * reaches 0.
> >
> > "After calling this function the shared reset line may be asserted, or
> >   it may still be deasserted, as long as other users keep it so."
> 
> I take it this is to replace the text about "deassert count" ?

I thought you might append something like it. I just imagine that when
reading the documentation it might be helpful to also see the intended
effect described, especially given that a call to an _assert_ function
might leave the reset line in deasserted state, depending on the
refcount.

> >> + */
> >> +int reset_control_assert_shared(struct reset_control *rstc)
> >> +{
> >> +	if (!rstc->rcdev->ops->assert)
> >> +		return -ENOTSUPP;
> >
> > WARN_ON(rstc->line->deassert_cnt == 0)
> >
> > Actually, what to do in this case? Assume ops->assert was called, or do
> > it again to be sure? Certainly we don't want to wrap deassert_cnt, or
> > the next deassert_shared will do nothing.
> >
> >> +	rstc->line->deassert_cnt--;
> >> +	if (rstc->line->deassert_cnt)
> >
> > deassert_cnt isn't protected by any lock.
> 
> Right, good catch. I believe the best way to fix this is to change deassert_cnt
> into an atomic_t and use atomic_dec_return / atomic_int_return,

Yes, that would work.

> Downside of using an atomic_t is that doing the WARN_ON you are asking for above
> will not be race free, then, but since it is a should never happen scenario I
> guess we do not care about the check not being 100% race free. Or we can even
> just leave out the check ?

Since this is only a warning to notify driver developers we don't
support shared resets (apart from the clock-like use)

Not if we warn about refcnt instead of deassert_cnt above.

[...]
> >> + * of the line by one and deasserts the reset line (if it was not already
> >> + * deasserted).
> >
> > "After calling this function, the shared reset line is guaranteed to be
> >   deasserted."
> 
> Same question as above.

Same imprecise answer. I'd like to see the expected state after calling
this function in the description, in addition to the mechanism. This is
more important for the assert function. After calling deassert, the
reset line is deasserted, no reason to be surprised about that.

regards
Philipp
