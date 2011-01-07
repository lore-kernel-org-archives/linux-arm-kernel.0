From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 7 Jan 2011 10:44:49 +0100
Subject: [PATCH v3 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <20110107070056.GA28358@freescale.com>
References: <1294236457-17476-1-git-send-email-shawn.guo@freescale.com>
	<1294236457-17476-6-git-send-email-shawn.guo@freescale.com>
	<20110105163449.GU25121@pengutronix.de>
	<20110106041457.GC17891@freescale.com>
	<20110106071047.GW25121@pengutronix.de>
	<20110107070056.GA28358@freescale.com>
Message-ID: <20110107094448.GB25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 07, 2011 at 03:00:57PM +0800, Shawn Guo wrote:
> On Thu, Jan 06, 2011 at 08:10:47AM +0100, Uwe Kleine-K?nig wrote:
> > Hello Shawn,
> > 
> [...]
> > > > > +     /*
> > > > > +      * enet-mac reset will reset mac address registers too,
> > > > > +      * so need to reconfigure it.
> > > > > +      */
> > > > > +     if (fec_is_enetmac) {
> > > > > +             memcpy(&temp_mac, dev->dev_addr, ETH_ALEN);
> > > 		  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > +             writel(cpu_to_be32(temp_mac[0]), fep->hwp + FEC_ADDR_LOW);
> > > > > +             writel(cpu_to_be32(temp_mac[1]), fep->hwp + FEC_ADDR_HIGH);
> > > > where is the value saved to temp_mac[]?  For me it looks you write
> > > > uninitialized data into the mac registers.
> > > 
> > > memcpy above.
> > oops.  right.  I looked for something like
> > 
> > 	temp_mac[0] = dev->dev_addr[0] << $shiftfor0 | ...
> > 
> > which AFAIK is what you want here.  memcpy is sensible to (at least)
> > endian issues.  If you ask me factor out the setting of the mac address
> > in probe to a function and use that here, too.
> > 
> The memcpy of mac address is being widely used in fec and other
> network drivers, and I do not prefer to change something so common
> in this patch set.
Hmm, fec_get_mac uses memcpy as does fec_set_mac_address.
fec_enet_init uses mask and shift.  When writing my comment I only saw
the latter.  Having that uniform and only in two places (one for setting
and for reading) would be great.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
