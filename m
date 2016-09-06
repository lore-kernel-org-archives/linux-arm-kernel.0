From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2016 12:17:48 +0200
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <20160905182603.GS1041@n2100.armlinux.org.uk>
References: <20160905105803.13ed27ff@canb.auug.org.au>
 <20160905182603.GS1041@n2100.armlinux.org.uk>
Message-ID: <7417301.9zVsJPTCb3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 5, 2016 7:26:03 PM CEST Russell King - ARM Linux wrote:
> On Mon, Sep 05, 2016 at 10:58:03AM +1000, Stephen Rothwell wrote:
> > I fixed it up (I deleted the file) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> 
> That's the "simple" way of making the conflict go away, but I'm afraid
> it's really not that simple.
> 
> Having just looked at the SMC91x definition for realview, it shows that
> the SMC91x binding, like many of the conversions that the patch in my
> tree fixes, has been created without a proper understanding of the
> hardware.  To put it simply, it is broken.
> 
> The binding only allows _one_ register width to be specified, which is
> completely incorrect: the binding _must_ allow multiple register widths
> to be specified.  This is what SMC91x has always expected: to be told
> which register access widths it is permitted to make.

This is what is documented:

Documentation/devicetree/bindings/net/smsc-lan91c111.txt
- reg-io-width : Mask of sizes (in bytes) of the IO accesses that
  are supported on the device.  Valid value for SMSC LAN91c111 are
  1, 2 or 4.  If it's omitted or invalid, the size would be 2 meaning
  16-bit access only.

and this appears to match what the driver does, although it is a
rather unconventional definition (I would have expected an array
of widths in bytes).

Almost all of the users leave out the property, so they get 16-bit
access, nomadik-nhk15 is the only one that actually specifies
the width explicitly, and it also requests 16-bit only. I don't
think your patch changes anything for these cases.

	Arnd
