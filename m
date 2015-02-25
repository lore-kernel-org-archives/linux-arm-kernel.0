From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Feb 2015 22:15:45 +0100
Subject: [PATCH V6 00/12] Tegra xHCI support
In-Reply-To: <CAL1qeaEmSphLd=k3f6865OEO_rcwO3+Hv5KDvCN2_=7nDdZJzA@mail.gmail.com>
References: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
 <20150225160110.GA26610@ulmo>
 <CAL1qeaEmSphLd=k3f6865OEO_rcwO3+Hv5KDvCN2_=7nDdZJzA@mail.gmail.com>
Message-ID: <20150225211539.GA7884@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 09:27:36AM -0800, Andrew Bresticker wrote:
> Hi Thierry,
> 
> > Sorry for taking so awfully long to look at this. I've spent some time
> > looking at various pieces of documentation and I concluded that
> > representing the port assignment as muxing options doesn't seem right
> > after all. Instead I've come up with an alternate proposal (attached).
> > Could you take a look and see if that sounds reasonable to you?
> 
> Thanks for taking a look at this.  I've been meaning to pick this
> series back up, but haven't had quite enough bandwidth lately.
> 
> This all looks good to me, just one comment below:
> 
> > +PHY nodes:
> > +----------
> > +
> > +An optional child node named "phys" can contain nodes describing additional
> > +properties of each PHY. Only USB3 and UTMI PHYs can be complemented in this
> > +way, in which case the name of each node must match one of the following:
> > +
> > +  usb3-0, usb3-1, utmi-0, utmi-1, utmi-2
> > +
> > +Required properties for USB3 PHYs:
> > +- nvidia,lanes: specifies the name of the lane that this USB3 PHY uses
> > +- nvidia,port: specifies the number of the USB2 port that is used for this
> > +  USB3 PHY
> > +
> > +Optional properties for UTMI PHYs:
> > +- vbus-supply: regulator providing the VBUS voltage for the UTMI pad
> 
> What about the HSIC PHYs?  Shouldn't they be represented as PHY nodes as well?

Yes, they could. The PCIe and SATA PHYs could as well. I haven't
included them because they currently don't take any properties. In
addition to that, perhaps some of the nvidia,hsic-* properties could be
moved into the PHY nodes, too. But they're also properties of the pin,
so keeping them in the pinmux nodes seems fine as well.

On a slightly different topic, I've been trying to wrap my head around
the use of the nvidia,port property and my conclusion was that in fact
one of the physical ports is shared between USB2 and USB3. That is the
utmi-2 PHY and usb3-0 PHY go to the very same port. The vbus-supply
specified in the Jetson TK1 DTS would support that (it's associated with
utmi-2 but named vdd_usb3_reg, and the USB3 port doesn't work without
it). Can you confirm that?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/190dae0a/attachment.sig>
