From: jason@lakedaemon.net (Jason)
Date: Tue, 6 Mar 2012 13:22:33 -0500
Subject: [RFC 00/14] Generic clk for Orion platforms.
In-Reply-To: <20120306175333.GA16608@lunn.ch>
References: <1331015471-28872-1-git-send-email-andrew@lunn.ch>
 <20120306155840.GS5050@titan.lakedaemon.net>
 <20120306161743.GI24858@lunn.ch>
 <20120306172341.GU5050@titan.lakedaemon.net>
 <20120306175333.GA16608@lunn.ch>
Message-ID: <20120306182233.GV5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 06:53:33PM +0100, Andrew Lunn wrote:
> > > You missed an important point. No driver has claimed these, but u-boot
> > > has turned them on.
> > 
> > This sounds like a bug in u-boot.
> 
> Is it? Even if it is, we have to live with it. Otherwise we introduce
> a regression, which is a big no-no. Also, how many users know how to
> upgrade u-boot? I don't have the necessary JTAG setup for my boxes, so
> i'm not going to risk bricking them by trying to upgrade u-boot.

Wrong is wrong.  if u-boot is enabling things that aren't needed
immediately after handoff, that needs to be fixed.  If the kernel is
depending on that error and not checking the state of the clocks before
performing actions, that also is broken.

Upgrading u-boot is necessary to support devicetree on kirkwood.  At
least, in any real fashion.  You could append the blob, but that is
Discouraged. ;-)

What kirkwood boards do you have?

> > Until that happens, could we walk across kirkwood_clks[] in
> > kirkwood_clock_gate() to determine what is in use?  eg:
> > 
> > #########
> > curr = readl(CLOCK_GATING_CTRL);
> > ...
> > used = CGC_DUNIT | CGC_RESERVED;
> > 
> > for (i = 0; i < ARRAY_SIZE(kirkwood_clks); i++) {
> > 	if (kirkwood_clks[i]->enable_count)
> > 		used |= kirkwood_clks[i]->/*PFM*/->mask;
> > }
> > 
> > /* disable anything in curr, but not in used */
> > if (CGC_SATA0 & (curr & ~used)) {
> > 	/* disable sata0 logic */
> > }
> > 
> > ...
> > #########
> 
> NO! clk is opaque. You should not be accessing members inside it. The
> clk struct members are not even declared when using the normal include
> files.

Ok, then how about:

	if (clk_is_enabled(kirkwood_clks[i])
		used |= 1 << clk_gate_bit_idx(kirkwood_clks[i]);

> Probably the short term solution is to simply add a deliberate
> regression, and not turn them off. Then help Mike implement generic
> code to handle this. We probably have three months to do this, since i
> doubt the clock code is going to be part of the next merge.

Good point.  I'd like to get it stabilized sooner rather than later,
though.

thx,

Jason.
