From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jun 2017 21:00:48 +0100
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <20170609064019.GB31464@kwain>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
 <20170608160331.GA20216@lunn.ch> <20170609064019.GB31464@kwain>
Message-ID: <20170609200047.GV4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 08:40:19AM +0200, Antoine Tenart wrote:
> Hi Andrew,
> 
> On Thu, Jun 08, 2017 at 06:03:31PM +0200, Andrew Lunn wrote:
> > On Thu, Jun 08, 2017 at 11:26:52AM +0200, Antoine Tenart wrote:
> > > +#define MVMDIO_XSMI_MGNT_REG		0x0
> > > +#define  MVMDIO_XSMI_READ_VALID		BIT(29)
> > > +#define  MVMDIO_XSMI_BUSY		BIT(30)
> > > +#define MVMDIO_XSMI_ADDR_REG		0x8
> > > +#define  MVMDIO_XSMI_PHYADDR_SHIFT	16
> > > +#define  MVMDIO_XSMI_DEVADDR_SHIFT	21
> > > +#define  MVMDIO_XSMI_READ_OPERATION	(0x7 << 26)
> > > +#define  MVMDIO_XSMI_WRITE_OPERATION	(0x5 << 27)
> > 
> > These two operations seem odd. Generally ops have the same shift.
> 
> Indeed, this is odd. I'll have a look at this.

The Marvell driver uses 5 << 26:

+#define XOPCODE_OFFS           26
+#define XOPCODE_ADDR_READ      (7 << XOPCODE_OFFS)
+#define XOPCODE_ADDR_WRITE     (5 << XOPCODE_OFFS)

What this means is that with the incorrect shift in your driver,
although writes appeared to work, they actually resulted in a
post-read-increment-address frame (and hence no error.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
