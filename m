From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 03:58:33 -0700
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <alpine.LFD.2.02.1104291223250.3005@ionos>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
	<20110429100927.GC5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291223250.3005@ionos>
Message-ID: <20110429105832.GY3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [110429 03:42]:
> On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
> 
> > On Thu, Apr 21, 2011 at 09:48:28PM +0200, Thomas Gleixner wrote:
> > > On Fri, 15 Apr 2011, Sascha Hauer wrote:
> > > > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > > > + * @get:	Called by the core clock code when a device driver acquires a
> > > > + *		clock via clk_get(). Optional.
> > > > + *
> > > > + * @put:	Called by the core clock code when a devices driver releases a
> > > > + *		clock via clk_put(). Optional.
> > > 
> > > These callbacks are completely pointless. There are only two non empty
> > > implementations in tree:
> > > 
> > > One does a try_module_get(clk->owner), which should be done in generic
> > > code. The other does special clock enabling magic which wants to go to
> > > clk->prepare().
> > 
> > I disagree.  Most clocks don't live in a module - there's only one
> > platform which does at present.  To force every clock to have an owner
> > field is rediculous.  We already know that the OMAP tree represents a
> 
> So we trade an owner field (which can be NULL) versus two function
> pointers in the clk_ops struct, which are of course subject to be
> abused for all kind of crap which does not belong there at all.
> 
> > significant amount of data, and for every additional unnecessary word,
> > it gobbles up another 4K of data space.
> 
> What are we talking about?
> 
> arch/arm/mach-omap2/clock2420_data.c:117
> arch/arm/mach-omap2/clock2430_data.c:126
> arch/arm/mach-omap2/clock3xxx_data.c:235
> arch/arm/mach-omap2/clock44xx_data.c:228
> 
> So even if we could build a common kernel for all these omaps, then
> adding owner to struct clk will consume ~2800 bytes.

Just to correct something, we are already building a common kernel
for all these, see omap2plus_defconfig.

For the size, device tree will shrink down that data where only
only one set of clock data is passed to the kernel. So I don't
think the size is such a big issue.

Regards,

Tony
