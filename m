From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 11:29:12 +0100
Subject: [PATCH RFC 24/30] net: fec: better implementation of iMX6
 ERR006358 quirk
In-Reply-To: <20140622084911.GD32514@n2100.arm.linux.org.uk>
References: <20140620121118.GR32514@n2100.arm.linux.org.uk>
 <E1WxxhR-0005YP-Q1@rmk-PC.arm.linux.org.uk>
 <316b383d2512440db51ea7c55992920d@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140622081234.GB32514@n2100.arm.linux.org.uk>
 <56f5e44adf0b41a0bbf52c38b755afbd@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140622084911.GD32514@n2100.arm.linux.org.uk>
Message-ID: <20140624102912.GM32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 09:49:11AM +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 22, 2014 at 08:38:49AM +0000, fugang.duan at freescale.com wrote:
> > From: Russell King - ARM Linux <linux@arm.linux.org.uk> Data: Sunday, June 22, 2014 4:13 PM
> > >To: Duan Fugang-B38611
> > >Cc: linux-arm-kernel at lists.infradead.org; netdev at vger.kernel.org
> > >Subject: Re: [PATCH RFC 24/30] net: fec: better implementation of iMX6
> > >ERR006358 quirk
> > >
> > >On Sun, Jun 22, 2014 at 07:49:11AM +0000, fugang.duan at freescale.com wrote:
> > >> From: Russell King <rmk@arm.linux.org.uk> Data: Friday, June 20, 2014
> > >> 8:14 PM
> > >> >To: linux-arm-kernel at lists.infradead.org
> > >> >Cc: Duan Fugang-B38611; netdev at vger.kernel.org
> > >> >Subject: [PATCH RFC 24/30] net: fec: better implementation of iMX6
> > >> >ERR006358 quirk
> > >> >
> > >> >+
> > >> >+	/* ERR006538: Keep the transmitter going */
> > >> >+	if (fep->dirty_tx != fep->cur_tx &&
> > >> >+	    readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
> > >> >+		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
> > >> > }
> > >> >
> ...
> > >While I agree that we can read back to check whether the device indicates
> > >that transmit is active, there's no point to the other tests.  If there
> > >are entries in the transmit ring but the transmitter indicates that it is
> > >not active, then it is obvious that the bug has been hit.  This is exactly
> > >what my implementation above does.
> > >
> > The condition "fep->dirty_tx != fep->cur_tx" is not only limited for the errata. 
> > I mean only add extra trigger TDAR for the issue.
> 
> Yes, I agree that test is wrong (that's what comes from shuffling the
> patches... subsequent patches modify the indexing mechanism).  It should
> be:
> 
>         if (bdp != fep->cur_tx &&
>             readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
>                 writel(0, fep->hwp + FEC_X_DES_ACTIVE);
> 
> Since "bdp" is the post-incremented dirty_tx pointer, which, when it is
> equal to fep->cur_tx means that the ring is empty.

Any further comments, or do I take the silence to mean that you agree
with the above statement?  I would like to get this settled to I can
spin v2 of this set.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
