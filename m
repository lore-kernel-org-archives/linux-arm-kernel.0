From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 18:34:12 +0100
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <20120402170442.GF24211@n2100.arm.linux.org.uk>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120402170442.GF24211@n2100.arm.linux.org.uk>
Message-ID: <20120402172954.GH15197@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 06:04:43PM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 01, 2012 at 12:32:40PM +0100, Mark Brown wrote:
> > Allow clk API users to simplify their cleanup paths by providing a
> > managed version of clk_get().

> > Due to the lack of a standard struct clk to look up the device from a
> > managed clk_put() is not provided, it would be very unusual to use this
> > function so it's not a big loss.

> Err, why?  The contents of struct clk has nothing to do with clk_put().
> You're doing something really wrong here.

It does for a devm_clk_put().  Normally this would end up being:

	void devm_clk_put(struct clk *clk);

but the devres stuff needs us to have a struct device to get the
underlying allocation/mapping and undo it.

> Remember, there is not going to _ever_ be the situation where a struct clk
> is specific to any particular struct device - it's a 1:N mapping between
> clks and devices.

Right, absolutely - to do it as above struct clk would be allocated per
user and indirect to the actual clock implementation (which some people
were muttering about for other reasons, though I can't remember what
those were off the top of my head).  Probably what would actually end up
happening is that we'd instead have a signature like:

	devm_clk_put(struct device *dev, struct clk *clk);

but I didn't particularly feel like making that decision right now,
especially if we do end up going with per user allocations and can use
the more idiomatic signature.

> So, until you sort out your misunderstanding, NAK.

I think I understand just fine, thanks.

In any case, we'd only really need a devm_clk_put() if someone wants one
which is a bit of a corner case in the first place so just ignoring the
issue until that happens should be fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/90c172ee/attachment.sig>
