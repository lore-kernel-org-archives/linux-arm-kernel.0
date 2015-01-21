From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jan 2015 10:09:16 +0100
Subject: [PATCH v2 0/3] ARM: mvebu: Enable XHCI on the Armada 385 AP
In-Reply-To: <20150120204307.GC13365@lunn.ch>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150119213507.GC2938@lunn.ch> <20150120203028.GZ4367@lukather>
 <20150120204307.GC13365@lunn.ch>
Message-ID: <20150121090916.GD4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 09:43:07PM +0100, Andrew Lunn wrote:
> On Tue, Jan 20, 2015 at 09:30:28PM +0100, Maxime Ripard wrote:
> > Hi Andrew,
> > 
> > On Mon, Jan 19, 2015 at 10:35:07PM +0100, Andrew Lunn wrote:
> > > On Mon, Jan 19, 2015 at 02:01:11PM +0100, Maxime Ripard wrote:
> > > > Hi all,
> > > > 
> > > > This serie enables the Armada 385 AP XHCI controller.
> > > > 
> > > > Since the controller uses a GPIO-controlled VBUS, we used the
> > > > phy-generic driver, and made the needed additions to the xhci-plat
> > > > driver to retrieve a USB phy.
> > > > 
> > > > Unfortunately, some glitches were also found along the way, mostly
> > > > because of the probe deferring that was introduced by this phy
> > > > retrieval.
> > > > 
> > > > Since the introduction of the Armada 38x support in 3.16, the driver
> > > > was attempting to write into registers while the clock wasn't enabled
> > > > yet. This was working because the bootloader left it enabled, but in
> > > > the case of a deferred probing, the clock would have been disabled by
> > > > the error path of our driver, and this would fail. This should go in
> > > > 3.19, and any stable kernel for 3.16+.
> > > > 
> > > > The two patches remaining are "regular" patches, and are aimed at
> > > > 3.20. The last patch depend on my previous serie to introduce support
> > > > for the the A385 AP board.
> > > 
> > > Hi Maxime
> > > 
> > > I assume you want me to take 3/3? Any other route is not simple, since
> > > this file only exists in mvebu/dt and maybe a staging branch of
> > > arm-soc.
> > >
> > > What route do you think the other patches will take?
> > 
> > There should be no merge dependency, but merging the third patch alone
> > will probably result on a boot breakage. I don't think it really
> > matters though, since this is a new board, so I guess it can go
> > through the USB-PHY tree.
> 
> Hi Maxime
> 
> Humm, maybe i'm wrong, but i think
> 
> arch/arm/boot/dts/armada-385-db-ap.dts
> 
> only exists in the mvebu tree?
> 
> At least, i don't see it here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/tree/arch/arm/boot/dts?h=next

Yeah, but my point was that if you merge the DT bits, without having
the PHY driver quirks fix in your tree, you'll result in a kernel that
doesn't boot at all on that board.

But again, since this is a new board, I don't really see why you would
want to bisect that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/f049a3da/attachment.sig>
