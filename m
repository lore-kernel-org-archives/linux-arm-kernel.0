From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 May 2015 15:31:24 +0200
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <20150429230549.16410.82625@quantum>
References: <20150408081450.GB5162@x1> <20150408094349.GC26727@lukather>
 <20150408103832.GG5162@x1> <20150408155705.GF26727@lukather>
 <20150408172344.GH5162@x1> <20150422093446.GA28007@lukather>
 <20150429141751.GR9169@x1> <20150429145114.GW6325@pengutronix.de>
 <20150429160713.GY9169@x1> <20150429230549.16410.82625@quantum>
Message-ID: <20150504133124.GD3274@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 04:05:49PM -0700, Michael Turquette wrote:
> > > Could you elaborate why you still want to have the clk-always-on in the
> > > device tree instead of in the kernel where it can be removed when
> > > necessary? What's your problem with enabling the critical clocks using
> > > clk_prepare_enable like other SoCs already do?
> > 
> > I've explained what my issues are already.  I'm not a fan of
> > hand-rolling and duplicating code which can be consolidated and make
> > generic.  Call me old fashioned. :)
> 
> I agree with Lee that the open code stuff isn't great, but I'm less and
> less convinced that the DT method is the way to go. Maxime has done a
> good job of reminding me why I always pushed back on this type of
> approach in the past.
> 
> Having a clock provider driver call clk_get, clk_prepare_enable on a clk
> is just fine. I think what needs to be done is to look at the platforms
> that open code this and find out how to replace this with some common
> code that any clock provider driver can call. Perhaps we can:
> 
> 1) use the struct clk_ops.init callback (which is used very little) and
> pass in a generic function to handle this case, or

I'm not sure that would work with clocks that provide several outputs,
and need only one (or at least not all of them) to be enabled.

Or we would need to pass some arguments to this function when we
register our clock.

> 2) we can create a new per-clk flag which is used by __clk_init to call
> clk_prepare_enable, or

That would work. It's what people usually expect from
CLK_IGNORE_UNUSED, and it's the first thing they try, so it would be
the easiest I guess.

> 3) we can add a new generic function like clk_register which sets any
> specified defaults (clk_set_defaults), but using C code and not DT

What kind of defaults are we talking about here? Just the clock state
or do you include boundaries, rate, etc. in it?

> I would need to look at the drivers that open code their
> clk_prepare_enable calls for non-Linux devices and see what similarities
> exist.

What really worked for us is to call clk_prepare_enable straight after
the call to clk_register.

Having a single place where we enable all the clocks causes a few
issues, mostly because we're not even sure the clock has been
registered at this time, and we do have to consider the clock name as
an ABI, which caused some issues for us in the past.

> But clearly the DT element of Lee's approach is causing some push
> back, so we should consider if there is a less controversial way to do
> this (and a way that benefits non-DT platforms as well).
> 
> I do think Lee's idea of consolidating around a single solution to a
> common problem is a great idea, but maybe not by using Devicetree.

Agreed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/19382502/attachment.sig>
