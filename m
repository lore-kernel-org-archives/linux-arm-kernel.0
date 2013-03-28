From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 14:47:51 +0000
Subject: [PATCH] clocksource: Fix build in non-OF case
In-Reply-To: <20130328131044.GA18316@opensource.wolfsonmicro.com>
References: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201303281308.22738.arnd@arndb.de>
 <20130328131044.GA18316@opensource.wolfsonmicro.com>
Message-ID: <201303281447.51532.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013, Mark Brown wrote:
> On Thu, Mar 28, 2013 at 01:08:22PM +0000, Arnd Bergmann wrote:
> > On Thursday 28 March 2013, Mark Brown wrote:
> 
> > > That still looks like it'll reference the function?
> 
> > Yes, that is intentional. The idea is to create a reference to the
> > function so gcc doesn't complain about unused symbols if the function
> > gets marked static, but at the same time mark the data structure we
> > define as unused so gcc can drop the structure as well as the function
> > if they are not referenced from anywhere else.  This should let us
> > get away with fewer #ifdef hacks in the code, better build-time coverage
> > but without producing larger object code.
> 
> So GCC is supposed to be smart enough to figure this out and users need
> to not do the ifdefs?  I have to say this does seem a bit surprising
> from a user point of view but it does make sense from a general niceness
> point of view.

Yes, I'm pretty sure that all gcc-4.x versions can do this right at -Os
and -O2 levels. The new gcc-4.8 -Og level may get it wrong but is also
broken for many other things we do in the kernel, just like building with
gcc -O0.

Since we recently introduced the IS_ENABLED() macro to test for preprocessor
symbols, I think there is a general trend away from any #ifdefs in driver
code.

	Arnd
