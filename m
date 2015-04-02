From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 2 Apr 2015 11:48:38 +0100
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <CAMuHMdWYEWoCkARLjU3WXWyh+tbe=j_ftAF+HDFT6dYAfcCo-w@mail.gmail.com>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <20150304120003.GL32624@x1> <20150306190812.11109.82130@quantum>
 <20150309092804.GB3427@x1>
 <CAMuHMdV8_uKQQgYkRPFOBgrqgw_y9A7T84ukfgWZpJmTL0eFCQ@mail.gmail.com>
 <20150326135144.GI5951@x1>
 <CAMuHMdVpXCFk9Z68OeVt0924dhR_9vdLYmBkWun1UGY3NJJ4wg@mail.gmail.com>
 <20150326193818.GQ5951@x1>
 <CAMuHMdWYEWoCkARLjU3WXWyh+tbe=j_ftAF+HDFT6dYAfcCo-w@mail.gmail.com>
Message-ID: <20150402104838.GZ9447@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 Apr 2015, Geert Uytterhoeven wrote:
> On Thu, Mar 26, 2015 at 8:38 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 26 Mar 2015, Geert Uytterhoeven wrote:
> >> On Thu, Mar 26, 2015 at 2:51 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >> > On Wed, 25 Mar 2015, Geert Uytterhoeven wrote:
> >> >> On Mon, Mar 9, 2015 at 10:28 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> >> > On Fri, 06 Mar 2015, Mike Turquette wrote:
> >> >> >> This approach looks fine to me. In practice I think it is restricted to
> >> >> >> hardware blocks that don't exist in DT yet (e.g. no driver, in the case
> >> >> >> of your interconnect) and that restriction is probably for the best.
> >> >> >
> >> >> > Agreed.
> >> >>
> >> >> I think this restriction should be documented in the DT binding more clearly,
> >> >> as adding a "clk-always-on" node prohibits you from handling the clock
> >> >> correctly in
> >> >> the future.
> >> >
> >> > Would you mind taking the time to explain what you think those
> >> > limitations are?
> >>
> >> If you add a "clk-always-on" node, the clock will always on using that DT.
> >> That will still be true later, when you get a better understanding of the
> >> hardware, and might discover you're gonna need a driver for the currently
> >> hidden core component that's driven by the clock, and may want to manage
> >> that clock.
> >
> > So I have two points here.
> >
> > First point; I think you're looking at an older version of my set.
> > The newer one can be found at [1] and no longer uses 'always-on'
> > nodes.  Instead the 'clk-always-on' property is applied to the
> > provider.  See the documentation patch [2] for more details.
> 
> Thanks, I was indeed looking at an old version.
> Still, that doesn't change that the clock to not be disabled in specified
> explicitly from DT.
> 
> > Second point; this binding is _not_ to be used as a hack because the
> > hardware isn't understood.  Genuine uses are for clocks that must not
> > be turned off ever, else bad things will happen.  If the hardware is
> > not understood, use 'clk-disable-unused' on the kernel cmdline
> > instead.

[...]

> > If this clock should _genuinely_ be always-on, then use my new
> > binding in the clock controller node and the Clk framework will not
> > turn it off.
> 
> It's supposed to be on when the application ARM core(s) is/are running.
> Many SoCs also have smaller cores (SH, Cortex R or M), intended to
> run a real-time OS. If the RT core is in charge, it may decide to shut down
> the application ARM core(s), incl. supposedly always-on modules like
> the ARM GIC.
> 
> I couldn't find a detailed block diagram of the STiH4xx SoCs, but at least
> STiH416 has an "ST proprietary multi-compartmental security IP and DRM
> processor".

You might be interested in the latest incarnation of the set.

See if it solves your issues.

https://lkml.org/lkml/2015/4/1/267

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
