From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 13 Oct 2011 09:48:08 +0800
Subject: [RFC][PATCH] plat-mxc: iomux-v3.h: implicitly enable
	pull-up/down when that's desired
In-Reply-To: <20111012082702.GM13898@pengutronix.de>
References: <201110100758.p9A7wCYT011235@home.pavel.comp>
	<20111012082702.GM13898@pengutronix.de>
Message-ID: <20111013014807.GA27048@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 10:27:02AM +0200, Sascha Hauer wrote:
> On Mon, Oct 10, 2011 at 11:19:23AM +0400, Paul Fertser wrote:
> > To configure pads during the initialisation a set of special constants
> > is used, e.g.
> > #define MX25_PAD_FEC_MDIO__FEC_MDIO IOMUX_PAD(0x3c4, 0x1cc, 0x10, 0, 0, PAD_CTL_HYS | PAD_CTL_PUS_22K_UP)
> > 
> > The problem is that no pull-up/down is getting activated unless both
> > PAD_CTL_PUE (pull-up enable) and PAD_CTL_PKE (pull/keeper module
> > enable) set. This is clearly stated in the i.MX25 datasheet and is
> > confirmed by the measurements on hardware. This leads to some rather
> > hard to understand bugs such as misdetecting an absent ethernet PHY (a
> > real bug i had), unstable data transfer etc. This might affect mx25,
> > mx35, mx50, mx51 and mx53 SoCs.
> > 
> > It's reasonable to expect that if the pullup value is specified, the
> > intention was to have it actually active, so we implicitly add the
> > needed bits.
> > 
> > Cc: stable at kernel.org
> > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> > ---
> > 
> > I'm not sure if that's really suitable for -stable so please excuse me
> > if it's not.
> 
> I think it's not suitable for stable unless there is a real bug, that
> is PUE or PKE are forgotten somewhere.
> 
It seems that the example of MX25_PAD_FEC_MDIO__FEC_MDIO Paul put in
the commit message is a real bug.

$ git grep -n MX25_PAD_FEC_MDIO__FEC_MDIO arch/arm
arch/arm/mach-imx/mach-eukrea_cpuimx25.c:50:    MX25_PAD_FEC_MDIO__FEC_MDIO,
arch/arm/mach-imx/mach-mx25_3ds.c:52:   MX25_PAD_FEC_MDIO__FEC_MDIO,
arch/arm/plat-mxc/include/mach/iomux-mx25.h:419:#define MX25_PAD_FEC_MDIO__FEC_MDIO     IOMUX_PAD(0x3c4, 0x1cc, 0x10, 0, 0, PAD_CTL_HYS | PAD_CTL_PUS_22K_UP)

-- 
Regards,
Shawn
