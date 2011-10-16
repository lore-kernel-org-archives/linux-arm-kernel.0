From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 16 Oct 2011 19:55:21 +0200
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <20111014103233.GB9485@b20223-02.ap.freescale.net>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<20111014081024.GA9485@b20223-02.ap.freescale.net>
	<20111014100504.GC2966@opensource.wolfsonmicro.com>
	<20111014103233.GB9485@b20223-02.ap.freescale.net>
Message-ID: <20111016175521.GA13565@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 06:32:33PM +0800, Richard Zhao wrote:
> On Fri, Oct 14, 2011 at 11:05:04AM +0100, Mark Brown wrote:
> > On Fri, Oct 14, 2011 at 04:10:26PM +0800, Richard Zhao wrote:
> > > On Thu, Sep 22, 2011 at 03:26:56PM -0700, Mike Turquette wrote:
> > 
> > snip essentially Mike's entire mail - *please* delete irrelevant quotes
> > from your replies, it makes it very much easier to find the new text in
> > your mail and is much more friendly to people reading mail on mobile
> > devices.
> I snip not enough? sorry for that. I'll be carefull.
> > 
> > > > +static int __clk_enable(struct clk *clk)
> > > > +{
> > 
> > > Could you expose __clk_enable/__clk_disable? I find it hard to implement
> > > clk group. clk group means, when a major clk enable/disable, it want a set
> > > of other clks enable/disable accordingly.
> > 
> > Shouldn't this be something the core is implementing?  I'd strongly
> > expect that the clock drivers are relatively dumb and delegate all the
> > decision making to the core API.  Otherwise it's going to be hard for
> > the core to implement any logic that involves working with more than one
> > clock like rate change notification, or guarantee that driver requests
> > made through the API are satisfied, as the state of the clocks will be
> > changing underneath it.
> From my point of view, the first step of generic clk can be, easy to adopt
> features of clocks in current mainline git.
> Back to the clk group, I have a patch based on Sascha's work. 
> http://git.linaro.org/gitweb?p=people/riczhao/linux-2.6.git;a=shortlog;h=refs/heads/imx-clk

I thought further about this and a clock group is not something we want
to have at all. Clocks are supposed to be arranged in a tree and
grouping clocks together violates this which leads to problems.
This grouping should be done at driver level, so when a driver needs
more than one clock it should request them all, maybe with a clk_get_all
helper function.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
