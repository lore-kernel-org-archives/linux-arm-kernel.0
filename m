From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Jan 2010 09:14:41 -0800
Subject: [PATCH] ARM: Fix uncompress code compile for different defines
	of static(void)
In-Reply-To: <20100113142614.GA1252@pengutronix.de>
References: <20100113021939.GE2986@atomide.com>
	<20100113084937.GA19352@pengutronix.de>
	<20100113142614.GA1252@pengutronix.de>
Message-ID: <20100113171441.GF2986@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [100113 06:24]:
> Hello,
> 
> On Wed, Jan 13, 2010 at 09:49:37AM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Jan 12, 2010 at 06:19:40PM -0800, Tony Lindgren wrote:
> > > Because of the include of the decompress_inflate.c file from
> > > boot/compress/misc.c, there are different flush() defines:
> > > 
> > > In file included from arch/arm/boot/compressed/misc.c:249:
> > > arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:138:29: error: macro "flush" passed 2 arguments, but takes just 0
> > > 
> > > Fix this by removing the define of flush() in misc.c for
> > > CONFIG_DEBUG_ICEDCC as it's already defined in mach/uncompress.h,
> > > and that is being included unconditionally.
> > > 
> > > Also use a static inline function instead of define
> > > for mach-mxc and mach-gemini to avoid similar bug
> > > for those platforms.
> > As arch/arm/boot/compressed/misc.c is compiled with -Dstatic= and this
> > is AFAIK the only user of uncompress.h I'd skip "static" and/or add a
> > comment telling that static is redundant here.

Maybe we should do another patch for the merge window to remove
the static for flus from all uncompress.h files?

> while reading my reply I noticed that I don't understand the subject.
> "different defines of static(void)"?

Oops, typo. The subject should have been flush(void) instead of
static(void) :)

There's int(*flush)(void*, unsigned int) in lib/decompress_inflate.c,
and there's static inline void flush(void) in uncompress.h.

As decompress_inflate.c is included into misc.c, then the define
flush() do { } while (0) causes confusion.

Regards,

Tony
