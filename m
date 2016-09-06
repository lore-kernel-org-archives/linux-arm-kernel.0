From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 11:42:32 +0100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <7417301.9zVsJPTCb3@wuerfel>
References: <20160905105803.13ed27ff@canb.auug.org.au>
 <20160905182603.GS1041@n2100.armlinux.org.uk>
 <7417301.9zVsJPTCb3@wuerfel>
Message-ID: <20160906104232.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 12:17:48PM +0200, Arnd Bergmann wrote:
> On Monday, September 5, 2016 7:26:03 PM CEST Russell King - ARM Linux wrote:
> > On Mon, Sep 05, 2016 at 10:58:03AM +1000, Stephen Rothwell wrote:
> > > I fixed it up (I deleted the file) and can carry the fix as
> > > necessary. This is now fixed as far as linux-next is concerned, but any
> > > non trivial conflicts should be mentioned to your upstream maintainer
> > > when your tree is submitted for merging.  You may also want to consider
> > > cooperating with the maintainer of the conflicting tree to minimise any
> > > particularly complex conflicts.
> > 
> > That's the "simple" way of making the conflict go away, but I'm afraid
> > it's really not that simple.
> > 
> > Having just looked at the SMC91x definition for realview, it shows that
> > the SMC91x binding, like many of the conversions that the patch in my
> > tree fixes, has been created without a proper understanding of the
> > hardware.  To put it simply, it is broken.
> > 
> > The binding only allows _one_ register width to be specified, which is
> > completely incorrect: the binding _must_ allow multiple register widths
> > to be specified.  This is what SMC91x has always expected: to be told
> > which register access widths it is permitted to make.
> 
> This is what is documented:
> 
> Documentation/devicetree/bindings/net/smsc-lan91c111.txt
> - reg-io-width : Mask of sizes (in bytes) of the IO accesses that
>   are supported on the device.  Valid value for SMSC LAN91c111 are
>   1, 2 or 4.  If it's omitted or invalid, the size would be 2 meaning
>   16-bit access only.
> 
> and this appears to match what the driver does, although it is a
> rather unconventional definition (I would have expected an array
> of widths in bytes).

It doesn't match what the driver does - have you not been following the
discussion on the breakage caused by your commit b70661c70830 ?

> Almost all of the users leave out the property, so they get 16-bit
> access, nomadik-nhk15 is the only one that actually specifies
> the width explicitly, and it also requests 16-bit only. I don't
> think your patch changes anything for these cases.

Okay, so all the DT users _only_ use 16-bit accesses, and end up
_emulating_ 8-bit accesses through a 16-bit read-modify-write
sequence, even when they may be perfectly capable of 8-bit accesses,
because this fine detail of the SMC91x driver hasn't been understood.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
