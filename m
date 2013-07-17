From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 13:07:58 +0100
Subject: [PATCH v1 01/24] spi: mpc512x: prepare clocks before enabling them
In-Reply-To: <20130717112229.GK7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-2-git-send-email-gsi@denx.de>
 <20130715201734.GF11538@sirena.org.uk>
 <20130717112229.GK7080@book.gsilab.sittig.org>
Message-ID: <20130717120758.GR22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 01:22:29PM +0200, Gerhard Sittig wrote:
> On Mon, Jul 15, 2013 at 21:17 +0100, Mark Brown wrote:
> > On Mon, Jul 15, 2013 at 08:47:30PM +0200, Gerhard Sittig wrote:

> > >   sprintf(name, "psc%d_mclk", master->bus_num);
> > >  	spiclk = clk_get(&master->dev, name);
> > > -	clk_enable(spiclk);
> > > +	clk_prepare_enable(spiclk);
> > >  	mps->mclk = clk_get_rate(spiclk);
> > >  	clk_put(spiclk);

> > This code is *clearly* buggy and should be fixed rather than papered
> > over.  Not only is there no matching put the driver is also dropping the
> > reference to the clock rather than holding on to it while it's in use.

> "This code" refers to the driver's original condition, right?  I
> agree that the driver has been suffering from incomplete clock
> handling since it was born three years ago.  And that this issue
> shall get addressed.  The question is just whether it needs to be
> part of this series which has a different focus.

This is a pretty long e-mail.  It'd probably have taken less time to
fix the issues than to reply to the e-mail...  but anyway.

A big part of the issue with the state of the driver is that there's
obvious clock API abuse going on that isn't corrected here - the main
one is that the sprintf() for the clock name is a fairly clear warning
sign, the driver should be using a fixed value there.  This raises a
warning flag for me about the quality of the common clock API
implementation that's being sent and/or the potential for bugs to be
noticed with the common clock framework.  I'd not expect this code to
actually work, and looking at the rest of the series I don't see how it
does since I can't see what forces the name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/245057e2/attachment-0001.sig>
