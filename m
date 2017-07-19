From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 18 Jul 2017 19:08:39 -0700
Subject: [PATCH v2 1/3] mux: Add mux_control_get_optional() API
In-Reply-To: <aac61f46-f963-2631-00e0-2d62baac6bf4@axentia.se>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
 <20170714214005.14967-2-stephen.boyd@linaro.org>
 <aac61f46-f963-2631-00e0-2d62baac6bf4@axentia.se>
Message-ID: <150043011983.23422.10872793103087420242@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Rosin (2017-07-17 01:20:14)
> On 2017-07-14 23:40, Stephen Boyd wrote:
> > diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
> > index 90b8995f07cb..a0e5bf16f02f 100644
> > --- a/drivers/mux/mux-core.c
> > +++ b/drivers/mux/mux-core.c
> > @@ -289,6 +289,9 @@ EXPORT_SYMBOL_GPL(devm_mux_chip_register);
> >   */
> >  unsigned int mux_control_states(struct mux_control *mux)
> >  {
> > +     if (!mux)
> > +             return 0;
> > +
> 
> I don't think this is appropriate. For this function, it might be ok,
> but...
> 
> >       return mux->states;
> >  }
> >  EXPORT_SYMBOL_GPL(mux_control_states);
> > @@ -338,6 +341,9 @@ int mux_control_select(struct mux_control *mux, unsigned int state)
> >  {
> >       int ret;
> >  
> > +     if (!mux)
> > +             return 0;
> > +
> 
> ...here and for other cases below it's very odd to return "ok", when
> -EINVAL or something seems much more appropriate. And if -EINVAL is
> returned here, the benefit of returning fake values for anything
> pretty much falls apart.
> 
> I simply don't like it, and prefer if the consumer code is arranged
> to not call the mux functions when the optional get() does not find
> the mux.

Do you want the callers of the mux APIs to know that an optional mux
isn't there, and then have checks at all callsites on optional muxes to
make sure consumers don't call the mux functions? Won't that duplicate
lots of checks in drivers for something the core could treat as a don't
care case? Sorry, I don't understand why the consumer cares that it was
there or not when it is optional.

> 
> >       ret = down_killable(&mux->lock);
> >       if (ret < 0)
> >               return ret;
> > @@ -370,6 +376,9 @@ int mux_control_try_select(struct mux_control *mux, unsigned int state)
> >  {
> >       int ret;
> >  
> > +     if (!mux)
> > +             return 0;
> > +
> >       if (down_trylock(&mux->lock))
> >               return -EBUSY;
> >  
> > @@ -398,6 +407,9 @@ int mux_control_deselect(struct mux_control *mux)
> >  {
> >       int ret = 0;
> >  
> > +     if (!mux)
> > +             return 0;
> > +
> >       if (mux->idle_state != MUX_IDLE_AS_IS &&
> >           mux->idle_state != mux->cached_state)
> >               ret = mux_control_set(mux, mux->idle_state);
> > @@ -422,14 +434,8 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
> >       return dev ? to_mux_chip(dev) : NULL;
> >  }
> >  
> > -/**
> > - * mux_control_get() - Get the mux-control for a device.
> > - * @dev: The device that needs a mux-control.
> > - * @mux_name: The name identifying the mux-control.
> > - *
> > - * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
> > - */
> > -struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> > +struct mux_control *
> > +__mux_control_get(struct device *dev, const char *mux_name, bool optional)
> >  {
> >       struct device_node *np = dev->of_node;
> >       struct of_phandle_args args;
> > @@ -441,6 +447,8 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> >       if (mux_name) {
> >               index = of_property_match_string(np, "mux-control-names",
> >                                                mux_name);
> > +             if (index == -EINVAL && optional)
> > +                     return NULL;
> 
> What about -ENODATA?

At this point in the code we're finding the index of a mux-control-names
property so I was trying to handle the case where there isn't a
mux-control-names property at all but we're looking for something
optional anyway. If there is a property, then we would see some other
error if something went wrong and then pass the error up. There is a
hole where there isn't a mux-control-names property and we're looking
for something that's optional, but there is a mux-control property. Do
we care though? The DT seems broken then.

> And if an optional mux is found here, but lookup
> fails later in e.g. the of_parse_phandle_with_args call, then I think
> an error should be returned. Because that seems like an indication that
> DT specifies that there *should* be a mux, but then there isn't one.

of_parse_phandle_with_args() would return ENOENT when there isn't a
mux-control property in DT. So I've trapped that case and returned an
"optional mux" pointer of NULL. I think we handle the case you mention,
where some index is found but it returns an error, because that would
return some error besides -ENOENT.

Sorry, I'm not really following what you're suggesting. Maybe it got
mixed up with the NULL vs. non-NULL return value from mux_control_get().
