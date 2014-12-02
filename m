From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 10:33:32 +0100
Subject: [PATCH] ARM: rockchip: Convert resume code to C
In-Reply-To: <CAD=FV=VT7gr504-ZgWPfha+40XDX5eShkzZ36bg=-4Oub1S27w@mail.gmail.com>
References: <1417461694-5129-1-git-send-email-dianders@chromium.org>
 <20141201225057.GA11285@n2100.arm.linux.org.uk>
 <CAD=FV=VT7gr504-ZgWPfha+40XDX5eShkzZ36bg=-4Oub1S27w@mail.gmail.com>
Message-ID: <25485084.A6ydfR9Xle@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 15:04:59 Doug Anderson wrote:
> Russel,
> 
> On Mon, Dec 1, 2014 at 2:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > What I see here is a load of complexity which achieves very little.
> > The result doesn't get rid of much assembly, but it does make stuff
> > more complicated.  And the diffstat speaks volumes about this:
> >
> >  10 files changed, 275 insertions(+), 94 deletions(-)
> >
> > There's a lot of words in the description, but it's missing the most
> > important bit: why do we want to take this approach - what benefits
> > does it bring?
> 
> Sure.  I guess the most important words in the description are:
> 
> > We convert the existing assembly resume code into C as proof that this
> > works and to prepare for linking in SDRAM reinit code.
> 
> I can't say that the SDRAM reinit code is ready for prime time yet,
> but you can get a preview of what it could look like at:
> 
> https://chromium-review.googlesource.com/#/c/227366/25/arch/arm/mach-rockchip/embedded/rk3288_ddr_resume.c
> 
> Adding that code in assembly seems like a very, very bad idea.
> Certainly my patch could wait until the DDR code is ready to be posted
> upstream if that made sense.  One advantage of waiting is that it's
> possible that the DDR code might end up moving elsewhere if it made
> sense to have it part of a memory controller driver or something like
> that.

I recently looked at another vendor tree (quantenna wifi access point,
based on arch/arc), which was putting arbitrary functions into SRAM
for performance reasons, in their case the entire hot path for network
switching. Having at least the infrastructure to do this seems like
a great idea, even though it's very hard to do in a general-purpose
kernel, as you'd have a hard time squeezing as much code as possible
into the available SRAM.

Unfortunately you already said that you're not that interested in
making it completely generic, and I also don't think I want to have
the infrastructure for it in mach-rockchip and would want to see that
at least shared across arch/arm if it's too hard to do
cross-architecture. If you were to include code from drivers/memory/
in the blob, you couldn't keep it in mach-rockchip anyway.

AFAICT, the quantenna implementation is similar to the itcm/dtcm
stuff we already have (but are not using upstream), so I wonder
why we can't use that here too, see Documentation/arm/tcm.txt

	Arnd
