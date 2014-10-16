From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Oct 2014 15:29:44 +0100
Subject: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9D80CC@AcuExch.aculab.com>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
 <063D6719AE5E284EB5DD2968C1650D6D1C9D80CC@AcuExch.aculab.com>
Message-ID: <20141016142944.GR12379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 10:30:30AM +0000, David Laight wrote:
> > +#ifdef __GNUC__
> >  #if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> >  #error Your compiler is too buggy; it is known to miscompile kernels.
> > -#error    Known good compilers: 3.3
> > +#error    Known good compilers: 3.3, 4.x
> 
> Except that isn't true since 4.8.0 isn't a good compiler.
> 
> > +#endif
> > +#if GCC_VERSION >= 40800 || GCC_VERSION < 40803
> > +#error Your compiler is too buggy; it is known to miscompile kernels
> > +#error and result in filesystem corruption and oopses.
> > +#endif
> >  #endif
> 
> You are mixing the style of the version check.
> Why not the single test:
> #if GCC_VERSION < 30300 || (GCC_VERSION >= 40800 && GCC_VERSION < 40803)
> #error Your compiler is too buggy; it is known to miscompile code.
> #error Known good compilers: 3.3 onwards excluding 4.8.0 through 4.8.2
> #endif

As you have just nicely demonstrated, changing what's already there can
cause unintentional changes to creep in.  The original test tested for
GCC 3 compilers older than GCC 3.3, excluding GCC 2.96 and older.  Your
version blacklists everything before GCC 3.3.

Such a change should be a separate patch.  Moreover, if we really do want
to blacklist all compilers older than GCC 3.3, then that too needs an
explanation in the comments above this block, and in commit message.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
