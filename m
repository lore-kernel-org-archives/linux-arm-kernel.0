From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jan 2016 16:21:54 +0100
Subject: [PATCH 8/9] net: nb8800: avoid uninitialized variable warning
In-Reply-To: <yw1xsi1jjekj.fsf@unicorn.mansr.com>
References: <1453903507-3427225-1-git-send-email-arnd@arndb.de>
 <1453903507-3427225-9-git-send-email-arnd@arndb.de>
 <yw1xsi1jjekj.fsf@unicorn.mansr.com>
Message-ID: <8558854.EA4z9rFkjX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 January 2016 14:13:16 M?ns Rullg?rd wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > The nb8800_poll() function initializes the 'next' variable in the
> > loop looking for new input data. We know this will be called at
> > least once because 'budget' is a guaranteed to be a positive number
> > when we enter the function, but the compiler doesn't know that
> > and warns when the variable is used later:
> >
> > drivers/net/ethernet/aurora/nb8800.c: In function 'nb8800_poll':
> > drivers/net/ethernet/aurora/nb8800.c:350:21: warning: 'next' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Which gcc version is this?  4.9 doesn't warn here, presumably because
> it's clever enough to notice that the offending use of 'next' is under a
> condition that can only be true if the first one was.  Of course fixing
> the code so older compilers don't warn is a good idea.

This was with gcc-5.2.1, but possibly in an unusual kernel configuration.
The only time I see it in my logs was with CONFIG_ARCH_IXP4XX=y, which
has its own mach/io.h and other headers that sometimes override generic
functions with a more elaborate version.

I have another patch for ixp4xx that simplifies its mach/io.h in order to
get rid of other false 'uninitialized use' warnings, but this one still
shows up with that other patch.

> > Changing the 'while() {}' loop to 'do {} while()' makes it obvious
> > to the compiler what is going on so it no longer warns.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Mans Rullgard <mans@mansr.com>

Thanks,

	Arnd
