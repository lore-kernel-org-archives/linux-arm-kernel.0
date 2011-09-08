From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 8 Sep 2011 09:53:40 +0100
Subject: [RFC PATCH 1/3] ARM: iwmmxt: Fix Makefile rules for building
	iwmmxt for Thumb-2
In-Reply-To: <1372213.9xxOYOJ3Ii@wuerfel>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
	<CAMPhdO8tv9aFNcghySViCrTt97jzEw5rPfKo6AaU9DrQ32tTJA@mail.gmail.com>
	<alpine.LFD.2.00.1109071306530.20358@xanadu.home>
	<1372213.9xxOYOJ3Ii@wuerfel>
Message-ID: <20110908085340.GA2070@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 10:32:09PM +0200, Arnd Bergmann wrote:
> On Wednesday 07 September 2011 13:18:21 Nicolas Pitre wrote:
> > > > +
> > > > +# When enough people have binutils which support -march=...+iwmmxt, this
> > > > +# should change to something like if __LINUX_ARM_ARCH__ < 7.
> > > > +ifdef CONFIG_THUMB2_KERNEL
> > > > +AFLAGS_iwmmxt.o                        := -Wa,-march=armv7-a+iwmmxt
> > > > +else
> > > >  AFLAGS_iwmmxt.o                        := -Wa,-mcpu=iwmmxt
> > > > +endif
> > > 
> > > It looks more like the switch should depend on the compiler version.
> > > Unless there is a clear way to decide if gcc supports this switch, I
> > > think it's reasonable to have the change like above.
> > 
> > Normally the way to go with gcc version dependent alternatives is to use 
> > something like:
> > 
> > AFLAGS_foo.o := $(call cc-option,<the_new_flag>,<the_fallback_flag>)
> > 
> > This will test if <the_new_flag> is supported by the used gcc, and use 
> > the fallback otherwise.
> 
> Yes, that's possible here, but it's not actually correct either, because the
> CPU core that we are running on is either a v5 XScale with iwmmxt or
> a v7 pj4 with iwmmxt. Now, it should not really matter if we build the
> code with flags for a different more complex instruction set, but it can
> potentially hide bugs.
> 
> I think the simple solution that Dave posted is actually more appropriate.
> The three possible cases are:
> 
> v5+iwmmxt: always use -Wa,-mcpu=iwmmxt as we've always done, and it's correct
> v7+iwmmxt+arm: still use -Wa,-mcpu=iwmmxt, not correct but close enough and
>                is known to build the file with all existing toolchaings
> v7+iwmmxt+thumb2: always use -Wa,-march=armv7-a+iwmmxt, which is correct and
> 		      the only possible way to build this file anyway. Old toolchains
> 		      will fail and there is nothing we can do about it.

There is another option, which is to use cc-option and then check the
result in AFLAGS_iwmmxt.o, throwing an error from the Makefile as
necessary.

I'll have a go at that if nobody has any objections.

There doesn't seem to be any cleaner way to catch this error -- compiler
version issues are invisible to Kconfig.

Cheers
---Dave
