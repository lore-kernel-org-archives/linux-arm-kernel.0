From: thierry.reding@gmail.com (Thierry Reding)
Date: Sun, 21 Jul 2013 08:35:34 +0200
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <20130720054439.308B33E13F0@localhost>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>
 <20130709070541.GQ516@pengutronix.de>
 <51DBBFDA.70302@freescale.com>
 <20130709075124.GR516@pengutronix.de>
 <51DBC58D.90002@freescale.com>
 <20130720054439.308B33E13F0@localhost>
Message-ID: <20130721063531.GA16516@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 06:44:39AM +0100, Grant Likely wrote:
> On Tue, 9 Jul 2013 16:10:53 +0800, Huang Shijie <b32955@freescale.com> wrote:
> > ? 2013?07?09? 15:51, Sascha Hauer ??:
> > > On Tue, Jul 09, 2013 at 03:46:34PM +0800, Huang Shijie wrote:
> > >> ? 2013?07?09? 15:05, Sascha Hauer ??:
> > >>> Why don't you set the matching order in the driver the way you want it
> > >>> to be, i.e.:
> > >>>
> > >>> 	{ .compatible = "fsl,imx6q-uart", ... },
> > >>> 	{ .compatible = "fsl,imx21-uart", ... },
> > >>> 	{ .compatible = "fsl,imx1-uart", ... },
> > >>>
> > >> yes. i can set it like this.
> > >>
> > >> but this method looks like a ugly workaround.
> > > If a driver has different ways of supporting a single device, then
> > > putting the preferred or most feature rich on top doesn't look very ugly
> > > to me.
> > this method makes it much _coupled_ between the driver and the dts file.
> > 
> > IMHO, it's an unnecessary _burden_ to the driver programmer:
> >     he should puts the most feature compatible on the top.
> > 
> > it's much graceful if we let the driver programmer be transparent about 
> > this.
> 
> Absolutely true. Applied, thanks.

I don't think this will work. The patch looks very similar to one that I
posted about a year ago (commit 107a84e "of: match by compatible
property first"). The problem it was trying to address was exactly the
same. However the patch caused regressions on SPARC and had to be
reverted in commit bc51b0c "Revert "of: match by compatible property
first"".

The revert commit quotes Rob having a fix for this, and I remember that
I pinged him about it occasionally, but I suspect that those must have
fallen through the cracks.

Grant, before applying this patch we should make sure that it doesn't
cause a regression again, so perhaps asking Meelis Roos (mentioned in
the revert commit) to test would be good. I have a strong feeling that
this patch will break in the same way than mine did a year ago, because
it looks too similar and doesn't handle the compatible & name
combination that Rob mentioned.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130721/282471db/attachment.sig>
