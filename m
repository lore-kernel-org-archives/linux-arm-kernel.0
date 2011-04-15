From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 21:28:58 +0100
Subject: [RFC] sanitizing crazy clock data files
In-Reply-To: <20110415202535.GQ1611@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<20110415193654.GP1611@n2100.arm.linux.org.uk>
	<20110415201232.GC14770@pengutronix.de>
	<20110415202535.GQ1611@n2100.arm.linux.org.uk>
Message-ID: <20110415202858.GR1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:25:35PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 10:12:32PM +0200, Sascha Hauer wrote:
> > The other regular i.MXs should fit into this fine, they have the same
> > patterns. mxs is different though, instead of enable bits they have
> > disable bits and dividers are one based instead of zero. We can probably
> > extend the patterns to handle some additional flags, but I haven't
> > looked deeply into it.
> 
> A suggestion from work tglx is currently doing - name the two functions
> which manipulate the mask bits 'set' and 'clear' rather than 'enable'
> and 'disable'.
> 
> Then, the clk ops can do this:
> 
> 	.clk_enable	= clk_gate_mask_set,
> 	.clk_disable	= clk_gate_mask_clear,
> 
> for ones with positive logic, and:
> 
> 	.clk_enable	= clk_gate_mask_clear,
> 	.clk_disable	= clk_gate_mask_set,
> 
> for negative logic.  No additional code required, just a variance in data
> structure.

Bah.  Except they may need to reference the parent... which kills that
idea.
