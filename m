From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 17:31:30 +0100
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <20140212161206.GD25957@e106331-lin.cambridge.arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <1786282.mNUF0ZaUg2@wuerfel>
 <20140212161206.GD25957@e106331-lin.cambridge.arm.com>
Message-ID: <12776368.fUp5TWIUAS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 16:12:06 Mark Rutland wrote:
> On Wed, Feb 12, 2014 at 01:03:26PM +0000, Arnd Bergmann wrote:
> > On Wednesday 12 February 2014 11:47:40 Mark Rutland wrote:

> From a quick grep, for pl022's SSPCLK we currently have the strings:
> 
> * ssp{0,1}clk
> * spi_clk
> * spi{0,1,2,3}clk
> 
> Though I may have missed a string or two where nodes get amended in more
> specific files. A grep for apb_clk to find neighbours didn't highlight
> any obvious ones.

Ok. Both ssp{0,1}clk and spi{0,1,2,3}clk /only/ appear in
arch/arm/boot/dts/ste-dbx5x0.dtsi and are clearly a bug, so unless
Linus Walleij has objections, I'd declare those to be bugs that
should be fixed by changing the DT file to spi_clk.

> > I noticed that ux500 has uses four different strings, one for each
> > instance, which is obviously a bug and should just be fixed. There is
> > no way this was intentional, and we can just rely on teh fallback
> > if you want to have that anyway.
> 
> Sure, I'll fix those up once we have a preferred name. I guess this
> would be SSPCLK by Russell's comments, I wasn't able to find a prior use
> in the git history, but it would be in keeping with KMIREFCLK as used by
> the pl050 driver.

We do have a few cases of spi_clk, so I'd use that one. Ideally it
should be the string given in the data sheet for the IP block of course,
possibly with capital letters and underscores turned converted to
more regular strings.

> > > I assume that for the non-dt case it's possible to name clock inputs to
> > > a device without the clock being associated with the name globally? If
> > > so we could get rid of the index usage entirely in this case.
> > 
> > Sorry, I don't understand the question.
> 
> I thought one of the issues before dt was that clocks were in a global
> namespace. Mark's reply implies that's not necessarily the case, so I'll
> take a tour through clkdev to educate myself.

The whole point of clkdev is to create a local per-device namespace
so drivers don't need to care about the global names, as far as I understand
it.

	Arnd
