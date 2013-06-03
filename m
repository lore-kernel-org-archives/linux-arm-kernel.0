From: w@1wt.eu (Willy Tarreau)
Date: Mon, 3 Jun 2013 23:04:17 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <alpine.LFD.2.03.1306031500020.1200@syhkavp.arg>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
 <20130603175629.GH5008@1wt.eu> <20130603181437.GO3803@titan.lakedaemon.net>
 <20130603183057.GA9868@1wt.eu>
 <alpine.LFD.2.03.1306031500020.1200@syhkavp.arg>
Message-ID: <20130603210417.GB9868@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 03:01:42PM -0400, Nicolas Pitre wrote:
> On Mon, 3 Jun 2013, Willy Tarreau wrote:
> 
> > Hi Jason,
> > 
> > On Mon, Jun 03, 2013 at 02:14:37PM -0400, Jason Cooper wrote:
> > > > I understand your points, but then what could we do to get our devices
> > > > to have properly working ethernet interfaces ? These devices have already
> > > > been sold, and from what I've seen they've been using this ID since at
> > > > least the Kirkwood devices.
> > > > 
> > > > I found no other way to get the MAC address once the system is booted.
> > > > I would have no problem having some board-spec code locate the atags
> > > > and set the MAC, but it looks like the information is lost very early
> > > > and is not available anymore soon after the boot (or at least I couldn't
> > > > find it anywhere else).
> > > > 
> > > > It's really not with happiness that I had to add this part to the ATAGs,
> > > > but because I didn't find another solution :-(
> > > 
> > > Please take a look at Sebastian's approach, it's currently a wip:
> > > 
> > >   ARM: kirkwood: proper retain MAC address workaround on DT ethernet
> > > 
> > > The discussion following that patch should give you some good ideas.
> > 
> > I remember this discussion, but it is different and does not apply here.
> > Sebastian fixed an issue with a properly configured NIC which used to
> > lose its MAC, so the solution consisted in saving it early in the DT.
> > 
> > In the mv_neta case, the NICs are not configured yet and we need to
> > find the MAC somewhere. I only found it in the ATAGs and nowhere else.
> > Well, in fact u-boot sets it on the MAC used to boot from the network
> > if such a boot is performed, but that's all. So in practice you boot
> > without the MAC address anywhere but in the ATAGs. I'd be happy to
> > find a way to parse non-standard atags in a board-specific file but
> > they're lost early it seems :-(
> 
> Those MAC addresses must exist somewhere before they're wrapped into 
> some special ATAG.  They're certainly not hardcoded into the u-boot 
> binary.

Indeed, they're on the u-boot environment. But I don't think that it
really helps, because the variables in RAM are most likely lost and
anyway not well structured, and the ones on the flash require a
properly working flash driver before being extracted (not to mention
that they're the stored ones, not the active ones, but that's just
nitpicking).

Best regards,
Willy
