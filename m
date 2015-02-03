From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Feb 2015 20:10:38 +0100
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <30242.1422976483@warthog.procyon.org.uk>
References: <20150202193154.GC10842@pengutronix.de>
 <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <30242.1422976483@warthog.procyon.org.uk>
Message-ID: <20150203191038.GF10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[added some more context again]

On Tue, Feb 03, 2015 at 03:14:43PM +0000, David Howells wrote:
> > > -     *p  |= mask;
> > > +     if ((*p & mask) == 0)
> > > +             *p  |= mask;
> > Care to fix the double space here while touching the code?
> > 
> > I think the more natural check here is:
> > 
> >         if ((~*p & mask) != 0)
> >                 *p |= mask;
> >
> > Might be a matter of taste, but this check is equivalent to
> > 
> > 	*p != (*p | mask)
> > 
> > which is what you really want to test for.
> I would argue that this is less clear as to what's going on.
OK, I admit that this equivalence is not obvious. Then maybe let the
compiler find the equivalence and do:

-	*p  |= mask;
+	if (*p != (*p | mask))
+		p |= mask;

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
