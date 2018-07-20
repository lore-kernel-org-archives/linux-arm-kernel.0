From: jacopo@jmondi.org (jacopo mondi)
Date: Fri, 20 Jul 2018 09:02:55 +0200
Subject: [RFC] ARM: imx6q: add ENET_CLK_SEL mux option
In-Reply-To: <20180720031249.GB4576@dragon>
References: <1532029693-22764-1-git-send-email-jacopo@jmondi.org>
 <20180720031249.GB4576@dragon>
Message-ID: <20180720070255.GE6784@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,
  thanks for the reply.

On Fri, Jul 20, 2018 at 11:12:50AM +0800, Shawn Guo wrote:
> On Thu, Jul 19, 2018 at 09:48:13PM +0200, Jacopo Mondi wrote:
> > This is just an attempt to set IOMUX_GPR1[21] bit...
> >
> > Not-Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> >
> > ---
> > Hello imx people (recipients list comes from get_maintainer script)
> >
> >    I'm very new to this platform, so pardon me if I'm asking a question here,
> > more than sending an actual patch.
> >
> > Context: I have a board that needs bit 21 of register IOMUX_GPR1 set.
> > This basically tells the SoC to use an internally generated clock as clock
> > reference for the external PHY chip.
>
> I think this has been handled as the default setup by function
> imx6q_1588_init() in arch/arm/mach-imx/mach-imx6q.c.  Basically, it
> checks 'ptp' clock setting in FEC node.  If it's the internal clock
> 'enet_ref', the function will set IOMUX_GPR1[21] bit.  For those board
> designs using external OSC, they should overwrite the FEC node clocks
> setting in their board level DTS to get 'ptp' clock point to the
> external OSC.  The imx6qdl-icore.dtsi is such an example.

Indeed! I went to far with all that muxing then :)

I now have the PHY correctly identified, by providing CLK_ENET_REF as
ptp clock source:

SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)

It still seems not to transmit or receive packets, but that's indeed a
step forward!

Thanks
   j

>
> Shawn
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180720/171c5284/attachment.sig>
