From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Apr 2011 12:45:00 +0200 (CEST)
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <20110429100927.GC5126@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
	<20110429100927.GC5126@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1104291223250.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:

> On Thu, Apr 21, 2011 at 09:48:28PM +0200, Thomas Gleixner wrote:
> > On Fri, 15 Apr 2011, Sascha Hauer wrote:
> > > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > > + * @get:	Called by the core clock code when a device driver acquires a
> > > + *		clock via clk_get(). Optional.
> > > + *
> > > + * @put:	Called by the core clock code when a devices driver releases a
> > > + *		clock via clk_put(). Optional.
> > 
> > These callbacks are completely pointless. There are only two non empty
> > implementations in tree:
> > 
> > One does a try_module_get(clk->owner), which should be done in generic
> > code. The other does special clock enabling magic which wants to go to
> > clk->prepare().
> 
> I disagree.  Most clocks don't live in a module - there's only one
> platform which does at present.  To force every clock to have an owner
> field is rediculous.  We already know that the OMAP tree represents a

So we trade an owner field (which can be NULL) versus two function
pointers in the clk_ops struct, which are of course subject to be
abused for all kind of crap which does not belong there at all.

> significant amount of data, and for every additional unnecessary word,
> it gobbles up another 4K of data space.

What are we talking about?

arch/arm/mach-omap2/clock2420_data.c:117
arch/arm/mach-omap2/clock2430_data.c:126
arch/arm/mach-omap2/clock3xxx_data.c:235
arch/arm/mach-omap2/clock44xx_data.c:228

So even if we could build a common kernel for all these omaps, then
adding owner to struct clk will consume ~2800 bytes.

> If we go down the route of separating clock stuff into bite-size pieces,
> OMAP is going to end up with yet more struct clks, which is going to add
> to the bloat even more.

Make it 8k then and it's still not any significant number.

Abstractions and I mean abstractions which encapsulate common
functionality have always a tradeoff in larger data size. And one
lesson I learned the hard way is that if you make abstractions and
frameworks by design permissive, then you end up with tons of extra
private code because people prefer to hack their "special needs" into
their private code instead of talking to the people who maintain the
core code where it could be solved in a generalized way.

Yes, we want to avoid unneccesary data size growth, but at the same
time we have to make it as hard as it gets for users of an
abstraction/framework to tinker around the core code as they see
fit. Otherwise you wont get any consolidation and reduction of over
and over copied and modified code doing basically the same thing.

If I can trade 2800 bytes of data vs. 280 lines of duplicated code and
a can of worms opened by interfaces which are an invitation for abuse,
then I chose the 2800 bytes any time.

Thanks,

	tglx
