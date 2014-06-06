From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 06 Jun 2014 15:31:23 -0700
Subject: [PATCH v3] clk: exynos5420: Remove aclk66_peric from the clock
 tree description
In-Reply-To: <CAD=FV=UQhBh68Bgv=kfUROCOxg1dS1OnZ1ir+wouewKoDFE_1g@mail.gmail.com>
References: <1401467562-5585-1-git-send-email-dianders@chromium.org>
 <1402000514-30752-1-git-send-email-dianders@chromium.org>
 <20140606000324.10062.10257@quantum>
 <CAD=FV=UQhBh68Bgv=kfUROCOxg1dS1OnZ1ir+wouewKoDFE_1g@mail.gmail.com>
Message-ID: <20140606223123.10062.29366@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Doug Anderson (2014-06-05 17:46:23)
> Mike,
> 
> On Thu, Jun 5, 2014 at 5:03 PM, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Doug Anderson (2014-06-05 13:35:14)
> >> The "aclk66_peric" clock is a gate clock with a whole bunch of gates
> >> underneath it.  This big gate isn't very useful to include in our
> >> clock tree.  If any of the children need to be turned on then the big
> >> gate will need to be on anyway.  ...and there are plenty of other "big
> >> gates" that aren't described in our clock tree, some of which shut off
> >> collections of clocks that have no relationship in the hierarchy so
> >> are hard to model.
> >
> > I think this is a common problem. On OMAP we have something similar to
> > this called "clock domains" or "clkdm" and it has been historically
> > handled outside of the Linux clock framework[1]. There is a relationship
> > to the clock framework of course and in the future it might be
> > worthwhile to see if there is a generic way to handle this stuff.
> 
> That sounds like something that would be nice to solve, but it's not
> going to happen now.
> 
> On the off chance that the user manual mentioned the existence of one
> of these "big gate" bits, it tends to not be very specific about
> _exactly_ which sets of clocks it disables.
> 
> Tracking down every one of these would be hugely time consuming.
> Also: as Tomasz has indicated they don't provide a huge amount of
> benefit since we're already dealing with clocks on a more fine-grained
> level...

Sounds like you are dealing with crappy documentation :-(

> 
> 
> >> "aclk66_peric" is causing earlyprintk problems since it gets disabled
> >> as part of the boot process, so let's just remove it.
> >>
> >> Strangely (and for no good reason) this clock is exported as part of
> >> the common clock bindings.  Remove it since there are no in-kernel
> >> device trees using it and no reason anyone out of tree should refer to
> >> it either.
> >
> > So Linux has no control over the big gate now, correct? You are
> > dependent on the bootloader to ungate this thing?
> 
> A better way to put it is that you're dependent on the bootloader not
> to gate it.
> 
> ...but that's also true for pretty much any clock marked IGNORE_UNUSED
> and not explicitly enabled anywhere.
> 
> 
> Are you opposed to this landing as-is to unblock things and people can
> continue to work on the clock driver to make it even better?

No. I'm just trying to understand how things work so that we can arrive
to the right decision. I know what it is like to try and quickly unblock
everyone else and the rush to do so often leads to less awesome
solutions.

Anyways, getting back on point, Tomasz was right about the whole clk_get
thing. So I'm happy to take either V1 or V3 of your patch. I will be
submitting a second PR for 3.16 next week and it will include whichever
version you and Tomasz agree is best.

Regards,
Mike

> 
> -Doug
