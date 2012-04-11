From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Apr 2012 10:20:34 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411084528.GB20818@b20223-02.ap.freescale.net>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
Message-ID: <20120411092034.GV24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:45:29PM +0800, Richard Zhao wrote:
> On Wed, Apr 11, 2012 at 09:24:02AM +0100, Mark Brown wrote:
> > On Wed, Apr 11, 2012 at 09:11:50AM +0800, Richard Zhao wrote:
> > 
> > > I don't like string loopup either. And after DT binding, we can use
> > > phandler to refer clk.
> > 
> > No, this is only useful on platforms that use DT.  This is a generic
> > Linux API so it needs to support architectures and platforms that don't
> > use DT as it's vanishingly unlikely that DT will ever be adopted by all
> > platforms.
> My point is using string lookup as less as possible. When one register
> a clk, one already got the struct clk* pointer and could use it in
> struct lookup.
> 
> I'm worried about the performance as I saw string lookup is used more
> and more often. In fast boot case, for example, even 5ms is important.

Yes, and you're not the only one who has that concern.  What this patch
does is turn a pair of string compares through a table into that plus
another set of string compares across all struct clk, which will make
the lookup yet more expensive.

I see no reason why you'd register the cl_lookup structures before you
know about which clks actually exist - and if they already exist, then
you can already find the struct clk pointer and use that to register
the proper return value for clk_get() via the clkdev APIs.

As I've said in the past, naming individual clock structures is the
stupidest thing that anyone ever did and causes nothing but problems.
We've seen that in the drivers with the abuse of clk_get(NULL, name)
where people wanted to pass the name in via platform data.  We're
starting to see the same thing here as well, except the problem people
will see will be boot performance instead caused by multiple levels of
string compares.
