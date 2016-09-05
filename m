From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Sep 2016 19:26:03 +0100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <20160905105803.13ed27ff@canb.auug.org.au>
References: <20160905105803.13ed27ff@canb.auug.org.au>
Message-ID: <20160905182603.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 10:58:03AM +1000, Stephen Rothwell wrote:
> I fixed it up (I deleted the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

That's the "simple" way of making the conflict go away, but I'm afraid
it's really not that simple.

Having just looked at the SMC91x definition for realview, it shows that
the SMC91x binding, like many of the conversions that the patch in my
tree fixes, has been created without a proper understanding of the
hardware.  To put it simply, it is broken.

The binding only allows _one_ register width to be specified, which is
completely incorrect: the binding _must_ allow multiple register widths
to be specified.  This is what SMC91x has always expected: to be told
which register access widths it is permitted to make.

That must include at least one of 8 or 16 bit accesses, but 32-bit
access is optional.

The result will be that - despite I've fixed up all the static platform
data to be correct, there's no way to fix up the DT binding without
inventing a new one.

So, deleting the Realview (and other) board files results in platforms
that can't use networking - it's worse than that, because the smc91x
driver will BUG() as a result of this at boot time.

Since the patch in my tree is fixing a regression caused by the broken
conversions, I'm not mindful to drop it from the merge window - I
actually want to push it into -rc kernels.  We _do_ need to fix the
DT regressions, and quickly though, and push those with this patch.

Since I don't use the SMC91x with DT, that's outside of what I can
test, so consider this a call for help on that subject.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
