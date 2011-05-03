From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 May 2011 11:25:36 +0100
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <BANLkTikd_u0+yyFYG_0FR--430z=LQ61Ww@mail.gmail.com>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110429075346.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104290814380.24613@xanadu.home>
	<20110429133340.GN5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291514390.24613@xanadu.home>
	<BANLkTikd_u0+yyFYG_0FR--430z=LQ61Ww@mail.gmail.com>
Message-ID: <20110503102536.GC27833@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2011 at 01:44:15AM -0700, Brian Swetland wrote:
> On Fri, Apr 29, 2011 at 12:43 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:

> >> It doesn't _matter_ how it is represented, it will continue to be patched
> >> whether it's structures in a .c file (as it currently is) or whether it's
> >> a device tree description for each clock.

> > If that is the case, the associated drivers have to change as well to be
> > in sync with the new flags, etc. ??And to me it is way better to have
> > both the data and the drivers maintained in a single place compared to
> > the unavoidable bugs that will crop up due to version skews.

> This is a one reason why I'm skeptical of the "device tree" approach
> and somewhat concerned about a potential future where board files
> would vanish, to be replaced by device trees which may well come from
> some place disconnected from the kernel that will depend on them being
> correct to work.

I agree for that particular argument for device tree - I've had to push
back on some of the audio drivers that use device tree currently, the
maintainers were trying to push changes which would result in an
immediate ABI break in the device tree files.  That sort of stuff is
completely insane 

This sort of stuff is the major reason for supporting multiple DT blobs
- it allows the descriptions of the chip internals outside of the per
board device tree so we could ship that bit in the kernel (I know Russel
is pushing back against that right now but...).

> The other reason is that I've rarely seen a board spin that didn't
> involve some quirky change that would be hard to represent in a static
> configuration format.  Oh, you need to power up this level shifter
> before you can talk to the back half of that i2c bus, by way of this
> gpio over here?  Eventually you end up with something like a byte-code
> or forth runtime to handle these cases and then things really get fun
> from the "where's the code that does what?!" standpoint.

This sort of thing is more a problem in the smartphone space - they're
generally pushing pretty much any limit you can think of here.  For 
lower complexity/density designs it tends to be more plausible to just
describe the system this way.

My expectation is that device tree will help quite a lot with designs
that don't push the limits quite so hard, which there are quite a lot of
out there.
