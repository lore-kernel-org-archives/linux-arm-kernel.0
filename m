From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 19 Jul 2017 11:02:43 -0700
Subject: [PATCH v2 1/3] mux: Add mux_control_get_optional() API
In-Reply-To: <1c20e9bf-9b87-a021-bb4b-8add6c468c87@axentia.se>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
 <20170714214005.14967-2-stephen.boyd@linaro.org>
 <aac61f46-f963-2631-00e0-2d62baac6bf4@axentia.se>
 <150043011983.23422.10872793103087420242@sboyd-linaro>
 <1c20e9bf-9b87-a021-bb4b-8add6c468c87@axentia.se>
Message-ID: <150048736301.28753.6788345725743262236@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Rosin (2017-07-19 00:15:38)
> On 2017-07-19 04:08, Stephen Boyd wrote:
> > Quoting Peter Rosin (2017-07-17 01:20:14)
> >> On 2017-07-14 23:40, Stephen Boyd wrote:
> >>> @@ -441,6 +447,8 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> >>>       if (mux_name) {
> >>>               index = of_property_match_string(np, "mux-control-names",
> >>>                                                mux_name);
> >>> +             if (index == -EINVAL && optional)
> >>> +                     return NULL;
> >>
> >> What about -ENODATA?
> > 
> > At this point in the code we're finding the index of a mux-control-names
> > property so I was trying to handle the case where there isn't a
> > mux-control-names property at all
> 
> Yes, you indeed need to check for -EINVAL to catch that. No argument
> about that.

Ok.

> 
> >                                   but we're looking for something
> > optional anyway. If there is a property, then we would see some other
> > error if something went wrong and then pass the error up. There is a
> > hole where there isn't a mux-control-names property and we're looking
> > for something that's optional, but there is a mux-control property. Do
> > we care though? The DT seems broken then.
> 
> I was thinking about the case where mux-control-names names *other* muxes
> but not the one asked for in this call. That's not broken and should be
> handled. The way I read it, you get -ENODATA in that case?

Yes that would return -ENODATA. Similarly, it would be returned if we
had a boolean mux-control-names property (which is completely broken).

> 
> >> And if an optional mux is found here, but lookup
> >> fails later in e.g. the of_parse_phandle_with_args call, then I think
> >> an error should be returned. Because that seems like an indication that
> >> DT specifies that there *should* be a mux, but then there isn't one.
> > 
> > of_parse_phandle_with_args() would return ENOENT when there isn't a
> > mux-control property in DT. So I've trapped that case and returned an
> > "optional mux" pointer of NULL. I think we handle the case you mention,
> > where some index is found but it returns an error, because that would
> > return some error besides -ENOENT.
> > 
> > Sorry, I'm not really following what you're suggesting. Maybe it got
> > mixed up with the NULL vs. non-NULL return value from mux_control_get().
> 
> What I mean is that if you have passed a mux_name and the index of that
> name was indeed found in the of_property_match_string call, then any
> failure from of_parse_phandle_with_args indicates a bad DT and should
> IMO result in an error. I.e., when evaluating the result from
> of_parse_phandle_with_args, you should account for the optional param
> if and only if mux_name is NULL.
> 
> You can do that by e.g. setting optional to false after looking up the
> mux_name index (because at that point the mux is no longer considered
> optional). E.g. as the last statement in the if (!mux_name) block.
> 

Ok got it. I'll rework the logic.
