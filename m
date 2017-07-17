From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 11:20:45 +0200
Subject: [PATCH 05/11] mmc: sunxi: Support controllers that can use both
 old and new timings
In-Reply-To: <CAPDyKFqe1hFmfWziu04fW=cQa0EGvT11YzuJ0f-eHy6+u7vutQ@mail.gmail.com>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-6-wens@csie.org>
 <CAPDyKFoLTXJ10EJRfPPggJBg8bh9BpdwTnew-WL0G7LpnO43Pg@mail.gmail.com>
 <CAGb2v64gjLSdb83fR9OCZthtgMQz-UkmMhT9OmJkq3Xp6mJ-aA@mail.gmail.com>
 <CAPDyKFqe1hFmfWziu04fW=cQa0EGvT11YzuJ0f-eHy6+u7vutQ@mail.gmail.com>
Message-ID: <20170717092045.3hidokuo6w7cgorw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 11:57:35AM +0200, Ulf Hansson wrote:
> >>> +       if (host->use_new_timings) {
> >>> +               ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
> >>
> >> Can't this be solved through some other generic API/interface?
> >
> > The old discussion is here: https://lkml.org/lkml/2017/5/5/77
> >
> > It is possible to piggy back on existing API, but as Maxime mentioned
> > back in the discussion, it is confusing.
> >
> > IIRC Mike said (via Maxime) an SoC specific call was the easy way
> > to handle this. I don't think there's anything generic about this.
> > Even if you could have a _set_mode callback for the clks, the modes
> > would be SoC specific anyway.
> 
> Right. But it would benefit that we can keep drivers generic, as they
> are using generic APIs/interfaces. I prefer that.
> 
> Anyway, let me try to dig up the earlier discussion.

There's really not any generic way to support that. Even if we reuse
some other function (clk_set_phase/clk_get_phase was suggested), and
use error codes and / or values to differentiate between two modes,
this will be very much implementation-specific as well, and any other
SoC that in theory would be using that will very likely to not
implement the same behaviour for its clocks.

And this driver is only used on one SoC family, so it's not really a
big deal anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/4308a42b/attachment-0001.sig>
